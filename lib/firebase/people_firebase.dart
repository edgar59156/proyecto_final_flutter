import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyecto_final/models/people_model.dart';
import 'package:proyecto_final/shared_preferences/preferencias.dart';

class PeopleFirebase {
  FirebaseFirestore? _firebaseFirestore;
  CollectionReference? _peopleCollection;

  PeopleFirebase() {
    _firebaseFirestore = FirebaseFirestore.instance;
    _peopleCollection = _firebaseFirestore!.collection('personas');
  }

  Future<void> insPeople(PeopleModel objPeople) {
    return _peopleCollection!.add(objPeople.toMap());
  }

  Future<void> delPeople(String idPeople) {
    return _peopleCollection!.doc(idPeople).delete();
  }

  Future<void> updPeople(PeopleModel objPeople, String idPeople) {
    return _peopleCollection!.doc(idPeople).update(objPeople.toMap());
  }

  Stream<QuerySnapshot> getPeople(String email) {
    //_peopleCollection!.where('email', isEqualTo: email);
 
    return _peopleCollection!.where('email', isEqualTo: email).snapshots();
  }

  Stream<QuerySnapshot> getAllPeople() {
    return _peopleCollection!.snapshots();
  }
}
