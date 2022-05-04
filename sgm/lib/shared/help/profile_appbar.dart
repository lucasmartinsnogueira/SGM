import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sgm/services/auth_services.dart';
import 'package:sgm/shared/help/colors.dart';


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
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Text(snapshot.data!["nome"].toString().split(" ").first, style: GoogleFonts.barlowCondensed(color:lightyellow, fontSize: 22)),
            ),
            Container(
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
                    color: lightyellow
                  )
                ),        
                child: 
                  (snapshot.data!["imagem"] != null)
                  ?ClipRRect(                    
                    borderRadius: const BorderRadius.all(Radius.circular(70)),
                    child: GestureDetector(
                      onTap: (){
                        
                        // colocar uma função que volta para a página de usuário
                        },
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const CircularProgressIndicator(
                        color: pink,
                        backgroundColor: blue,
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
          ],
        ),
      );
     },
    );
  }
}