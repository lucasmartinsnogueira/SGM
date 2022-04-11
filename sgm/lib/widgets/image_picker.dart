import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sgm/Pacote_de_Ajuda/cores.dart';
import 'package:sgm/Pacote_de_Ajuda/firestore_api.dart';
import 'package:sgm/services/auth_services.dart';

class ImagePickerClass{
  UploadTask? task;  
  XFile? image; 
  void showImagePicker(context, uid){
     showBottomSheet(context: context,
        builder: (BuildContext context){ 
          return Container(
            color: amareloClaro,
            height: 150,
            child: Row(
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () => pickImage(ImageSource.gallery, context, uid),
                      child: const Text("Arquivo ", style: TextStyle(fontSize: 45),))
                  ],
                ),
                Column(children: [
                    GestureDetector(
                      onTap: ()=> pickImage(ImageSource.camera, context, uid),
                      child: const Text("Câmera", style: TextStyle(fontSize: 45),))
                  ],)
              ],
            ),
          );
        }
    );
  }
  Future pickImage(ImageSource source, context, uid) async{
    try{
    final image = await ImagePicker().pickImage(source: source);
    if(image == null) return;
    final imageTemporaty = XFile(image.path);
    this.image = imageTemporaty;
    Navigator.pop(context);
    uploadImage(context, image, uid);
    } on PlatformException catch (e){
      debugPrint("Ocorreu um erro na gravação da imagem: $e");
    }
  }
  Future firestoreImage(file, uid) async{
  

  if(file == null) return;
  
  final destination = "ImagePerfil/$uid";
  
  task = FirestoreApi.uploadFile(destination, file!);
  if (task == null) return null;
  final snapshot = await task!.whenComplete(() {});
  final url = await snapshot.ref.getDownloadURL();
  await FirebaseFirestore.instance.collection("Usuarios").doc(uid).update({
     "imagem": url
   });

  }
  uploadImage(context, image, uid){
    File newimage = File(image.path);
    bool isloading = false;
    showDialog(context: context, builder: (BuildContext context){
      return StatefulBuilder(
      builder: (context, setState) {
      return AlertDialog(
        
        title: const Text("Alterar Imagem"),
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      backgroundColor: amareloClaro,
      actions: [
      (isloading == true)
      ?const ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(45)),
        child: SizedBox(
          width: 100,
          height: 25,
          child: LinearProgressIndicator(backgroundColor: rosa,
          color: azul,)
        ),
      )
      :const SizedBox(),
      Container(
        decoration: BoxDecoration( 
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(
            width: 3,
            color: Colors.red
          )
        ),
        child: 
        IconButton(
          tooltip: "Cancelar",
          onPressed: (){
            Navigator.pop(context);
          }, icon: const Icon(Icons.clear, color: Colors.red,)),
      ),
      Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(
            width: 3,
            color: Colors.green
          )
        ),
        child: 
        IconButton(
          tooltip: "Salvar",
          onPressed: () async {
            firestoreImage(newimage, uid);
              
          }, icon: const Icon(Icons.check, color: Colors.green,)),
      )
      ],
      content: SizedBox(
        width: MediaQuery.of(context).size.width *0.8,
        height: MediaQuery.of(context).size.width * 0.6 + 75,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10000)),
            child: Image.file(newimage, 
            width: MediaQuery.of(context).size.width*0.6,
            height: MediaQuery.of(context).size.width*0.6,
            fit: BoxFit.cover,),
          ),
          ]
        )

      ),
      );
      }
    );
    }
    );
  }
}

