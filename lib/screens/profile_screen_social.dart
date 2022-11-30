import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/screens/profile_screens/edit_email.dart';
import 'package:proyecto_final/screens/profile_screens/edit_githubpage.dart';
import 'package:proyecto_final/screens/profile_screens/edit_name.dart';
import 'package:proyecto_final/screens/profile_screens/edit_phone.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import '../database/database_helper_profile.dart';
import '../models/profile_model.dart';
import '../provider/login_provider.dart';

// This class handles the Page to dispaly the user's info on the "Edit Profile" Screen
class ProfilePageSocial extends StatefulWidget {
  @override
  _ProfilePageSocialState createState() => _ProfilePageSocialState();
}

class _ProfilePageSocialState extends State<ProfilePageSocial> {
  DatabaseHelperProfile? _database;
  @override
  Widget build(BuildContext context) {
    LoginProvider snapshotS;
    // _database = DatabaseHelperProfile();
    snapshotS = ModalRoute.of(context)?.settings.arguments as LoginProvider;
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
                            child: snapshotS.userDetails!.photoURL!.isNotEmpty
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(75),
                                    child: Image.network(
                                        '${snapshotS.userDetails!.photoURL!}'),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(75),
                                    child: Image.network(
                                        'https://webstockreview.net/images/banana-clipart-logo-9.png'),
                                  ),
                          ),
                        ),
                      ])),
                  buildUserInfoDisplay(snapshotS.userDetails!.displayName!,
                      'Name', EditNameFormPage(), snapshot),
                  buildUserInfoDisplay(snapshotS.userDetails!.email!, 'Email',
                      EditEmailFormPage(), snapshot),
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
                                    Navigator.pushNamed(context, '/theme');
                                  },
                                  child: Text(
                                    'Theme',
                                    style: TextStyle(fontSize: 16, height: 1.4),
                                  ))),
                          Icon(
                            Icons.style,
                            color: Colors.grey,
                            size: 40.0,
                          )
                        ])),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: SocialLoginButton(
                      buttonType: SocialLoginButtonType.generalLogin,
                      text: 'Cerrar sesion',
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/login', (Route<dynamic> route) => false);
                        Provider.of<LoginProvider>(context, listen: false)
                            .logout();
                      },
                    ),
                  ),
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
                              //navigateSecondPage(editPage);
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
