import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';

import '../../database/database_helper_profile.dart';
import '../../widgets/appbar_widget.dart';

// This class handles the Page to edit the Name Section of the User Profile.
class EditNameFormPage extends StatefulWidget {
  const EditNameFormPage({Key? key}) : super(key: key);

  @override
  EditNameFormPageState createState() {
    return EditNameFormPageState();
  }
}

class EditNameFormPageState extends State<EditNameFormPage> {
  DatabaseHelperProfile? _database;
  final _formKey = GlobalKey<FormState>();
  final nombreControler = TextEditingController();
  final apellidoPaternoControler = TextEditingController();
  final apellidoMaternoControler = TextEditingController();


  @override
  void dispose() {
    nombreControler.dispose();
    super.dispose();
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    _database = DatabaseHelperProfile();
    nombreControler.text = '';
    apellidoMaternoControler.text = '';
    apellidoPaternoControler.text = '';
  }

  void updateUserValue(
      String nombre, String apellidoPaterno, String apellidoMaterno) {
    print(nombre + " " + apellidoPaterno);
    _database!.actualizar({
      'idUsuario': 1,
      'nombre': nombre,
      'apellidoPaterno': apellidoPaterno,
      'apellidoMaterno': apellidoMaterno
    }, 'tblUsuario').then(
      (value) {
        final snackbar =
            SnackBar(content: Text('Usuario actualizado correctamente'));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context),
        body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: SizedBox(
                    width: 330,
                    child: const Text(
                      "Editar nombre completo",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            height: 100,
                            width: 250,
                            child: TextFormField(
                              // Handles Form Validation for First Name
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your first name';
                                } else if (!isAlpha(value)) {
                                  return 'Only Letters Please';
                                }
                                return null;
                              },
                              decoration: InputDecoration(labelText: 'Nombre'),
                              controller: nombreControler,
                            )),
                        SizedBox(
                            height: 100,
                            width: 250,
                            child: TextFormField(
                              // Handles Form Validation for Last Name
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your last name';
                                } else if (!isAlpha(value)) {
                                  return 'Only Letters Please';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                  labelText: 'Apellido Paterno'),
                              controller: apellidoPaternoControler,
                            )),
                        SizedBox(
                            height: 100,
                            width: 250,
                            child: TextFormField(
                              // Handles Form Validation for Last Name
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your last name';
                                } else if (!isAlpha(value)) {
                                  return 'Only Letters Please';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                  labelText: 'Apellido Materno'),
                              controller: apellidoMaternoControler,
                            ))
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 330,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            // Validate returns true if the form is valid, or false otherwise.
                            if (_formKey.currentState!.validate() &&
                                isAlpha(nombreControler.text +
                                    apellidoPaternoControler.text +
                                    apellidoMaternoControler.text)) {
                              updateUserValue(
                                  nombreControler.text,
                                  apellidoPaternoControler.text,
                                  apellidoMaternoControler.text);
                              Navigator.pop(context);
                            }
                          },
                          child: const Text(
                            'Update',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      )))
            ],
          ),
        ));
  }
}
