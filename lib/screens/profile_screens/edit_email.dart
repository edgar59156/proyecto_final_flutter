import 'package:flutter/material.dart';

import 'package:email_validator/email_validator.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../database/database_helper_profile.dart';
import '../../widgets/appbar_widget.dart';

// This class handles the Page to edit the Email Section of the User Profile.
class EditEmailFormPage extends StatefulWidget {
  const EditEmailFormPage({Key? key}) : super(key: key);

  @override
  EditEmailFormPageState createState() {
    return EditEmailFormPageState();
    
  }
}

class EditEmailFormPageState extends State<EditEmailFormPage> {
  DatabaseHelperProfile? _database;
  
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
  void initState() {
    // TODO: implement initState
    super.initState();
    _database = DatabaseHelperProfile();
  }
  void updateUserValue(String email) {
    print(email);
    _database!.actualizar({'idUsuario': 1, 'email': emailController.text}, 'tblUsuario').then(
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
                      "¿Cúal es tu correo?",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
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
                              return 'Por favor ingresa un correo';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              labelText: 'Correo'),
                          controller: emailController,
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
                                  EmailValidator.validate(
                                      emailController.text)) {
                                updateUserValue(emailController.text);
                                Navigator.pop(context);
                              }
                            },
                            child: const Text(
                              'Update',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        )))
              ]),
        ));
  }
}
