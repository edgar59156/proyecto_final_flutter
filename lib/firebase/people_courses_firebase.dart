import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyecto_final/models/course_model.dart';

import '../models/people_course_model.dart';

class PeopleCoursesFirebase {
  FirebaseFirestore? _firebaseFirestore;
  CollectionReference? _peopleCoursesCollection;

  PeopleCoursesFirebase() {
    _firebaseFirestore = FirebaseFirestore.instance;
    _peopleCoursesCollection =
        _firebaseFirestore!.collection('personas_talleres');
  }

  Future<void> insPeopleCourse(PeopleCourseModel objCourse) {
    return _peopleCoursesCollection!.add(objCourse.toMap());
  }

  Future<void> delCourse(String idCourse) {
    return _peopleCoursesCollection!.doc(idCourse).delete();
  }

  Future<void> updCourse(CourseModel objCourse, String idCourse) {
    return _peopleCoursesCollection!.doc(idCourse).update(objCourse.toMap());
  }

  Stream<QuerySnapshot> getCourse(String taller) {
    return _peopleCoursesCollection!
        .where('taller', isEqualTo: taller)
        .snapshots();
  }

  Stream<QuerySnapshot> getAllCourses(String email) {
    return _peopleCoursesCollection!
        .where('email', isEqualTo: email)
        .snapshots();
  }
}
