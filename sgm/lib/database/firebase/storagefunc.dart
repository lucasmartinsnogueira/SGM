import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class StorageFunc{
  Future<void> delete(String ref) async {
    try {
    await FirebaseStorage.instance.refFromURL(ref).delete();
     } catch (e) { 
       debugPrint('Error : $e'); 
    }
  }
}