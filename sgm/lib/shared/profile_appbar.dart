import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:provider/provider.dart';
import 'package:sgm/services/auth_services.dart';
import 'package:sgm/shared/cores.dart';
import 'package:sgm/visao/iniciais/inicial_supervisor.dart';

class ProfileAppBart extends StatefulWidget {


const ProfileAppBart({ Key? key }) : super(key: key);

 

  @override
  State<ProfileAppBart> createState() => _ProfileAppBartState();
}

class _ProfileAppBartState extends State<ProfileAppBart> {
  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context); 
    var snapshots = FirebaseFirestore.instance.collection("Usuarios").doc((auth.usuario != null)? auth.usuario!.uid : null).snapshots();
    return StreamBuilder(
     stream: snapshots,
     builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
       if(snapshot.hasError){
          return Center(
            child: Text("Error ${snapshot.error}"),
          );
                 }
      if (snapshot.connectionState == ConnectionState.waiting){
          return const Center(
            child: CircularProgressIndicator(),
          );
      }
      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 8
        ),
        child: Container(
          width: 40,
          height: 40,
            decoration: BoxDecoration(
              boxShadow:  [
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  spreadRadius: 3,
                  blurRadius: 3,
                  offset: const Offset(0, 1), 
              ),
          ],
              shape: BoxShape.circle,
                border: Border.all(
                color: amareloClaro
              )
            ),        
            child: 
              (snapshot.data!["imagem"] != null)
              ?ClipRRect(                    
                borderRadius: const BorderRadius.all(Radius.circular(70)),
                child: GestureDetector(
                  onTap: (){
                    
                    
                    },
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const CircularProgressIndicator(
                    color: rosa,
                    backgroundColor: azul,
                    strokeWidth: 13,
                  ),
                    imageUrl: snapshot.data!["imagem"].toString()                   ),
                  ),
              )
              : ClipRRect(
                
                borderRadius: const BorderRadius.all(Radius.circular(70)),
                 child: Image.asset("assets/usuarios/supervisor.png",
                 fit: BoxFit.cover, 
                ),
              )
        ),
      );
     },
    );
  }
}