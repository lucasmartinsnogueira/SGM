import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sgm/modules/service_order/models/service_order_model.dart';
import 'package:sgm/modules/users/mechanical/pages/components/historic_work.dart';
import 'package:sgm/modules/users/mechanical/pages/components/open_os.dart';
import 'package:sgm/services/auth_services.dart';
import 'package:sgm/shared/help/colors.dart';
import 'package:sgm/shared/help/profile_appbar.dart';
import 'package:sgm/shared/widgets/custom_drawer.dart';

class HomeMechanical extends StatefulWidget {
  const HomeMechanical({Key? key}) : super(key: key);

  @override
  _HomeMechanicalState createState() => _HomeMechanicalState();
}

class _HomeMechanicalState extends State<HomeMechanical> {
  Future<dynamic> getTrabalhos(docid, userUid) async {
    dynamic dataTrabalho;
    await FirebaseFirestore.instance
        .collection("OSs")
        .doc(docid)
        .collection("trabalhos")
        .doc(userUid)
        .get()
        .then((datasnapshot) {
      dataTrabalho = datasnapshot.data()!["status"];
    });

    return dataTrabalho;
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);

    var snapshots1 = FirebaseFirestore.instance
        .collection("OSs")
        .where("estoquista", isEqualTo: true)
        .where("mecanicos",
            whereIn: ([
              {"mecanico1": auth.usuario!.uid},
              {"mecanico2": auth.usuario!.uid},
              {"mecanico3": auth.usuario!.uid},
              {"mecanico4": auth.usuario!.uid}
            ]))
        .orderBy("data", descending: false)
        .snapshots();

    return (Scaffold(
      drawer: const CustomDrawer(color: pink, secondaryColor: Colors.black),
      key: scaffoldKey,
      backgroundColor: lightyellow,
      body: SafeArea(
        child: StreamBuilder(
            stream: snapshots1,
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
              return CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    shape: const ContinuousRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25))),
                    backgroundColor: pink,
                    shadowColor: Colors.black,
                    leading: IconButton(
                      onPressed: () => Scaffold.of(context).openDrawer(),
                      icon: const Icon(
                        Icons.density_medium_rounded,
                        color: Colors.black,
                      ),
                    ),
                    actions: const <Widget>[
                      ProfileAppBar(
                        nameColor: Colors.black,
                      )
                    ],
                    pinned: true,
                    floating: true,
                    expandedHeight: 120.0,
                    flexibleSpace: const Center(
                      child: FlexibleSpaceBar(
                        title: Text(
                          'Mecânico',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "Ferramentas",
                            style: GoogleFonts.poppins(
                                fontSize: 27,
                                fontWeight: FontWeight.w600,
                                color: blue),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 180,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    /* Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ViewOSstockPage(
                                                uidStock: auth.usuario!.uid,
                                              )),
                                    );*/
                                  },
                                  child: const HistoricWork())
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, bottom: 10, left: 10),
                          child: Text(
                            "OS abertas",
                            style: GoogleFonts.poppins(
                                fontSize: 27,
                                fontWeight: FontWeight.w600,
                                color: blue),
                          ),
                        ),
                      ],
                    )),
                  ),
                  (snapshot.data!.docs.isNotEmpty)
                      ? SliverGrid.count(
                          crossAxisSpacing: 5,
                          childAspectRatio: (1 / 1.5),
                          crossAxisCount: 2,
                          children: snapshot.data!.docs.map((document1) {
                            return FutureBuilder(
                                future: getTrabalhos(
                                    document1.id, auth.usuario!.uid),
                                builder: (BuildContext context,
                                    AsyncSnapshot<dynamic> snapshotTrabalhos) {
                                  if (snapshot.hasData) {
                                    ServiceOrderModel newOS =
                                        ServiceOrderModel();
                                    newOS.carreta = document1["carreta"];
                                    newOS.cavalo = document1["cavalo"];
                                    newOS.data = document1["data"];
                                    newOS.descricao = document1["descricao"];
                                    newOS.docEstoquista =
                                        document1["docEstoquista"];
                                    newOS.docEstoquista =
                                        document1["descricao"];
                                    newOS.docSupervisor =
                                        document1["docSupervisor"];
                                    newOS.esperaEst = document1["esperaEst"];
                                    newOS.estoquista = document1["estoquista"];
                                    newOS.igm = document1["igm"];
                                    newOS.imagem = document1["imagem"];
                                    newOS.itens = document1["itens"];
                                    newOS.titulo = document1["titulo"];
                                    newOS.mecanicos = document1["mecanicos"];
                                    newOS.id = document1.id;
                                    newOS.status = snapshotTrabalhos.data;
                                    return OpenOS(newOS: newOS);
                                  } else if (snapshot.hasError) {
                                    return const Center(
                                      child: Text(
                                          "Houve algum erro, entre em contato com a equipe SGM."),
                                    );
                                  } else {
                                    return const Center(
                                      child: CircularProgressIndicator(
                                        color: blue,
                                        backgroundColor: pink,
                                      ),
                                    );
                                  }
                                });
                          }).toList())
                      : const SliverToBoxAdapter(
                          child: Center(
                              child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 50),
                          child: Text(
                            "Não há OS abertas no momento",
                            style: TextStyle(fontSize: 20),
                          ),
                        ))),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 15,
                    ),
                  )
                ],
              );
            }),
      ),
    ));
  }
}
