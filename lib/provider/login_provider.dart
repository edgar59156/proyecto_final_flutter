import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/user_details.dart';

class LoginController with ChangeNotifier {
  // object
  var _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? googleSignInAccount;
  UserDetails? userDetails;

  // fucntion for google login
  googleLogin() async {
    this.googleSignInAccount = await _googleSignIn.signIn();
    // inserting values to our user details model

    this.userDetails = new UserDetails(
      displayName: this.googleSignInAccount!.displayName,
      email: this.googleSignInAccount!.email,
      photoURL: this.googleSignInAccount!.photoUrl,
    );

    // call
    notifyListeners();
  }

  // function for facebook login
  facebooklogin() async {
    var result = await FacebookAuth.i.login(
      permissions: ["public_profile", "email"],
    );

    // check the status of our login
    if (result.status == LoginStatus.success) {
      final requestData = await FacebookAuth.i.getUserData(
        fields: "email, name, picture",
      );

      this.userDetails = new UserDetails(
        displayName: requestData["name"],
        email: requestData["email"],
        photoURL: requestData["picture"]["data"]["url"] ?? " ",
      );
      notifyListeners();
    }
  }

  githublogin() async {
    try {
      var githubProvider = GithubAuthProvider();
      githubProvider.addScope(
          'https://mapasprogramoviles2022.firebaseapp.com/__/auth/handler');
      githubProvider.setCustomParameters({
        'allow_signup': 'true',
      });
      var newAuth = await FirebaseAuth.instance
          .signInWithProvider(githubProvider)
          .then((value) {
        this.userDetails = new UserDetails(
          displayName: value.user!.displayName,
          email: value.user!.email,
          photoURL: value.user!.photoURL ?? " ",
        );
      });
      notifyListeners();
      return true;
    } catch (e) {
      print('GITHUB ERROR EN $e');
      return false;
    }
  }

  // logout

  logout() async {
    this.googleSignInAccount = await _googleSignIn.signOut();
    await FacebookAuth.i.logOut();
    await FirebaseAuth.instance.signOut();
    userDetails = null;
    notifyListeners();
  }
}
