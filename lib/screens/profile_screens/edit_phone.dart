import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:string_validator/string_validator.dart';

import '../../database/database_helper_profile.dart';
import '../../firebase/people_firebase.dart';
import '../../widgets/appbar_widget.dart';

// This class handles the Page to edit the Phone Section of the User Profile.
class EditPhoneFormPage extends StatefulWidget {
  EditPhoneFormPage({Key? key, required this.id, required this.phone})
      : super(key: key);
  String id;
  String phone;
  @override
  EditPhoneFormPageState createState() {
    return EditPhoneFormPageState();
  }
}

class EditPhoneFormPageState extends State<EditPhoneFormPage> {
  DatabaseHelperProfile? _database;
  PeopleFirebase? _peopleFirebase;
  final _formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    _database = DatabaseHelperProfile();
    _peopleFirebase = PeopleFirebase();
    phoneController.text = widget.phone;
  }

  void updateUserValue(String phone) {
    print(phoneController.text);
    _peopleFirebase?.updPeoplePhone(widget.id, phone).then(
      (value) {
        Alert(
          context: context,
          title: "Éxito",
          desc: "Teléfono actualizado correctamente",
          image: Image.asset("assets/check.png"),
          buttons: [
            DialogButton(
              child: Text(
                "Ok",
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
                SizedBox(
                    width: 320,
                    child: const Text(
                      "¿Cúal es tu número de teléfono?",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    )),
                Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: SizedBox(
                        height: 100,
                        width: 320,
                        child: TextFormField(
                          // Handles Form Validation
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingresa un número';
                            } else if (isAlpha(value)) {
                              return 'Solo números';
                            } else if (value.length < 10) {
                              return 'Ingresa un numero de teléfono válido';
                            }
                            return null;
                          },
                          controller: phoneController,
                          decoration: const InputDecoration(
                            labelText: 'Tu número de teléfono',
                          ),
                        ))),
                Padding(
                    padding: EdgeInsets.only(top: 150),
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: 320,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              // Validate returns true if the form is valid, or false otherwise.
                              if (_formKey.currentState!.validate() &&
                                  isNumeric(phoneController.text)) {
                                updateUserValue(phoneController.text);
                                // Navigator.pop(context);
                              }
                            },
                            child: const Text(
                              'Actualizar',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        )))
              ]),
        ));
  }
}
