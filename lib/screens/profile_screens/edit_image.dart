import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:io';

import '../../database/database_helper_profile.dart';

class EditImagePage extends StatefulWidget {
  const EditImagePage({Key? key}) : super(key: key);

  @override
  State<EditImagePage> createState() => _EditImagePageState();
}

class _EditImagePageState extends State<EditImagePage> {
  DatabaseHelperProfile? _database;
  bool ban = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _database = DatabaseHelperProfile();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController txtFecha = TextEditingController();
    TextEditingController txtDesc = TextEditingController();
    int idUsuario = 0;
    String? imagePath;
    String? imagePathA;
    File? _image;
    if (ModalRoute.of(context)!.settings.arguments != null) {
      final usuario = ModalRoute.of(context)!.settings.arguments as Map;
      ban = true;
      idUsuario = usuario['idUsuario'];
      txtDesc.text = usuario['image'];
      imagePathA = usuario['image'];
    }

    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Editar foto'),
        ),
        body: ListView(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * .05),
          children: [
            CircleAvatar(
              radius: 90,
              /*backgroundImage: imagePathA != ""
                  ? NetworkImage('${imagePath}')
                  : NetworkImage('https://cdn-icons-png.flaticon.com/512/147/147144.png'),*/
              child: imagePathA!.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(75),
                      child: Image.file(File(imagePathA)),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(75),
                      child: Image.network(
                          'https://webstockreview.net/images/banana-clipart-logo-9.png'),
                    ),
            ),
            /*imagePathA != ""
                ? Image.file(
                    File(imagePath),
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                  )
                : const Image(
                    height: 200,
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        'https://cdn-icons-png.flaticon.com/512/147/147144.png'),
                  )*/
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 90),
              child: const Text(
                'Editar imagen de perfil',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 140),
              child: const Text(
                'Seleccionar: ',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 120.0),
                  child: IconButton(
                    onPressed: () async {
                      final picker = new ImagePicker();
                      final PickedFile? pickedFile = await picker.getImage(
                          source: ImageSource.gallery, imageQuality: 100);
                      if (pickedFile == null) {
                        print('No seleccionó nada');
                        return;
                      }

                      print(pickedFile.path);
                      imagePath = pickedFile.path;

                      //setState(() {});
                    },
                    icon: Icon(Icons.photo_album_outlined,
                        size: 40, color: Colors.black),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    final picker = new ImagePicker();
                    PickedFile? pickedFile = await picker.getImage(
                        // source: ImageSource.gallery,
                        source: ImageSource.camera,
                        imageQuality: 80);

                    if (pickedFile == null) {
                      print('No seleccionó nada');
                      return;
                    }

                   
                    print(pickedFile.path);
                    imagePath = pickedFile.path;
                    //setState(() {});
                    // txtDesc.text = imagePath.toString();
                  },
                  icon: Icon(Icons.camera_alt_outlined,
                      size: 40, color: Colors.black),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              // child: txtDescTask,
            ),
            ElevatedButton(
              onPressed: () {
                if (imagePath != null) {
                  _database!.actualizar({
                    'idUsuario': 1,
                    'image': imagePath,
                  }, 'tblUsuario').then(
                    (value) {
                      Alert(
                        context: context,
                        title: "Error :(",
                        desc: "Verificar correo, o que la contraseña coincida",
                        image: Image.asset("assets/close.png"),
                        buttons: [
                          DialogButton(
                            child: Text(
                              "Reintentar",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            onPressed: () => Navigator.pop(context),
                            color: Colors.lightBlue,
                            radius: BorderRadius.circular(0.0),
                          ),
                        ],
                      ).show();
                      final snackbar = SnackBar(
                          content: Text('Imagen actualizada correctamente'));
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      setState(() {});
                    },
                  );
                } else {
                  Alert(
                    context: context,
                    title: "Error :(",
                    desc: "Verificar correo, o que la contraseña coincida",
                    image: Image.asset("assets/close.png"),
                    buttons: [
                      DialogButton(
                        child: Text(
                          "Reintentar",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () => Navigator.pop(context),
                        color: Colors.lightBlue,
                        radius: BorderRadius.circular(0.0),
                      ),
                    ],
                  ).show();
                  final snackbar = SnackBar(content: Text('Ocurrio un error'));
                  ScaffoldMessenger.of(context).showSnackBar(snackbar);
                }

                Navigator.pop(context);
                //initState();
              },
              child: Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
