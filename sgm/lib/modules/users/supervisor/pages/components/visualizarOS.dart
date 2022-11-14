import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sgm/modules/users/mechanical/pages/home_mechanical.dart';
import 'package:sgm/services/auth_services.dart';
import 'package:sgm/shared/help/colors.dart';
import 'package:intl/intl.dart';

import '../../../../service_order/models/service_order_model.dart';

class VisualizarOS extends StatefulWidget {
  const VisualizarOS({Key? key}) : super(key: key);

  @override
  State<VisualizarOS> createState() => _VisualizarOSState();
}

class _VisualizarOSState extends State<VisualizarOS> {
  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);
    var snapshots = FirebaseFirestore.instance
        .collection("OSs")
        .where("docSupervisor", isEqualTo: auth.usuario!.uid)
        .orderBy("data", descending: true)
        .snapshots();

    return Scaffold(
        backgroundColor: lightyellow,
        appBar: AppBar(
          title: const Text(
            "Visualização de OS",
            style: TextStyle(color: lightyellow),
          ),
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_rounded,
              ),
              color: lightyellow,
              onPressed: () => Navigator.pop(context)),
          backgroundColor: blue,
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
                        "OS emitidas",
                        style: GoogleFonts.poppins(
                            fontSize: 27,
                            fontWeight: FontWeight.w600,
                            color: blue),
                      ),
                    ),
                    Row(
                      children: const [
                        Legenda(
                          color: Color.fromARGB(176, 95, 207, 101),
                          text: "Finalizada",
                        ),
                        Legenda(
                          color: pink,
                          text: "Aguandando Execução",
                        ),
                      ],
                    ),
                    const Legenda(
                      color: darkyellow,
                      text: "Agurdando Aprovação",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 1.52,
                        child: ListView(
                            children: snapshot.data!.docs.map((document) {
                          Color boxColor;
                          ServiceOrderModel newService = ServiceOrderModel(
                              carreta: document["carreta"],
                              cavalo: document["cavalo"],
                              data: document["data"],
                              descricao: document["descricao"],
                              docSupervisor: document["docSupervisor"],
                              feita: document["feita"],
                              igm: document["igm"],
                              imagem: document["imagem"],
                              itens: document["itens"],
                              mecanicos: document["mecanicos"],
                              titulo: document["titulo"],
                              id: document.id);
                          if (document["feita"] == true) {
                            boxColor = const Color.fromARGB(176, 95, 207, 101);
                          } else if (document["feita"] == false &&
                              document["estoquista"] == true) {
                            boxColor = pink;
                          }
                          else{
                            boxColor = darkyellow;
                          }
                          return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 8),
                              child: Container(
                                  height: 180,
                                  decoration: BoxDecoration(
                                    color: boxColor,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.5),
                                        spreadRadius: 3,
                                        blurRadius: 5,
                                        offset: const Offset(0, 3),
                                      )
                                    ],
                                  ),
                                  child: Column(children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            width: 100,
                                            height: 100,
                                            child: ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(7)),
                                                child: (newService.imagem !=
                                                        "imagem")
                                                    ? FadeInImage.assetNetwork(
                                                        placeholder:
                                                            "assets/pricipal/loading.gif",
                                                        image:
                                                            newService.imagem!,
                                                        fit: BoxFit.cover)
                                                    : Image.asset(
                                                        "assets/pricipal/noImage.png",
                                                        fit: BoxFit.cover,
                                                      )),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 205,
                                          height: 100,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Titulo: " + newService.titulo!,
                                                style: GoogleFonts.alegreyaSc(
                                                    color: blue,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                width: 250,
                                                child: Text(
                                                  "Descrição: " +
                                                      newService.descricao!,
                                                  style: GoogleFonts.alegreyaSc(
                                                      color: blue),
                                                  overflow: TextOverflow.fade,
                                                ),
                                              ),
                                              RichText(
                                                  text: TextSpan(
                                                      style: GoogleFonts
                                                          .alegreyaSc(
                                                              color: blue),
                                                      children: [
                                                    TextSpan(
                                                      text: DateFormat(
                                                              "'Dia:' dd/MM/yyyy  ")
                                                          .format(newService
                                                              .data!
                                                              .toDate()),
                                                    ),
                                                    TextSpan(
                                                      text: DateFormat(
                                                              "'Horário:' HH:mm")
                                                          .format(newService
                                                              .data!
                                                              .toDate()),
                                                    )
                                                  ]))
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, bottom: 2),
                                        child: RichText(
                                            text: TextSpan(
                                                style: GoogleFonts.alegreyaSc(
                                                    color: blue),
                                                children: [
                                              TextSpan(
                                                  text: ("Carreta: " +
                                                      newService.carreta
                                                          .toString() +
                                                      "   ")),
                                              TextSpan(
                                                  text: ("Cavalo: " +
                                                      newService.cavalo
                                                          .toString() +
                                                      "   ")),
                                              TextSpan(
                                                  text: ("ID OS: " +
                                                      newService.id!))
                                            ])),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 10,
                                      ),
                                      child: SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: (newService.itens != "")
                                              ? Text(
                                                  "Itens: " + newService.itens!,
                                                  style: GoogleFonts.alegreyaSc(
                                                      color: blue),
                                                )
                                              : Text(
                                                  "Itens: itens não foram cadastrados",
                                                  style: GoogleFonts.alegreyaSc(
                                                      color: blue))),
                                    )
                                  ])));
                        }).toList()),
                      ),
                    )
                  ],
                ),
              );
            }));
  }
}
