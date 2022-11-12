import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sgm/modules/users/mechanical/pages/components/historicOS.dart';
import 'package:sgm/services/auth_services.dart';
import 'package:sgm/shared/help/colors.dart';
import '../../../service_order/models/service_order_model.dart';

class HistoricMecPage extends StatefulWidget {
  final String uidMec;
  const HistoricMecPage({required this.uidMec, Key? key}) : super(key: key);

  @override
  State<HistoricMecPage> createState() => _HistoricMecState();
}

class _HistoricMecState extends State<HistoricMecPage> {
  int globalCount = -1;
  List<dynamic> dataTrabalho = [];
  Future<List<dynamic>> getTrabalhos(docid, userUid) async {
    await FirebaseFirestore.instance
        .collection("OSs")
        .doc(docid)
        .collection("trabalhos")
        .doc(userUid)
        .get()
        .then((datasnapshot) {
      dataTrabalho.add(datasnapshot.data()!["tempo"]);
    });

    return dataTrabalho;
  }

  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);
    var snapshots = FirebaseFirestore.instance
        .collection("OSs")
        .where("estoquista", isEqualTo: true)
        .where("mecanicos", arrayContainsAny: ([auth.usuario!.uid]))
        .where("feita", isEqualTo: true)
        .orderBy("data", descending: true)
        .snapshots();

    return Scaffold(
        backgroundColor: lightyellow,
        appBar: AppBar(
          title: const Text(
            "Histórico de Trabalho",
            style: TextStyle(color: blue),
          ),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_rounded),
              color: blue,
              onPressed: () => Navigator.pop(context)),
          backgroundColor: pink,
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
                          const EdgeInsets.only(top: 20, left: 10, bottom: 15),
                      child: Text(
                        "OS realizadas",
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
                        height: MediaQuery.of(context).size.height / 1.27,
                        child: ListView(
                            children: snapshot.data!.docs.map((document1) {
                          ServiceOrderModel newService = ServiceOrderModel(
                              carreta: document1["carreta"],
                              cavalo: document1["cavalo"],
                              data: document1["data"],
                              descricao: document1["descricao"],
                              docEstoquista: document1["docEstoquista"],
                              docSupervisor: document1["docSupervisor"],
                              esperaEst: document1["esperaEst"],
                              estoquista: document1["estoquista"],
                              feita: document1["feita"],
                              igm: document1["igm"],
                              imagem: document1["imagem"],
                              itens: document1["itens"],
                              mecanicos: document1["mecanicos"],
                              titulo: document1["titulo"],
                              id: document1.id);

                          return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 8),
                              child: HistoricOS(
                                serviceOrder: newService,
                                uid: auth.usuario!.uid,
                              ));
                        }).toList()),
                      ),
                    )
                  ],
                ),
              );
            }));
  }
}
