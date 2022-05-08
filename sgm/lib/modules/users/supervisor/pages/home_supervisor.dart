// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgm/services/auth_services.dart';
import 'package:sgm/shared/help/colors.dart';
import 'package:sgm/shared/help/profile_appbar.dart';

class HomeSupervisor extends StatefulWidget {
  const HomeSupervisor({ Key? key }) : super(key: key);

  @override
  State<HomeSupervisor> createState() => _HomeSupervisorState();
}

class _HomeSupervisorState extends State<HomeSupervisor> {
  @override
  Widget build(BuildContext context) {

    AuthService auth = Provider.of<AuthService>(context); 

    var snapshots = FirebaseFirestore.instance.collection("Usuarios").snapshots();
    return SafeArea(
      child: CustomScrollView(
       slivers: <Widget>[
        SliverAppBar(
          shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25))),
          backgroundColor: blue,
          shadowColor: Colors.black,
          leading: IconButton(onPressed: (){
             Scaffold.of(context).openDrawer();
          }, icon: Icon(Icons.density_medium)),
          actions: const <Widget>[
            ProfileAppBart()
          ],
          pinned: true,
          floating: true,
          expandedHeight: 120.0,
          flexibleSpace: Center(
            child: FlexibleSpaceBar(
              title: Text('Supervisor'),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: StreamBuilder(
            stream: snapshots,
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot){
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
                 

              return Container(
                height: 700,
                width: 300,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: snapshot.data!.docs.map((document){
                      return Center(
                        child: Container(
                          width: 100,
                          height: 100,
                          child: Text(document["nome"]),
                        ),
                      );
                  }).toList(),
                ),
              );
              /*return SizedBox(
                height: 700,
                width: 100,
                 child: ListView.builder(
                  itemCount: snapshots.length,
                  itemBuilder: (context, index){
                    return Text(snapshot.data.map);
                  },
                    
                );*/
              
              
            }
          ),
        )
        
        
      ],
      
      ),
    );
  }
  
}