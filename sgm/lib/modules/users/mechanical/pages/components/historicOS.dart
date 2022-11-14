import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sgm/shared/help/colors.dart';
import 'package:intl/intl.dart';
import '../../../../service_order/models/service_order_model.dart';

class HistoricOS extends StatefulWidget {
  final ServiceOrderModel serviceOrder;
  final String uid;
  const HistoricOS({required this.serviceOrder, required this.uid, Key? key})
      : super(key: key);

  @override
  State<HistoricOS> createState() => _HistoricOSState();
}

class _HistoricOSState extends State<HistoricOS> {
  String addZero(int value) {
    return value < 10 ? "0$value" : "$value";
  }

  @override
  Widget build(BuildContext context) {
    var snapshots1 = FirebaseFirestore.instance
        .collection("OSs")
        .doc(widget.serviceOrder.id)
        .collection("trabalhos")
        .doc(widget.uid)
        .snapshots();

    return Container(
        height: 180,
        decoration: BoxDecoration(
          color: pink,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
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
                      borderRadius: const BorderRadius.all(Radius.circular(7)),
                      child: (widget.serviceOrder.imagem != "imagem")
                          ? FadeInImage.assetNetwork(
                              placeholder: "assets/pricipal/loading.gif",
                              image: widget.serviceOrder.imagem!,
                              fit: BoxFit.cover)
                          : Image.asset(
                              "assets/pricipal/noImage.png",
                              fit: BoxFit.cover,
                            )),
                ),
              ),
              SizedBox(
                height: 100,
                width: 205,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Titulo: " + widget.serviceOrder.titulo!,
                      style: GoogleFonts.alegreyaSc(
                          color: blue,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 250,
                      child: Text(
                        "Descrição: " + widget.serviceOrder.descricao!,
                        style: GoogleFonts.alegreyaSc(color: blue),
                        overflow: TextOverflow.fade,
                      ),
                    ),
                    RichText(
                        text: TextSpan(
                            style: GoogleFonts.alegreyaSc(
                                color: blue, fontSize: 10),
                            children: [
                          TextSpan(
                            text: DateFormat(
                              "'Dia:' dd/MM/yyyy  ",
                            ).format(widget.serviceOrder.data!.toDate()),
                          ),
                          TextSpan(
                            text: DateFormat("'Horário:' HH:mm")
                                .format(widget.serviceOrder.data!.toDate()),
                          )
                        ])),
                    StreamBuilder(
                        stream: snapshots1,
                        builder: (BuildContext context,
                            AsyncSnapshot<
                                    DocumentSnapshot<Map<String, dynamic>>>
                                snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text("Error ${snapshot.error}"),
                            );
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: blue,
                                backgroundColor: pink,
                              ),
                            );
                          }
                          Duration tempo =
                              Duration(seconds: snapshot.data!["tempo"]);

                          int hour = tempo.inHours;
                          int remainderMinutes = tempo.inMinutes.remainder(60);
                          int remainderSeconds = tempo.inSeconds.remainder(60);

                          String sHour = hour.toString();
                          String sRemainderMinutes =
                              remainderMinutes.toString();
                          String sRemainderSeconds =
                              remainderSeconds.toString();
                          return Text(
                            "Tempo na OS: "
                            '${sHour.padLeft(2, '0')}:${sRemainderMinutes.padLeft(2, '0')}:${sRemainderSeconds.padLeft(2, '0')}',
                            style: GoogleFonts.alegreyaSc(
                                color: darkyellow, fontWeight: FontWeight.bold),
                          );
                        })
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 2),
              child: RichText(
                  text: TextSpan(
                      style: GoogleFonts.alegreyaSc(color: blue),
                      children: [
                    TextSpan(
                        text: ("Carreta: " +
                            widget.serviceOrder.carreta.toString() +
                            "   ")),
                    TextSpan(
                        text: ("Cavalo: " +
                            widget.serviceOrder.cavalo.toString() +
                            "   ")),
                    TextSpan(text: ("ID OS: " + widget.serviceOrder.id!))
                  ])),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
            ),
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: (widget.serviceOrder.itens != "")
                    ? Text(
                        "Itens: " + widget.serviceOrder.itens!,
                        style: GoogleFonts.alegreyaSc(color: blue),
                      )
                    : Text("Itens: itens não foram cadastrados",
                        style: GoogleFonts.alegreyaSc(color: blue))),
          )
        ]));
  }
}
