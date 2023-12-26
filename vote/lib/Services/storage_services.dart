import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageServices {
  static Future<String?> uploadImageToStorage(
      File? photoFile, String pollID) async {
    String?
        imageLink; //url that will store a link to the image after uploading it
    String photoName = DateTime.now().millisecondsSinceEpoch.toString();

    // upload image to the storage
    if (photoFile == null) {
      return null; //if the image to upload is null, stop and return null
    }
    try {
      //atempt to upload image and store a link to it
      Reference storageReference = FirebaseStorage.instance.ref();
      await storageReference
          .child('candidate_photos/$pollID/$photoName.png')
          .putFile(photoFile);
      imageLink = await storageReference
          .child('candidate_photos/$pollID/$photoName.png')
          .getDownloadURL();
    } catch (e) {}
    return imageLink; //if upload is succesful reutrn a link to the image
  }

  static Future<String?> uploadVoterImageToStorage(
      File? photoFile, String pollID, String dataName, String voterID) async {
    String?
        imageLink; //url that will store a link to the image after uploading it
    String photoName = DateTime.now().millisecondsSinceEpoch.toString();

    // upload image to the storage
    if (photoFile == null) {
      return null; //if the image to upload is null, stop and return null
    }
    try {
      //atempt to upload image and store a link to it
      Reference storageReference = FirebaseStorage.instance.ref();
      await storageReference
          .child('voter_data/$pollID/$voterID/$dataName/$photoName.png')
          .putFile(photoFile);
      imageLink = await storageReference
          .child('voter_data/$pollID/$voterID/$dataName/$photoName.png')
          .getDownloadURL();
    } catch (e) {}
    return imageLink; //if upload is succesful reutrn a link to the image
  }
}
