import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sgm/Pacote_de_Ajuda/cores.dart';

class ImagePickerClass{
  XFile? image;
  void showImagePicker(context){
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
                      onTap: () => pickImage(ImageSource.gallery, context),
                      child: const Text("Arquivo ", style: TextStyle(fontSize: 45),))
                  ],
                ),
                Column(children: [
                    GestureDetector(
                      onTap: ()=> pickImage(ImageSource.camera, context),
                      child: const Text("Câmera", style: TextStyle(fontSize: 45),))
                  ],)
              ],
            ),
          );
        }
    );
  }
  Future pickImage(ImageSource source, context) async{
    try{
    final image = await ImagePicker().pickImage(source: source);
    if(image == null) return;
    final imageTemporaty = XFile(image.path);
    this.image = imageTemporaty;
    Navigator.pop(context);
    uploadImage(context, image);
    } on PlatformException catch (e){
      debugPrint("Ocorreu um erro na gravação da imagem: $e");
    }
  }
  uploadImage(context, image){
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

