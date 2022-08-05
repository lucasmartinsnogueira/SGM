import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sgm/modules/users/stock/controllers/home_stock_Controller.dart';
import 'package:sgm/shared/help/colors.dart';
import 'package:sgm/shared/help/profile_appbar.dart';
import 'package:sgm/shared/widgets/custom_alert_dialog.dart';

class HomeStock extends StatefulWidget {
  const HomeStock({Key? key}) : super(key: key);

  @override
  _HomeStockState createState() => _HomeStockState();
}

class _HomeStockState extends State<HomeStock> {
  final _controller = HomeStockController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      key: scaffoldKey,
      backgroundColor: lightyellow,
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              shape: const ContinuousRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25))),
              backgroundColor: darkyellow,
              shadowColor: Colors.black,
              leading: IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: const Icon(
                    Icons.density_medium,
                    color: blue,
                  )),
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
                    'Mecânico',
                    style: TextStyle(color: blue),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: StreamBuilder(
                  stream: _controller.snapshots,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("Error ${snapshot.error}"),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return SizedBox(
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
                                  showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const CustomAlertDialog(
                                      title: "Em desenvolvimento",
                                      message:
                                          "Gerenciamento de OSs está em desenvolvimento",
                                      popOnCancel: true,
                                    );
                                  },
                                );
                                },
                                child: const Text("Gerenciamento de atividades"))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "OS em espera",
                            style: GoogleFonts.poppins(
                                fontSize: 27,
                                fontWeight: FontWeight.w600,
                                color: blue),
                          ),
                        ),
                        ],
                      )
                    );
                  }),
            )
          ],
        ),
      ),
    ));
  }
}