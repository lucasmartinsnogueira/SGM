import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sgm/modules/service_order/models/service_order_model.dart';
import 'package:sgm/modules/users/mechanical/pages/components/historic_work.dart';
import 'package:sgm/modules/users/mechanical/pages/components/open_os.dart';
import 'package:sgm/modules/users/mechanical/pages/historic.dart';
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
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);

    var snapshots1 = FirebaseFirestore.instance
        .collection("OSs")
        .where("estoquista", isEqualTo: true)
        .where("mecanicos", arrayContainsAny: ([auth.usuario!.uid]))
        .where("feita", isEqualTo: false)
        .orderBy("data", descending: false)
        .snapshots();

    return 
      SafeArea(
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
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HistoricMecPage(
                                                uidMec: auth.usuario!.uid,
                                              )),
                                    );
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
                        Row(
                          children: const [
                            Legenda(
                              color: pink,
                              text: "OS não iniciada",
                            ),
                            Legenda(
                              color: darkyellow,
                              text: "OS iniciada",
                            ),
                          ],
                        ),
                        const Legenda(
                          color: Color.fromARGB(176, 95, 207, 101),
                          text: "OS aguardando grupo",
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    )),
                  ),
                  (snapshot.data!.docs.isNotEmpty)
                      ? SliverGrid.count(
                          crossAxisSpacing: 5,
                          childAspectRatio: (1 / 1.65),
                          crossAxisCount: 2,
                          children: snapshot.data!.docs.map((document1) {
                            ServiceOrderModel newOS = ServiceOrderModel();
                            newOS.carreta = document1["carreta"];
                            newOS.cavalo = document1["cavalo"];
                            newOS.data = document1["data"];
                            newOS.descricao = document1["descricao"];
                            newOS.docEstoquista = document1["docEstoquista"];
                            newOS.docEstoquista = document1["descricao"];
                            newOS.docSupervisor = document1["docSupervisor"];
                            newOS.esperaEst = document1["esperaEst"];
                            newOS.estoquista = document1["estoquista"];
                            newOS.igm = document1["igm"];
                            newOS.imagem = document1["imagem"];
                            newOS.itens = document1["itens"];
                            newOS.titulo = document1["titulo"];
                            newOS.mecanicos = document1["mecanicos"];
                            newOS.id = document1.id;

                            return OpenOS(newOS: newOS, uid: auth.usuario!.uid);
                          }).toList())
                      : const SliverToBoxAdapter(
                          child: Center(
                              child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 50),
                          child: Text(
                            "Não há OS abertas no momento.",
                            style: TextStyle(fontSize: 20),
                          ),
                        ))),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 25,
                    ),
                  )
                ],
              );
            }),
      );
  
  }
}

class Legenda extends StatelessWidget {
  final String text;
  final Color color;
  const Legenda({
    required this.color,
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                    color: color,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.6),
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset: const Offset(0, 2),
                      )
                    ],
                    shape: BoxShape.circle),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  text,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600, color: blue),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
