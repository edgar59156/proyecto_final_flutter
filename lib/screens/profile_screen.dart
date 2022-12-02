import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/screens/profile_screens/edit_description.dart';
import 'package:proyecto_final/screens/profile_screens/edit_email.dart';
import 'package:proyecto_final/screens/profile_screens/edit_githubpage.dart';
import 'package:proyecto_final/screens/profile_screens/edit_name.dart';
import 'package:proyecto_final/screens/profile_screens/edit_phone.dart';
import 'package:proyecto_final/shared_preferences/preferencias.dart';
import 'package:proyecto_final/storage/storage_repository.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

import '../database/database_helper_profile.dart';
import '../firebase/people_firebase.dart';
import '../models/profile_model.dart';
import '../provider/login_provider.dart';

// This class handles the Page to dispaly the user's info on the "Edit Profile" Screen
class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _peopleFirebase = PeopleFirebase();
  }

  DatabaseHelperProfile? _database;
  PeopleFirebase? _peopleFirebase;
  @override
  Widget build(BuildContext context) {
    _database = DatabaseHelperProfile();

    return Scaffold(
      body: StreamBuilder(
          stream: _peopleFirebase!.getPeople(Preferences.email),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            child:
            if (snapshot.hasData) {
              return Column(
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
                            'Editar Perfil',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(64, 105, 225, 1),
                            ),
                          ))),
                  InkWell(
                      onTap: () {
                        //navigateSecondPage(EditImagePage());
                        /*  Navigator.pushNamed(context, '/editImage', arguments: {
                          'idUsuario': snapshot.data![0].idUsuario,
                          'image': snapshot.data![0].image
                        }).then((value) {
                          setState(() {});
                        })*/
                      },
                      child: Stack(children: [
                        Hero(
                          tag: "profile-image",
                          child: CircleAvatar(
                            radius: 90,
                            child: snapshot.data!.docs[0].get('fotografia') !=
                                    ''
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(75),
                                    child: Image.network(snapshot.data!.docs[0]
                                        .get('fotografia')),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(75),
                                    child: Image.network(
                                        'https://webstockreview.net/images/banana-clipart-logo-9.png'),
                                  ),
                          ),
                        ),
                        Positioned(
                            bottom: 0,
                            right: -25,
                            child: RawMaterialButton(
                              onPressed: () async {
                                ImagePicker _picker = ImagePicker();
                                final XFile? _image = await _picker.pickImage(
                                    source: ImageSource.gallery);
                                if (_image == null) {
                                  /*ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text('No selected image')));*/
                                  Alert(
                                    context: context,
                                    title: "Error :(",
                                    desc: "No se seleccionó imagen",
                                    image: Image.asset("assets/info.png"),
                                    buttons: [
                                      DialogButton(
                                        child: Text(
                                          "OK",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                        onPressed: () => Navigator.pop(context),
                                        color: Colors.lightBlue,
                                        radius: BorderRadius.circular(0.0),
                                      ),
                                    ],
                                  ).show();
                                }
                                if (_image != null) {
                                  print('Uploading...');
                                  String downloadUrl = await StorageRepository()
                                      .uploadImage(_image);

                                  print('image url: ${downloadUrl}');
                                  Alert(
                                    context: context,
                                    title: "Imagen cargada correctamente",
                                    desc: "Imagen almacenada en la nube",
                                    image: Image.asset("assets/check.png"),
                                    buttons: [
                                      DialogButton(
                                        child: Text(
                                          "OK",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                        onPressed: () => Navigator.pop(context),
                                        color: Colors.lightBlue,
                                        radius: BorderRadius.circular(0.0),
                                      ),
                                    ],
                                  ).show();
                                  _peopleFirebase!.updPeopleImg(
                                      snapshot.data!.docs[0].id, downloadUrl);
                                  print(snapshot.data!.docs[0].id);
                                }
                              },
                              /*Navigator.pushNamed(context, '/editImage',
                                    arguments: {
                                      'idUsuario': snapshot.data![0].idUsuario,
                                      'image': snapshot.data![0].image
                                    }).then((value) { 
                                  setState(() {});
                                });*/

                              elevation: 2.0,
                              fillColor: Color(0xFFF5F6F9),
                              child: Icon(
                                Icons.edit,
                                color: Colors.blue,
                              ),
                              //padding: EdgeInsets.all(15.0),
                              shape: CircleBorder(),
                            )),
                      ])),
                  buildUserInfoDisplay(
                      snapshot.data!.docs[0].get('name'),
                      'Nombre completo',
                      EditNameFormPage(
                        id: snapshot.data!.docs[0].id,
                        name: snapshot.data!.docs[0].get('name'),
                      ),
                      snapshot),
                  buildUserInfoDisplay(snapshot.data!.docs[0].get('email'),
                      'Email', EditEmailFormPage(), snapshot),
                  buildUserInfoDisplay(
                      snapshot.data!.docs[0].get('phone'),
                      'Phone',
                      EditPhoneFormPage(
                          id: snapshot.data!.docs[0].id,
                          phone: snapshot.data!.docs[0].get('phone')),
                      snapshot),
                  Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 1,
                          ),
                          Center(
                            child: Container(
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
                                      child: TextButton(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, '/theme');
                                          },
                                          child: Text(
                                            'Theme',
                                            style: TextStyle(
                                                fontSize: 16, height: 1.4),
                                          ))),
                                  Icon(
                                    Icons.style,
                                    color: Colors.grey,
                                    size: 40.0,
                                  )
                                ])),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: const Text(
                              'Suscribete para recibir notificaciones sobre nuevos cursos',
                              style: TextStyle(
                                  fontSize: 16,
                                  height: 1.4,
                                  color: Colors.blue),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          FlutterSwitch(
                            activeColor: Colors.green,
                            width: 90.0,
                            height: 55.0,
                            valueFontSize: 25.0,
                            toggleSize: 45.0,
                            value: Preferences.susbVal,
                            borderRadius: 30.0,
                            padding: 8.0,
                            showOnOff: true,
                            activeIcon: Icon(
                              Icons.notifications_active,
                              color: Colors.black,
                            ),
                            inactiveIcon: Icon(
                              Icons.notifications_none,
                              color: Colors.red,
                            ),
                            onToggle: (val) {
                              setState(() {
                                Preferences.susbVal = val;
                                if (Preferences.susbVal == true) {
                                  FirebaseMessaging.instance
                                      .subscribeToTopic('Cursos')
                                      .then((value) {
                                    final snackBar = SnackBar(
                                        content: Text(
                                      'Te has suscrito al tema',
                                    ));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  });
                                } else if (Preferences.susbVal == false) {
                                  FirebaseMessaging.instance
                                      .unsubscribeFromTopic('Cursos');

                                  final snackBar = SnackBar(
                                      content: Text(
                                    'Has eliminado la suscripción al tema',
                                  ));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              });
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SocialLoginButton(
                                  buttonType:
                                      SocialLoginButtonType.generalLogin,
                                  text: 'Cerrar sesion',
                                  onPressed: () {
                                    Preferences.isLogged = false;
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil('/login',
                                            (Route<dynamic> route) => false);
                                    Provider.of<LoginProvider>(context,
                                            listen: false)
                                        .logout();
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ))
                ],
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Ocurrio un error en la petición..'));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  // Widget builds the display item with the proper formatting to display the user's info
  Widget buildUserInfoDisplay(String getValue, String title, Widget editPage,
          AsyncSnapshot snapshot) =>
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
                        child: TextButton(
                            onPressed: () {
                              navigateSecondPage(editPage);
                            },
                            child: Text(
                              getValue,
                              style: TextStyle(fontSize: 16, height: 1.4),
                            ))),
                    Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.grey,
                      size: 40.0,
                    )
                  ]))
            ],
          ));

  // Refrshes the Page after updating user info.
  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  // Handles navigation and prompts refresh.
  void navigateSecondPage(Widget editForm) {
    Route route = MaterialPageRoute(builder: (context) => editForm);
    Navigator.push(context, route).then(onGoBack);
  }
}
