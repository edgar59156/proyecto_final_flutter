import 'package:firebase_auth/firebase_auth.dart';
import 'package:proyecto_final/firebase/people_firebase.dart';

import '../models/people_model.dart';

class EmailAuthentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final UserCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      User user = UserCredential.user!;
      user.sendEmailVerification();
      PeopleFirebase? _peopleFirebase;
      _peopleFirebase = PeopleFirebase();
      PeopleModel objPeople = PeopleModel(
          email: email,
          fotografia: '',
          id_persona: 1,
          persona: '',
          name: '',
          phone: '');
      _peopleFirebase.insPeople(objPeople);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      return false;
    }
  }
}
