import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sgm/shared/help/colors.dart';
import 'package:sgm/shared/widgets/CustomOSViewWidget.dart';

import '../../../service_order/models/service_order_model.dart';


class ViewOSstockPage extends StatefulWidget {
  final String uidStock;
  const ViewOSstockPage({required this.uidStock, Key? key}) : super(key: key);

  @override
  State<ViewOSstockPage> createState() => _ViewOSstockState();
}

class _ViewOSstockState extends State<ViewOSstockPage> {
 
  @override
  Widget build(BuildContext context) {
     var snapshots = FirebaseFirestore.instance
        .collection("OSs")
        .where("estoquista", isEqualTo: true).where("docEstoquista", isEqualTo: widget.uidStock)
        .orderBy("data", descending: true)
        .snapshots();
    
    return Scaffold(
        backgroundColor: lightyellow,
        appBar: AppBar(
          title: const Text(
            "Visualização de OS",
            style: TextStyle(color: blue),
          ),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_rounded),
              color: blue,
              onPressed: () => Navigator.pop(context)),
          backgroundColor: darkyellow,
        ),
        body: StreamBuilder(
            stream: snapshots,
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("Error ${snapshot.error}"),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: blue,
                    backgroundColor: pink,
                  ),
                );
              }
              return SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 10, bottom: 20),
                      child: Text(
                        "OS aprovadas",
                        style: GoogleFonts.poppins(
                            fontSize: 27,
                            fontWeight: FontWeight.w600,
                            color: blue),
                      ),
                    ),
                    
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height/1.262,
                            child: ListView(
                                children: snapshot.data!.docs.map((document) {
                              ServiceOrderModel newService = ServiceOrderModel(
                                  carreta: document["carreta"],
                                  cavalo: document["cavalo"],
                                  data: document["data"],
                                  descricao: document["descricao"],
                                  docEstoquista: document["docEstoquista"],
                                  docSupervisor: document["docSupervisor"],
                                  esperaEst: document["esperaEst"],
                                  estoquista: document["estoquista"],
                                  feita: document["feita"],
                                  igm: document["igm"],
                                  imagem: document["imagem"],
                                  itens: document["itens"],
                                  mecanicos: document["mecanicos"],
                                  titulo: document["titulo"],
                                  id: document.id);
                                  
              
                              return CustomOSViewWidget(
                                serviceOrder: newService,
                              );
                            }).toList()),
                          ),
                        )
                  ],
                ),
              );
            }));
  }
}
