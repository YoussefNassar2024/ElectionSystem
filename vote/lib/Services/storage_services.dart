import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageServices {
  static Future<String?> uploadImageToStorage(
      File? photoFile, String pollID) async {
    String? imageLink;
    String photoName = DateTime.now().millisecondsSinceEpoch.toString();

    if (photoFile == null) {
      return null;
    }
    try {
      Reference storageReference = FirebaseStorage.instance.ref();
      await storageReference
          .child('candidate_photos/$pollID/$photoName.png')
          .putFile(photoFile);
      imageLink = await storageReference
          .child('candidate_photos/$pollID/$photoName.png')
          .getDownloadURL();
    } catch (e) {}
    return imageLink;
  }

  static Future<String?> uploadVoterImageToStorage(
      File? photoFile, String pollID, String dataName, String voterID) async {
    String? imageLink;
    String photoName = DateTime.now().millisecondsSinceEpoch.toString();

    if (photoFile == null) {
      return null;
    }
    try {
      Reference storageReference = FirebaseStorage.instance.ref();
      await storageReference
          .child('voter_data/$pollID/$voterID/$dataName/$photoName.png')
          .putFile(photoFile);
      imageLink = await storageReference
          .child('voter_data/$pollID/$voterID/$dataName/$photoName.png')
          .getDownloadURL();
    } catch (e) {}
    return imageLink;
  }
}
