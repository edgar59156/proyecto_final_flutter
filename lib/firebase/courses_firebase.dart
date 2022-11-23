import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyecto_final/models/course_model.dart';

class CoursesFirebase {
  FirebaseFirestore? _firebaseFirestore;
  CollectionReference? _coursesCollection;

  CoursesFirebase() {
    _firebaseFirestore = FirebaseFirestore.instance;
    _coursesCollection = _firebaseFirestore!.collection('talleres');
  }

  Future<void> insCourse(CourseModel objCourse) {
    return _coursesCollection!.add(objCourse.toMap());
  }

  Future<void> delCourse(String idCourse) {
    return _coursesCollection!.doc(idCourse).delete();
  }

  Future<void> updCourse(CourseModel objCourse, String idCourse) {
    return _coursesCollection!.doc(idCourse).update(objCourse.toMap());
  }

  Stream<QuerySnapshot> getAllCourses() {
    print('snapshots');
    print(_coursesCollection!.snapshots());
    return _coursesCollection!.snapshots();
  }
}
