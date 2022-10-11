import 'package:provider/provider.dart';
import 'package:sgm/modules/service_order/models/service_order_model.dart';
import 'package:sgm/services/auth_services.dart';
import 'package:sgm/shared/help/colors.dart';
import 'package:intl/intl.dart';
import 'package:sgm/modules/users/stock/controllers/gerenciastock_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:sgm/shared/widgets/custom_alert_dialog.dart';

class WorkOS extends StatefulWidget {
  final ServiceOrderModel newOS;
  const WorkOS({required this.newOS, Key? key}) : super(key: key);

  @override
  State<WorkOS> createState() => _GerenciaStockState();
}

class _GerenciaStockState extends State<WorkOS> {
  TextStyle styleform = GoogleFonts.poppins(
      fontSize: 20, fontWeight: FontWeight.w600, color: blue);

  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);
    final _controller = GerenciaStockController();
    List<String?> dataSupervisor = [];
    List<String?> dataMechanics = [];
    getCloudData() async {
      dataSupervisor =
          await _controller.getStringSupervisor(widget.newOS.docSupervisor);
      dataMechanics =
          await _controller.getStringMechanics(widget.newOS.mecanicos);
    }

    return SafeArea(
        child: Scaffold(
            backgroundColor: lightyellow,
            appBar: AppBar(
              title: const Text(
                "Controle da OS",
                style: TextStyle(color: Colors.black),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_rounded),
                color: Colors.black,
                onPressed: _controller.navigateBack(context),
              ),
              backgroundColor: pink,
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
                                  "Efetuar OS",
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
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 15, left: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Título:", style: styleform),
                                      TextFrame(
                                        textdata: widget.newOS.titulo!,
                                      ),
                                      Text(
                                        "Descrição:",
                                        style: styleform,
                                      ),
                                      TextFrame(
                                          textdata: widget.newOS.descricao!),
                                      Text(
                                        "Carreta:",
                                        style: styleform,
                                      ),
                                      TextFrame(
                                          textdata:
                                              widget.newOS.carreta.toString()),
                                      Text(
                                        "Cavalo:",
                                        style: styleform,
                                      ),
                                      TextFrame(
                                          textdata:
                                              widget.newOS.cavalo.toString()),
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
                                                    : ((dataMechanics.length ==
                                                            9)
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
                                                            dataMechanics[8]! +
                                                            "\nMecânico 4\nNome: " +
                                                            dataMechanics[9]! +
                                                            "\nE-mail: " +
                                                            dataMechanics[10]! +
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
                                              .format(
                                                  widget.newOS.data!.toDate())),
                                      Text(
                                        "itens necessários:",
                                        style: styleform,
                                      ),
                                      TextFrame(
                                          textdata: (widget.newOS.itens != "")
                                              ? widget.newOS.itens!
                                              : "Não foi cadastrado itens."),
                                      const SizedBox(
                                        height: 110,
                                      )
                                    ],
                                  ),
                                ),
                              ),
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
                    })),
            bottomSheet: Container(
              height: 100,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.8),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  )
                ],
                color: pink,
              ),
              child: const Text("Aqui ficará o contadr"),
            )));
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
