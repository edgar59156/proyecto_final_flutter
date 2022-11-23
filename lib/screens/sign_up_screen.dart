import 'dart:async';

import 'package:flutter/material.dart';
import 'package:proyecto_final/screens/profile_screens/edit_email.dart';
import 'package:proyecto_final/screens/profile_screens/edit_githubpage.dart';
import 'package:proyecto_final/screens/profile_screens/edit_name.dart';
import 'package:proyecto_final/screens/profile_screens/edit_phone.dart';

import 'package:social_login_buttons/social_login_buttons.dart';

import '../firebase/email_authentication.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  EmailAuthentication? _emailAuth;

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
                  'Editar Perfil',
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
                    child: Image.network(
                        'https://webstockreview.net/images/banana-clipart-logo-9.png'),
                  ),
                ),
              ),
              Positioned(
                  bottom: 0,
                  right: -25,
                  child: RawMaterialButton(
                    onPressed: () {},
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
        buildUserInfoDisplay('Juan Perez', 'Name', EditNameFormPage()),
        buildUserInfoDisplay('461111111', 'Phone', EditPhoneFormPage()),
        buildUserInfoDisplay('example@gmail.com', 'Email', EditEmailFormPage()),
        buildUserInfoDisplay('@Github', 'Github', EditgithubFormPage()),
        SocialLoginButton(
          buttonType: SocialLoginButtonType.generalLogin,
          text: 'Sing Up',
          onPressed: () {
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
      ],
    ));
  }

  // Widget builds the display item with the proper formatting to display the user's info
  Widget buildUserInfoDisplay(String getValue, String title, Widget editPage) =>
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
                              // navigateSecondPage(editPage);
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
}
