import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sgm/database/firebase/firestore_api.dart';
import 'package:sgm/database/firebase/storagefunc.dart';
import 'package:sgm/shared/help/colors.dart';


class ImagePickerClass{
  UploadTask? task;  
  XFile? image; 
  void showImagePicker(context, uid, imagem){
     showBottomSheet(context: context,
     backgroundColor: Colors.transparent,
        builder: (BuildContext context){ 
          return Container(
            decoration: const BoxDecoration(
              color: lightyellow,
              borderRadius: BorderRadius.vertical(top: Radius.circular(40))
            ),
            height: 150,
            child: Row(
             
              children: [
                const Spacer(),
                GestureDetector(
                  onTap: () => pickImage(ImageSource.gallery, context, uid),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.perm_media, size: 40, color: blue,),
                      Text("Arquivo", style: TextStyle(fontSize: 20, color: blue),)
                    ],
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: ()=> pickImage(ImageSource.camera, context, uid),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.camera, size: 40, color: blue,),
                      Text("Câmera", style: TextStyle(fontSize: 20, color: blue),)
                    ],),
                ),
                const Spacer(),
                (imagem != null)
                ?GestureDetector(
                  onTap: () async {
                    await FirebaseFirestore.instance.collection("Usuarios").doc(uid).update({
                    "imagem": null
              });
                 StorageFunc().delete(imagem);
                 Navigator.pop(context);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.delete, size: 40, color: pink,),
                      Text("Deletar", style: TextStyle(fontSize: 20, color: pink),)
                    ],),
                )
                :const SizedBox(),
                 (imagem != null)
                 ?const Spacer()
                 :const SizedBox()

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
      backgroundColor: lightyellow,
      actions: [
      (isloading == true)
      ?const ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(45)),
        child: SizedBox(
          width: 100,
          height: 25,
          child: LinearProgressIndicator(backgroundColor: pink,
          color: blue,)
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
            setState(() {
              isloading = true;
               });
            await firestoreImage(newimage, uid);
            Navigator.pop(context);
              
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

