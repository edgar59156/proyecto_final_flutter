import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:proyecto_final/storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class StorageRepository extends FirebaseStorage {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  @override
  Future<String> uploadImage(XFile image) async {
   
      await storage.ref('user_1/${image.name}').putFile(File(image.path));
      String dowloadUrl =
          await storage.ref('user_1/${image.name}').getDownloadURL();
      return dowloadUrl;
     
  }

  @override
  Future<String> getDownloadUrl(String imageName) async {
    String dowloadUrl = await storage.ref('user_1/$imageName').getDownloadURL();
    return dowloadUrl;
  }
}
