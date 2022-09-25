import 'package:provider/provider.dart';
import 'package:sgm/services/auth_services.dart';
import 'package:sgm/shared/help/colors.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sgm/modules/users/stock/controllers/gerenciastock_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:sgm/shared/widgets/customButtom.dart';
import 'package:sgm/shared/widgets/custom_alert_dialog.dart';

class GerenciaStock extends StatefulWidget {
  final int carreta;
  final int cavalo;
  final Timestamp data;
  final String descricao;
  final String docSupervisor;
  final String imagem;
  final Map<String, dynamic> listMecanicos;
  final String titulo;
  final String itens;
  final String docRef;

  const GerenciaStock(
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
      Key? key})
      : super(key: key);

  @override
  State<GerenciaStock> createState() => _GerenciaStockState();
}

class _GerenciaStockState extends State<GerenciaStock> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextStyle styleform = GoogleFonts.poppins(
      fontSize: 20, fontWeight: FontWeight.w600, color: blue);
  bool _igm = false;
  bool _inStock = false;
  bool _inWait = false;

  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);
    final _controller = GerenciaStockController();
    List<String?> dataSupervisor = [];
    List<String?> dataMechanics = [];
    getCloudData() async {
      dataSupervisor =
          await _controller.getStringSupervisor(widget.docSupervisor);
      dataMechanics =
          await _controller.getStringMechanics(widget.listMecanicos);
    }

    return SafeArea(
        child: Scaffold(
            backgroundColor: lightyellow,
            appBar: AppBar(
              title: const Text(
                "Gerenciar Estoque",
                style: TextStyle(color: blue),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_rounded),
                color: blue,
                onPressed: _controller.navigateBack(context),
              ),
              backgroundColor: darkyellow,
            ),
            body: SingleChildScrollView(
                child: FutureBuilder(
                    future: getCloudData(),
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

                      if (snapshot.connectionState == ConnectionState.done) {
                        return SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(25),
                                child: Text(
                                  "Estoque da OS",
                                  style: GoogleFonts.poppins(
                                      fontSize: 27,
                                      fontWeight: FontWeight.w600,
                                      color: blue),
                                ),
                              ),
                              Container(
                                  width: 170,
                                  height: 170,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(7)),
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
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(7)),
                                      child: (widget.imagem != "imagem")
                                          ? FadeInImage.assetNetwork(
                                              placeholder:
                                                  "assets/pricipal/loading.gif",
                                              image: widget.imagem,
                                              fit: BoxFit.cover)
                                          : Image.asset(
                                              "assets/pricipal/noImage.png",
                                              fit: BoxFit.cover,
                                            ))),
                              Form(
                                key: formKey,
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 15, left: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Título:", style: styleform),
                                        TextFrame(
                                          textdata: widget.titulo,
                                        ),
                                        Text(
                                          "Descrição:",
                                          style: styleform,
                                        ),
                                        TextFrame(textdata: widget.descricao),
                                        Text(
                                          "Carreta:",
                                          style: styleform,
                                        ),
                                        TextFrame(
                                            textdata:
                                                widget.carreta.toString()),
                                        Text(
                                          "Cavalo:",
                                          style: styleform,
                                        ),
                                        TextFrame(
                                            textdata: widget.cavalo.toString()),
                                        Text(
                                          "Emitida pelo supervisor:",
                                          style: styleform,
                                        ),
                                        TextFrame(
                                            textdata: "Nome: " +
                                                dataSupervisor[0]! +
                                                "\n" +
                                                dataSupervisor[1]! +
                                                "\nCPF: " +
                                                dataSupervisor[2]!),
                                        Text(
                                          "Mecânicos:",
                                          style: styleform,
                                        ),
                                        TextFrame(
                                          textdata: (dataMechanics.length == 3)
                                              ? "Mecânico 1\nNome: " +
                                                  dataMechanics[0]! +
                                                  "\nE-mail: " +
                                                  dataMechanics[1]! +
                                                  "\nCPF: " +
                                                  dataMechanics[2]!
                                              : (dataMechanics.length == 6)
                                                  ? "Mecânico 1\nNome: " +
                                                      dataMechanics[0]! +
                                                      "\nE-mail: " +
                                                      dataMechanics[1]! +
                                                      "\nCPF: " +
                                                      dataMechanics[2]! +
                                                      "\nMecânico 2\nNome: " +
                                                      dataMechanics[3]! +
                                                      "\nE-mail: " +
                                                      dataMechanics[4]! +
                                                      "\nCPF: " +
                                                      dataMechanics[5]!
                                                  : (dataMechanics.length == 9)
                                                      ? "Mecânico 1\nNome: " +
                                                          dataMechanics[0]! +
                                                          "\nE-mail: " +
                                                          dataMechanics[1]! +
                                                          "\nCPF: " +
                                                          dataMechanics[2]! +
                                                          "Mecânico 2\nNome: " +
                                                          dataMechanics[3]! +
                                                          "\nE-mail: " +
                                                          dataMechanics[4]! +
                                                          "\nCPF: " +
                                                          dataMechanics[5]! +
                                                          "\nMecânico 3\nNome: " +
                                                          dataMechanics[6]! +
                                                          "\nE-mail: " +
                                                          dataMechanics[7]! +
                                                          "\nCPF: " +
                                                          dataMechanics[8]!
                                                      : ((dataMechanics
                                                                  .length ==
                                                              9)
                                                          ? "Mecânico 1\nNome: " +
                                                              dataMechanics[
                                                                  0]! +
                                                              "\nE-mail: " +
                                                              dataMechanics[
                                                                  1]! +
                                                              "\nCPF: " +
                                                              dataMechanics[
                                                                  2]! +
                                                              "Mecânico 2\nNome: " +
                                                              dataMechanics[
                                                                  3]! +
                                                              "\nE-mail: " +
                                                              dataMechanics[
                                                                  4]! +
                                                              "\nCPF: " +
                                                              dataMechanics[
                                                                  5]! +
                                                              "\nMecânico 3\nNome: " +
                                                              dataMechanics[
                                                                  6]! +
                                                              "\nE-mail: " +
                                                              dataMechanics[
                                                                  7]! +
                                                              "\nCPF: " +
                                                              dataMechanics[
                                                                  8]! +
                                                              "\nMecânico 4\nNome: " +
                                                              dataMechanics[
                                                                  9]! +
                                                              "\nE-mail: " +
                                                              dataMechanics[
                                                                  10]! +
                                                              "\nCPF: " +
                                                              dataMechanics[11]!
                                                          : "Ocorre um erro"),
                                        ),
                                        Text(
                                          "Data:",
                                          style: styleform,
                                        ),
                                        TextFrame(
                                            textdata: DateFormat(
                                                    "'Dia:' dd/MM/yyyy"
                                                    "'\nHorário:' HH:mm")
                                                .format(widget.data.toDate())),
                                        Text(
                                          "itens necessários:",
                                          style: styleform,
                                        ),
                                        TextFrame(
                                            textdata: (widget.itens != "")
                                                ? widget.itens
                                                : "Não foi cadastrado itens."),
                                        Text(
                                          "Cadastro IGM:",
                                          style: styleform,
                                        ),
                                        StatefulBuilder(builder:
                                            (BuildContext contexList,
                                                setstateList) {
                                          return SwitchListTile(
                                              activeColor: pink,
                                              visualDensity:
                                                  VisualDensity.compact,
                                              controlAffinity:
                                                  ListTileControlAffinity
                                                      .leading,
                                              secondary: const Icon(
                                                Icons.dns_outlined,
                                                color: blue,
                                              ),
                                              title: const Text(
                                                "Cadastro no IGM",
                                                style: TextStyle(color: blue),
                                              ),
                                              value: _igm,
                                              onChanged: (bool value) {
                                                setstateList(
                                                    () => _igm = !_igm);
                                              });
                                        }),
                                        Text(
                                          "Colocar em espera:",
                                          style: styleform,
                                        ),
                                        StatefulBuilder(builder:
                                            (BuildContext contexList,
                                                setstateList) {
                                          return SwitchListTile(
                                              activeColor: pink,
                                              visualDensity:
                                                  VisualDensity.compact,
                                              controlAffinity:
                                                  ListTileControlAffinity
                                                      .leading,
                                              secondary: const Icon(
                                                Icons.schedule,
                                                color: blue,
                                              ),
                                              title: const Text(
                                                "Colocar OS em espera",
                                                style: TextStyle(color: blue),
                                              ),
                                              value: _inWait,
                                              onChanged: (bool value) {
                                                setstateList(
                                                    () => _inWait = !_inWait);
                                              });
                                        }),
                                        Text(
                                          "Materiais em estoque:",
                                          style: styleform,
                                        ),
                                        StatefulBuilder(builder:
                                            (BuildContext contexList,
                                                setstateList) {
                                          return SwitchListTile(
                                              activeColor: pink,
                                              visualDensity:
                                                  VisualDensity.compact,
                                              controlAffinity:
                                                  ListTileControlAffinity
                                                      .leading,
                                              secondary: const Icon(
                                                Icons.inventory_2_outlined,
                                                color: blue,
                                              ),
                                              title: const Text(
                                                "Possui todos",
                                                style: TextStyle(color: blue),
                                              ),
                                              value: _inStock,
                                              onChanged: (bool value) {
                                                setstateList(
                                                    () => _inStock = !_inStock);
                                              });
                                        }),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              CustomButtom(
                                  text: "Atualizar OS",
                                  function: () async {
                                    if (_inWait == true) {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return const CustomAlertDialog(
                                              title: "Erro na solitação",
                                              message:
                                                  "Ainda não é possível colocar uma OS em espera",
                                              popOnCancel: true,
                                            );
                                          });
                                    } else if (_igm != true ||
                                        _inStock != true) {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return const CustomAlertDialog(
                                              title: "Erro na solitação",
                                              message:
                                                  "Para atualizar uma OS é preciso cadastrá-la no IGM e possuir os materiais em estoque",
                                              popOnCancel: true,
                                            );
                                          });
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                                title: const Center(
                                                    child: Text(
                                                        "Atualizando OS...")),
                                                backgroundColor: lightyellow,
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    15))),
                                                content: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                          shape:
                                                              BoxShape.circle),
                                                  height: 15,
                                                  child:
                                                      const LinearProgressIndicator(
                                                    color: blue,
                                                    backgroundColor: pink,
                                                  ),
                                                ));
                                          });
                                      await FirebaseFirestore.instance
                                          .collection("OSs")
                                          .doc(widget.docRef)
                                          .update({
                                        "igm": _igm,
                                        "esperaEst": _inWait,
                                        "estoquista": _inStock,
                                        "docEstoquista": auth.usuario!.uid
                                      });
                                      Navigator.pop(context);
                                      _controller.navigateBack(context);
                                      Navigator.pop(context);
                                      _controller.navigateBack(context);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "OS atualizada com sucesso!")));
                                    }
                                  })
                            ],
                          ),
                        );
                      } else {
                        return SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 1.2,
                          child: const Center(
                              child: SizedBox(
                            width: 150,
                            height: 150,
                            child: CircularProgressIndicator(
                              backgroundColor: blue,
                              strokeWidth: 10,
                              color: pink,
                            ),
                          )),
                        );
                      }
                    }))));
  }
}

class TextFrame extends StatelessWidget {
  final String textdata;
  const TextFrame({
    Key? key,
    required this.textdata,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
      child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.7),
              borderRadius: const BorderRadius.all(Radius.circular(8))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              textdata,
              style: const TextStyle(fontSize: 16),
            ),
          )),
    );
  }
}
