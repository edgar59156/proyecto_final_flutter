import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyecto_final/models/notifications_model.dart';

class NotificationsFirebase {
  FirebaseFirestore? _firebaseFirestore;
  CollectionReference? _notificationsCollection;

  NotificationsFirebase() {
    _firebaseFirestore = FirebaseFirestore.instance;
    _notificationsCollection =
        _firebaseFirestore!.collection('notificaciones');
  }

  Future<void> insPeopleNotification(NotificationsModel objNotification) {
    return _notificationsCollection!.add(objNotification.toMap());
  }

  Future<void> delNotification(String idNotification) {
    return _notificationsCollection!.doc(idNotification).delete();
  }

  Future<void> updNotification(NotificationsModel objNotification, String idNotification) {
    return _notificationsCollection!.doc(idNotification).update(objNotification.toMap());
  }

  Stream<QuerySnapshot> getNotification(String taller) {
    return _notificationsCollection!
        .where('taller', isEqualTo: taller)
        .snapshots();
  }

  Stream<QuerySnapshot> getAllNotifications(String email) {
    return _notificationsCollection!
        .where('to_email', isEqualTo: email)
        .snapshots();
  }
}
