import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sgm/modules/users/stock/controllers/home_stock_controller.dart';
import 'package:sgm/shared/help/colors.dart';
import 'package:intl/intl.dart';
import 'package:sgm/shared/widgets/custom_alert_dialog.dart';

class Oswaitwidget extends StatefulWidget {
  final int? carreta;
  final int? cavalo;
  final Timestamp data;
  final String descricao;
  final String docSupervisor;
  final String imagem;
  final List listMecanicos;
  final String titulo;
  final String itens;
  final String docRef;
  final bool espeEst;

  const Oswaitwidget(
      {required this.carreta,
      required this.cavalo,
      required this.data,
      required this.descricao,
      required this.docSupervisor,
      required this.imagem,
      required this.listMecanicos,
      required this.titulo,
      required this.itens,
      required this.docRef,
      required this.espeEst,
      Key? key})
      : super(key: key);

  @override
  State<Oswaitwidget> createState() => _OswaitwidgetState();
}

class _OswaitwidgetState extends State<Oswaitwidget> {
  @override
  Widget build(BuildContext context) {
 
    final _controller = HomeStockController();
    String? nameSupervisor;
    getSupervisorName() async {
      nameSupervisor = await _controller.getString(widget.docSupervisor);
    }

    return FutureBuilder(
        future: getSupervisorName(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const CustomAlertDialog(
                  title: "Erro!",
                  message:
                      "Ocorreu um erro inesperando. Entre em contato com a equpe SGM",
                  popOnCancel: true,
                );
              },
            );

            return const Center(
                child: SizedBox(
              width: 150,
              height: 150,
              child: CircularProgressIndicator(
                backgroundColor: blue,
                strokeWidth: 10,
                color: pink,
              ),
            ));
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: PhysicalModel(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  color: darkyellow,
                  elevation: 15,
                  child: Column(
                    children: [
                      Text(widget.titulo,
                          style: GoogleFonts.alegreyaSc(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Container(
                          height: 2,
                          width: 80,
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.7)),
                        ),
                      ),
                      Container(
                        width: 130,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(7)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.6),
                              spreadRadius: 0.7,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            )
                          ],
                        ),
                        child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(7)),
                            child: (widget.imagem != "imagem")
                            ?
                            FadeInImage.assetNetwork(
                                placeholder: "assets/pricipal/loading.gif",
                                image: widget.imagem,
                                fit: BoxFit.cover)
                                : Image.asset("assets/pricipal/noImage.png", fit: BoxFit.cover,)
                                )
                              
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Text(
                          DateFormat("'Dia:' dd/MM/yyyy")
                              .format(widget.data.toDate()),
                          style: GoogleFonts.alegreyaSc(color: blue)),
                      Text(
                          DateFormat("'Horário:' HH:mm")
                              .format(widget.data.toDate()),
                          style: GoogleFonts.alegreyaSc(color: blue)),
                      Text(
                        "Supervisor: " +
                            nameSupervisor.toString().split(' ').first,
                        style: GoogleFonts.alegreyaSc(color: blue),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: pink),
                                foregroundColor: pink),
                            onPressed: _controller.gerenciaEstoque(
                                context,
                                widget.titulo,
                                widget.descricao,
                                widget.carreta,
                                widget.cavalo,
                                widget.imagem,
                                widget.docSupervisor,
                                widget.listMecanicos,
                                widget.data,
                                widget.itens,
                                widget.docRef,
                                widget.espeEst
                                ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: const [
                                Text("Gerenciar"),
                                Icon(Icons.inventory_2_outlined)
                              ],
                            )),
                      )
                    ],
                  )),
            );
          }
        });
  }
}
