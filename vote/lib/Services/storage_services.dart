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
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('candidate_photos/$pollID/$photoName.png');
      await storageReference.child(photoName).putFile(photoFile);
      imageLink = await storageReference.child(photoName).getDownloadURL();
    } catch (e) {}
    return imageLink; //if upload is succesful reutrn a link to the image
  }
}
