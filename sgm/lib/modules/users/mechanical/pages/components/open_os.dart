import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sgm/modules/service_order/models/service_order_model.dart';
import 'package:sgm/modules/users/mechanical/pages/home_mechanical.dart';
import 'package:sgm/modules/users/mechanical/pages/work_os.dart';
import 'package:sgm/modules/users/stock/controllers/home_stock_controller.dart';
import 'package:sgm/shared/widgets/custom_alert_dialog.dart';
import '../../../../../shared/help/colors.dart';

class OpenOS extends StatefulWidget {
  final ServiceOrderModel newOS;
  const OpenOS({required this.newOS, Key? key}) : super(key: key);

  @override
  State<OpenOS> createState() => _OpenOSState();
}

class _OpenOSState extends State<OpenOS> {
  @override
  Widget build(BuildContext context) {
    Color colorWidget = pink;

    if (widget.newOS.tempoEspec != 0) {
      colorWidget = darkyellow;
    } else if (widget.newOS.status == true) {
      colorWidget = const Color.fromARGB(176, 95, 207, 101);
    }
    final _controller = HomeStockController();
    String? nameSupervisor;
    getSupervisorName() async {
      nameSupervisor = await _controller.getString(widget.newOS.docSupervisor);
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
          }
          return Padding(
              padding: const EdgeInsets.all(8.0),
              child: PhysicalModel(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  color: colorWidget,
                  elevation: 15,
                  child: Column(
                    children: [
                      Text(widget.newOS.titulo!,
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
                              child: (widget.newOS.imagem != "imagem")
                                  ? FadeInImage.assetNetwork(
                                      placeholder:
                                          "assets/pricipal/loading.gif",
                                      image: widget.newOS.imagem!,
                                      fit: BoxFit.cover)
                                  : Image.asset(
                                      "assets/pricipal/noImage.png",
                                      fit: BoxFit.cover,
                                    ))),
                      const SizedBox(
                        height: 7,
                      ),
                      Text(
                          DateFormat("'Dia:' dd/MM/yyyy")
                              .format(widget.newOS.data!.toDate()),
                          style: GoogleFonts.alegreyaSc(color: blue)),
                      Text(
                          DateFormat("'Horário:' HH:mm")
                              .format(widget.newOS.data!.toDate()),
                          style: GoogleFonts.alegreyaSc(color: blue)),
                      Text(
                        "Supervisor: " +
                            nameSupervisor.toString().split(' ').first,
                        style: GoogleFonts.alegreyaSc(color: blue),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 5),
                          child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: blue),
                                  foregroundColor: blue),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: const [
                                  Text("Iniciar"),
                                  Icon(Icons.play_arrow)
                                ],
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => WorkOS(
                                              newOS: widget.newOS,
                                            ))).then(
                                  (value) {
                                    debugPrint("Reconstrução da Página");
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const HomeMechanical()),
                                        (route) => false);
                                  },
                                );
                              }))
                    ],
                  )));
        });
  }
}
