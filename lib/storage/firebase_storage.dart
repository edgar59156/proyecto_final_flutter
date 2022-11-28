import 'package:image_picker/image_picker.dart';

abstract class FirebaseStorage {
  Future<String> uploadImage(XFile image);
  Future<String> getDownloadUrl(String imageName);
}
