import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sgm/modules/users/stock/pages/components/view_OS_Stock.dart';
import 'package:sgm/modules/users/stock/pages/viewOSstock.dart';
import 'package:sgm/services/auth_services.dart';
import 'package:sgm/shared/help/colors.dart';
import 'package:sgm/shared/help/profile_appbar.dart';
import 'package:sgm/shared/widgets/custom_drawer.dart';
import 'package:sgm/shared/widgets/custom_os_wait_widget.dart';

class HomeStock extends StatefulWidget {
  const HomeStock({Key? key}) : super(key: key);

  @override
  _HomeStockState createState() => _HomeStockState();
}

class _HomeStockState extends State<HomeStock> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  var snapshots = FirebaseFirestore.instance
      .collection("OSs")
      .where("estoquista", isEqualTo: false)
      .orderBy("data", descending: true)
      .snapshots();
  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);
    return SafeArea(
      child: StreamBuilder(
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
            return CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  shape: const ContinuousRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25))),
                  backgroundColor: darkyellow,
                  shadowColor: Colors.black,
                  leading: IconButton(
                    onPressed: () => Scaffold.of(context).openDrawer(),
                    icon: const Icon(
                      Icons.density_medium_rounded,
                      color: blue,
                    ),
                  ),
                  actions: const <Widget>[
                    ProfileAppBar(
                      nameColor: blue,
                    )
                  ],
                  pinned: true,
                  floating: true,
                  expandedHeight: 120.0,
                  flexibleSpace: const Center(
                    child: FlexibleSpaceBar(
                      title: Text(
                        'Estoque',
                        style: TextStyle(color: blue),
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
                                        builder: (context) => ViewOSstockPage(
                                              uidStock: auth.usuario!.uid,
                                            )),
                                  );
                                },
                                child: const ViewOstock())
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20, bottom: 10, left: 10),
                        child: Text(
                          "OS sem validação",
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
                        childAspectRatio: (1 / 1.65),
                        crossAxisCount: 2,
                        children: snapshot.data!.docs.map((document) {
                          return Oswaitwidget(
                              carreta: document["carreta"],
                              cavalo: document["cavalo"],
                              data: document["data"],
                              descricao: document["descricao"],
                              docSupervisor: document["docSupervisor"],
                              imagem: document["imagem"],
                              listMecanicos: document["mecanicos"],
                              titulo: document["titulo"],
                              itens: document["itens"],
                              docRef: document.reference.id,
                              espeEst: document["esperaEst"]);
                        }).toList())
                    : const SliverToBoxAdapter(
                        child: Center(
                            child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 50),
                        child: Text(
                          "Não há OS sem validação.",
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
    );
  }
}
