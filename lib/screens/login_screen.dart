// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/models/people_model.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import '../database/database_helper_profile.dart';
import '../firebase/email_authentication.dart';
import '../firebase/people_firebase.dart';
import '../provider/login_provider.dart';
import '../shared_preferences/preferencias.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  PeopleFirebase? _peopleFirebase;
  @override
  void initState() {
    super.initState();
    //_database = DatabaseHelperProfile();
    _peopleFirebase = PeopleFirebase();
  }

  TextEditingController txtConUser = TextEditingController();
  TextEditingController txtConPwd = TextEditingController();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final EmailAuthentication _emailAuth = EmailAuthentication();
  DatabaseHelperProfile? _database;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width / 20),
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple, Colors.blueAccent],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              stops: [0.4, 0.7],
              tileMode: TileMode.repeated,
            ),
          ),
          child: loginUI()),
    );
  }

  loginUI() {
    // loggedINUI
    // LoginProviders

    return Consumer<LoginProvider>(builder: (context, model, child) {
      // if we are already logged in
      if (model.userDetails != null) {
        return Center(
          child: loggedInUI(model),
        );
      } else {
        return LoginProviders(context);
      }
    });
  }

  loggedInUI(LoginProvider model) {
    return Container(
      height: 400,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white),
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width / 20,
        right: MediaQuery.of(context).size.width / 20,
        bottom: MediaQuery.of(context).size.width / 100,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage:
                Image.network(model.userDetails!.photoURL ?? "").image,
            radius: 50,
          ),
          SizedBox(height: 30),
          Text(model.userDetails!.displayName ?? "",
              style: TextStyle(color: Colors.blue, fontSize: 30)),
          Text(model.userDetails!.email ?? "",
              style: TextStyle(color: Colors.blue, fontSize: 30)),
          SizedBox(height: 15),

          // logout

          CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            checkColor: Colors.white,
            activeColor: Colors.red,
            value: Preferences.isLogged,
            onChanged: (bool? value) {
              setState(() {
                Preferences.isLogged = value!;
              });
            },
            title: Text(
              "Mantener sesión iniciada",
              style: TextStyle(color: Colors.blue),
            ),
          ),
          SocialLoginButton(
            text: 'Login',
            buttonType: SocialLoginButtonType.generalLogin,
            onPressed: () {
              Navigator.pushNamed(context, '/homeS', arguments: model);
            },
          ),

          SizedBox(height: 15),
          ActionChip(
              avatar: Icon(Icons.logout),
              label: Text("Logout"),
              onPressed: () {
                Provider.of<LoginProvider>(context, listen: false).logout();
              }),
        ],
      ),
    );
  }

  LoginProviders(BuildContext context) {
//    GithubAuthentication file = GithubAuthentication();
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          top: MediaQuery.of(context).size.width / 5,
          child: Image.asset(
            'assets/logo.png',
            width: MediaQuery.of(context).size.width / 2.5,
          ),
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.white),
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width / 20,
            right: MediaQuery.of(context).size.width / 20,
            bottom: MediaQuery.of(context).size.width / 30,
          ),
          // color: Colors.white,
          child: ListView(
            shrinkWrap: true,
            children: [
              TextField(
                controller: txtConUser,
                decoration: InputDecoration(
                  hintText: 'Introduce el usuario',
                  label: Text(
                    'Correo Electrónico',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: txtConPwd,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Introduce el password',
                  label: Text(
                    'Contraseña',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
              CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                checkColor: Colors.white,
                activeColor: Colors.red,
                value: Preferences.isLogged,
                onChanged: (bool? value) {
                  setState(() {
                    Preferences.isLogged = value!;
                  });
                },
                title: Text(
                  "Mantener sesión iniciada",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 15),
                width: MediaQuery.of(context).size.width / 1.4,
                child: RoundedLoadingButton(
                    controller: _btnController,
                    color: Colors.blue,
                    child: Text('Iniciar Sesión',
                        style: TextStyle(color: Colors.white)),
                    onPressed: () async {
                      Timer(
                        Duration(seconds: 3),
                        () async {
                          var ban = await _emailAuth.signInWithEmailAndPassword(
                              email: txtConUser.text, password: txtConPwd.text);
                          if (ban == true) {
                            if (_auth.currentUser!.emailVerified) {
                              //updateUserValue(txtConUser.text);

                              print(txtConUser.text);
                              _btnController.success();
                              Preferences.email = txtConUser.text;
                              _btnController.reset();
                              Navigator.pushNamed(
                                context,
                                '/home',
                              );
                            } else {
                              /* final snackBar = SnackBar(
                            content:
                                Text('Verificar correo para iniciar sesión'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);*/
                              _btnController.error();
                              Alert(
                                context: context,
                                title: "Error :(",
                                desc: "Verificar correo para iniciar sesión",
                                image: Image.asset("assets/info.png"),
                                buttons: [
                                  DialogButton(
                                    child: Text(
                                      "Reintentar",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                    color: Colors.lightBlue,
                                    radius: BorderRadius.circular(0.0),
                                  ),
                                ],
                              ).show();
                              print('Usuario no validado');
                              _btnController.reset();
                            }
                          } else {
                            /*final snackBar =
                          SnackBar(content: Text('Credenciales invalidas'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      */
                            print('credenciales invalidas');
                            _btnController.error();
                            /* Alert(
                        context: context,
                        title: "RFLUTTER ALERT",
                        desc: "Flutter is more awesome with RFlutter Alert.",
                        alertAnimation: fadeAlertAnimation,
                      ).show();
*/
                            Alert(
                              context: context,
                              title: "Error :(",
                              desc: "Credenciales inválidas",
                              image: Image.asset("assets/close.png"),
                              buttons: [
                                DialogButton(
                                  child: Text(
                                    "Reintentar",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                  color: Colors.lightBlue,
                                  radius: BorderRadius.circular(0.0),
                                ),
                              ],
                            ).show();
                            _btnController.reset();
                          }
                        },
                      );
                    }),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: MediaQuery.of(context).size.width / 50,
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 15),
            width: MediaQuery.of(context).size.width / 1.2,
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                SocialLoginButton(
                  buttonType: SocialLoginButtonType.generalLogin,
                  text: 'Create account',
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/signup',
                    );
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                SocialLoginButton(
                  buttonType: SocialLoginButtonType.google,
                  onPressed: () {
                    Provider.of<LoginProvider>(context, listen: false)
                        .googleLogin();
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                SocialLoginButton(
                  buttonType: SocialLoginButtonType.facebook,
                  onPressed: () {
                    Provider.of<LoginProvider>(context, listen: false)
                        .facebooklogin();
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                SocialLoginButton(
                  buttonType: SocialLoginButtonType.github,
                  onPressed: () async {
                    Provider.of<LoginProvider>(context, listen: false)
                        .githublogin();
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void updateUserValue(String email) {
    print(email);
    Alert(
      context: context,
      title: "Error :(",
      desc: "Credenciales inválidas",
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

    _database!.actualizar({'idUsuario': 1, 'email': email}, 'tblUsuario').then(
      (value) {
        final snackbar = SnackBar(
            content: Text('Correo del usuario insertado correctamente'));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      },
    );
  }
}

Widget fadeAlertAnimation(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  return Align(
    child: FadeTransition(
      opacity: animation,
      child: child,
    ),
  );
}
