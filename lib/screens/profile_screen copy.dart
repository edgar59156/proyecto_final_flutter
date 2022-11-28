import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:proyecto_final/screens/profile_screens/edit_description.dart';
import 'package:proyecto_final/screens/profile_screens/edit_email.dart';
import 'package:proyecto_final/screens/profile_screens/edit_githubpage.dart';
import 'package:proyecto_final/screens/profile_screens/edit_name.dart';
import 'package:proyecto_final/screens/profile_screens/edit_phone.dart';

import '../database/database_helper_profile.dart';
import '../models/profile_model.dart';

// This class handles the Page to dispaly the user's info on the "Edit Profile" Screen
class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  DatabaseHelperProfile? _database;
  @override
  Widget build(BuildContext context) {
    _database = DatabaseHelperProfile();

    return Scaffold(
      body: FutureBuilder(
          future: _database!.getAllUsuarios(),
          builder: (context, AsyncSnapshot<List<ProfileDAO>> snapshot) {
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
                        Navigator.pushNamed(context, '/editImage', arguments: {
                          'idUsuario': snapshot.data![0].idUsuario,
                          'image': snapshot.data![0].image
                        }).then((value) {
                          setState(() {});
                        });
                      },
                      child: Stack(children: [
                        Hero(
                          tag: "profile-image",
                          child: CircleAvatar(
                            radius: 90,
                            child: snapshot.data![0].image!.isNotEmpty
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(75),
                                    child: Image.file(
                                        File(snapshot.data![0].image!)),
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
                              onPressed: () {
                                Navigator.pushNamed(context, '/editImage',
                                    arguments: {
                                      'idUsuario': snapshot.data![0].idUsuario,
                                      'image': snapshot.data![0].image
                                    }).then((value) {
                                  setState(() {});
                                });
                              },
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
                      snapshot.data![0].nombre! +
                          " " +
                          snapshot.data![0].apellidoPaterno! +
                          " " +
                          snapshot.data![0].apellidoMaterno!,
                      'Name',
                      EditNameFormPage(),
                      snapshot),
                  buildUserInfoDisplay(snapshot.data![0].telefono!, 'Phone',
                      EditPhoneFormPage(), snapshot),
                  buildUserInfoDisplay(snapshot.data![0].email!, 'Email',
                      EditEmailFormPage(), snapshot),
                  buildUserInfoDisplay(snapshot.data![0].github!, 'Github',
                      EditgithubFormPage(), snapshot),
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
/*
  // Widget builds the About Me Section
  Widget buildAbout(User user) => Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tell Us About Yourself',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 1),
          Container(
              width: 350,
              height: 200,
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
                          navigateSecondPage(EditDescriptionFormPage());
                        },
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  user.aboutMeDescription,
                                  style: TextStyle(
                                    fontSize: 16,
                                    height: 1.4,
                                  ),
                                ))))),
                Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.grey,
                  size: 40.0,
                )
              ]))
        ],
      ));*/

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
