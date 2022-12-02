import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:string_validator/string_validator.dart';

import '../../database/database_helper_profile.dart';
import '../../firebase/people_firebase.dart';
import '../../widgets/appbar_widget.dart';

// This class handles the Page to edit the Name Section of the User Profile.
class EditNameFormPage extends StatefulWidget {
  EditNameFormPage({Key? key, required this.id, required this.name})
      : super(key: key);
  String id;
  String name;

  @override
  EditNameFormPageState createState() {
    return EditNameFormPageState();
  }
}

class EditNameFormPageState extends State<EditNameFormPage> {
  DatabaseHelperProfile? _database;
  final _formKey = GlobalKey<FormState>();
  final nombreControler = TextEditingController();
  PeopleFirebase? _peopleFirebase;
  @override
  void dispose() {
    nombreControler.dispose();
    super.dispose();
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    _database = DatabaseHelperProfile();
    _peopleFirebase = PeopleFirebase();
    nombreControler.text = widget.name;
  }

  void updateUserValue(String nombre) {
    print(nombre);
    _peopleFirebase?.updPeopleName(widget.id, nombre).then(
      (value) {
        Alert(
          context: context,
          title: "Éxito",
          desc: "Datos del usuario actualizados correctamente",
          image: Image.asset("assets/check.png"),
          buttons: [
            DialogButton(
              child: Text(
                "OK",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              color: Colors.lightBlue,
              radius: BorderRadius.circular(0.0),
            ),
          ],
        ).show();
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
                                  return 'Ingresa tu nombre';
                                }
                                return null;
                              },
                              decoration: InputDecoration(labelText: 'Nombre'),
                              controller: nombreControler,
                            )),
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
                            if (_formKey.currentState!.validate()) {
                              updateUserValue(
                                nombreControler.text,
                              );
                              //Navigator.pop(context);
                            }
                          },
                          child: const Text(
                            'Actualizar',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      )))
            ],
          ),
        ));
  }
}
