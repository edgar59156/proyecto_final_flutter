import 'dart:async';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_final/screens/profile_screens/edit_email.dart';
import 'package:proyecto_final/screens/profile_screens/edit_githubpage.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:string_validator/string_validator.dart';

import '../firebase/email_authentication.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  EmailAuthentication? _emailAuth;
  final correo = TextEditingController();
  final contrasena = TextEditingController();
  final confirmContra = TextEditingController();
  final name = TextEditingController();
  final phone = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailAuth = EmailAuthentication();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 10,
        ),
        Center(
            child: Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Text(
                  'Crear Perfil',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(64, 105, 225, 1),
                  ),
                ))),
        InkWell(
            onTap: () {},
            child: Stack(children: [
              Hero(
                tag: "new-profile-image",
                child: CircleAvatar(
                  radius: 90,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(75),
                    child: Image.asset('assets/account.png'),
                  ),
                ),
              ),
            ])),
        buildUserInfoDisplayEmail(
            'example@gmail.com', 'Email', EditEmailFormPage()),
        SizedBox(
          height: 5,
        ),
        buildUserInfoDisplayContrasena(
            '@Github', 'Contraseña', EditgithubFormPage()),
        SizedBox(
          height: 5,
        ),
        buildUserInfoDisplayConfirm(
            '@Github', 'Confirmar contraseña', EditgithubFormPage()),
        SizedBox(
          height: 30,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 2,
          child: SocialLoginButton(
            buttonType: SocialLoginButtonType.generalLogin,
            text: 'Sing Up',
            onPressed: () {
              if (EmailValidator.validate(correo.text) &&
                  contrasena.text == confirmContra.text &&
                  contrasena.text.length >= 8) {
                _emailAuth!
                    .createUserWithEmailAndPassword(
                  email: correo.text,
                  password: contrasena.text,
                )
                    .then((value) {
                  //Navigator.pop(context);

                  /*final snackBar = SnackBar(
                      content:
                          Text('Cuenta creada exitosamente, verificar cuenta'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);*/
                  Alert(
                    context: context,
                    title: "Éxito",
                    desc: "Cuenta creada exitosamente, verificar cuenta",
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
                });
              } else if (contrasena.text.length < 8) {
                /*final snackBar = SnackBar(
                    content:
                        Text('Ingrese una contraseña mayor a 8 caracteres'));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                */
                Alert(
                  context: context,
                  title: "Error :(",
                  desc: "Ingrese una contraseña mayor a 8 caracteres",
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
              } else if (EmailValidator.validate(correo.text) == false) {
                Alert(
                  context: context,
                  title: "Error :(",
                  desc: "Ingresar un correo válido",
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
              } else {
                /*final snackBar = SnackBar(
                    content:
                        Text('Verificar correo, o que la contraseña coincida'));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);*/
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
              }
              /* _emailAuth!
                  .createUserWithEmailAndPassword(
                      email: txtMail.text, password: password)
                  .then((value) {
                Navigator.pop(context);
              });
*/
              /*
              Navigator.pushNamed(
                context,
                '/signup',
              );*/
            },
          ),
        ),
      ],
    ));
  }

  // Widget builds the display item with the proper formatting to display the user's info
  Widget buildUserInfoDisplayEmail(
          String getValue, String title, Widget editPage) =>
      Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 1,
              ),
              Container(
                  width: 350,
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ))),
                  child: Row(children: [
                    Expanded(
                        child: TextFormField(
                      // Handles Form Validation for First Name
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingresa un correo';
                        }
                        return null;
                      },

                      controller: correo,
                    )),
                  ]))
            ],
          ));
  Widget buildUserInfoDisplayContrasena(
          String getValue, String title, Widget editPage) =>
      Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 1,
              ),
              Container(
                  width: 350,
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ))),
                  child: Row(children: [
                    Expanded(
                        child: TextFormField(
                      // Handles Form Validation for First Name
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Coloca una contrasena';
                        }
                        return null;
                      },

                      controller: contrasena,
                    )),
                  ]))
            ],
          ));
  Widget buildUserInfoDisplayPhone(
          String getValue, String title, Widget editPage) =>
      Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 1,
              ),
              Container(
                  width: 350,
                  height: 20,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ))),
                  child: Row(children: [
                    Expanded(
                        child: TextFormField(
                      // Handles Form Validation for First Name
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Coloca una contrasena';
                        }
                        return null;
                      },

                      controller: phone,
                    )),
                  ]))
            ],
          ));
  Widget buildUserInfoDisplayName(
          String getValue, String title, Widget editPage) =>
      Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 1,
              ),
              Container(
                  width: 350,
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ))),
                  child: Row(children: [
                    Expanded(
                        child: TextFormField(
                      // Handles Form Validation for First Name
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Coloca una contrasena';
                        }
                        return null;
                      },

                      controller: name,
                    )),
                  ]))
            ],
          ));
  Widget buildUserInfoDisplayConfirm(
          String getValue, String title, Widget editPage) =>
      Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 1,
              ),
              Container(
                  width: 350,
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ))),
                  child: Row(children: [
                    Expanded(
                        child: TextFormField(
                      // Handles Form Validation for First Name
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Coloca una contrasena';
                        }
                        return null;
                      },

                      controller: confirmContra,
                    )),
                  ]))
            ],
          ));
}
