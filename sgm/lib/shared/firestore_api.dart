import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class FirestoreApi{
  static UploadTask? uploadFile(String destionation, File file){
    try{
    final ref = FirebaseStorage.instance.ref(destionation);
    debugPrint("deu");
    return ref.putFile(file);
    } on FirebaseException catch (e){
      debugPrint(e.message);
      return null;
    }
  }
}