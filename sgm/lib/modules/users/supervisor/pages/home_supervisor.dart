import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sgm/modules/users/supervisor/pages/components/tools_supervisor.dart';
import 'package:sgm/modules/users/supervisor/pages/components/visualizarOS.dart';
import 'package:sgm/modules/users/supervisor/pages/inicial_supervisor.dart';
import 'package:sgm/shared/help/colors.dart';
import 'package:sgm/shared/help/profile_appbar.dart';
import 'package:sgm/modules/users/supervisor/pages/formOSs.dart';

class HomeSupervisor extends StatefulWidget {
  const HomeSupervisor({Key? key}) : super(key: key);

  @override
  State<HomeSupervisor> createState() => _HomeSupervisorState();
}

class _HomeSupervisorState extends State<HomeSupervisor> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: blue, statusBarIconBrightness: Brightness.light));

    var snapshots = FirebaseFirestore.instance
        .collection("Usuarios")
        .where("categoria", isEqualTo: "Mecânico")
        .where("ativado", isEqualTo: true)
        .orderBy("nome")
        .snapshots();
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
                    backgroundColor: blue,
                    shadowColor: Colors.black,
                    leading: IconButton(
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                        icon: const Icon(
                          Icons.density_medium,
                          color: lightyellow,
                        )),
                    actions: const <Widget>[ProfileAppBar()],
                    pinned: true,
                    floating: true,
                    expandedHeight: 120.0,
                    flexibleSpace: const Center(
                      child: FlexibleSpaceBar(
                        title: Text(
                          'Supervisor',
                          style: TextStyle(color: lightyellow),
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
                                                builder: (context) =>
                                                    const VisualizarOS()));
                                      },
                                      child: const ManageOSsWidget())
                                ],
                              )),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 25, left: 10, right: 10, bottom: 10),
                            child: Text(
                              "Mecânicos",
                              style: GoogleFonts.poppins(
                                  fontSize: 27,
                                  fontWeight: FontWeight.w600,
                                  color: blue),
                            ),
                          ),
                        ]),
                  )),
                  (snapshot.data!.docs.isNotEmpty)
                      ? SliverGrid.count(
                          crossAxisSpacing: 5,
                          childAspectRatio: (1 / 1.5),
                          crossAxisCount: 2,
                          children: snapshot.data!.docs.map((document) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, right: 8, bottom: 8, top: 8),
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: pink,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 4,
                                        ),
                                      ]),
                                  child: Column(
                                    children: [
                                      Text(
                                        document["categoria"],
                                        style: GoogleFonts.alegreyaSc(
                                            fontSize: 20,
                                            fontStyle: FontStyle.italic),
                                      ),
                                      Container(
                                        height: 22,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        color: Colors.grey,
                                        child: Center(
                                            child: Text(
                                          "Transcodil",
                                          style: GoogleFonts.alegreyaSc(),
                                        )),
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                                width: 60,
                                                height: 60,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(0.4),
                                                        spreadRadius: 3,
                                                        blurRadius: 3,
                                                        offset:
                                                            const Offset(0, 1),
                                                      ),
                                                    ],
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                        color: lightyellow)),
                                                child: (document["imagem"] !=
                                                        null)
                                                    ? ClipRRect(
                                                        borderRadius:
                                                            const BorderRadius
                                                                    .all(
                                                                Radius.circular(
                                                                    70)),
                                                        child: GestureDetector(
                                                          child:
                                                              CachedNetworkImage(
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  placeholder: (context,
                                                                          url) =>
                                                                      const CircularProgressIndicator(
                                                                        color:
                                                                            pink,
                                                                        backgroundColor:
                                                                            blue,
                                                                        strokeWidth:
                                                                            13,
                                                                      ),
                                                                  imageUrl: document[
                                                                          "imagem"]
                                                                      .toString()),
                                                        ),
                                                      )
                                                    : ClipRRect(
                                                        borderRadius:
                                                            const BorderRadius
                                                                    .all(
                                                                Radius.circular(
                                                                    70)),
                                                        child: Image.asset(
                                                          "assets/users/mechanic.png",
                                                          fit: BoxFit.cover,
                                                        ),
                                                      )),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Nome:",
                                                style: GoogleFonts.alegreyaSc(),
                                              ),
                                              Text(
                                                  document["nome"]
                                                          .toString()
                                                          .split(" ")
                                                          .getRange(0, 1)
                                                          .toString()
                                                          .replaceAll("(", "")
                                                          .replaceAll(")", "")
                                                          .replaceAll(",", "") +
                                                      "\n" +
                                                      document["nome"]
                                                          .toString()
                                                          .split(" ")
                                                          .getRange(1, 2)
                                                          .toString()
                                                          .replaceAll("(", "")
                                                          .replaceAll(")", "")
                                                          .replaceAll(",", ""),
                                                  style: GoogleFonts.alegreyaSc(
                                                    color: darkyellow,
                                                  )),
                                              Text("CPF:",
                                                  style:
                                                      GoogleFonts.alegreyaSc()),
                                              Text(document["cpf"],
                                                  style: GoogleFonts.alegreyaSc(
                                                      color: darkyellow))
                                            ],
                                          )
                                        ],
                                      ),
                                      Text("E-mail",
                                          style: GoogleFonts.alegreyaSc()),
                                      Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 20,
                                          color: Colors.grey,
                                          child: Center(
                                              child: Text(document["email"],
                                                  style: GoogleFonts.alegreyaSc(
                                                      color: darkyellow,
                                                      fontSize: 12)))),
                                      Align(
                                          alignment: Alignment.bottomRight,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, right: 10),
                                            child: SizedBox(
                                                height: 50,
                                                child: FloatingActionButton(
                                                  heroTag: null,
                                                  onPressed: () {
                                                    List<Map<String, dynamic>>?
                                                        mapDocMec = [];
                                                    for (var element in snapshot
                                                        .data!.docs) {
                                                      mapDocMec.add({
                                                        "name": element["nome"],
                                                        "id": element.id,
                                                        "selected": false
                                                      });
                                                    }
                                                    debugPrint("oi" +
                                                        mapDocMec.toString());
                                                    showBottomSheet(
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return FormOSs(
                                                              mapDoc:
                                                                  mapDocMec);
                                                        });
                                                  },
                                                  backgroundColor: blue,
                                                  child: Icon(
                                                    Icons.add_rounded,
                                                    color: Colors.green[700],
                                                    size: 40,
                                                  ),
                                                  tooltip: "Adicionar OSs",
                                                )),
                                          )),
                                    ],
                                  )),
                            );
                          }).toList())
                      : const SliverToBoxAdapter(
                          child: Center(
                              child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 50),
                          child: Text(
                            "Não há mecânicos.",
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
            }));
  }
}
