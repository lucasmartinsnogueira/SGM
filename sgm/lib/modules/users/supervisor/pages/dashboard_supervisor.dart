import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphic/graphic.dart';
import 'package:sgm/shared/help/colors.dart';
import 'package:sgm/shared/help/profile_appbar.dart';

class DashboardSupervisor extends StatefulWidget {
  const DashboardSupervisor({Key? key}) : super(key: key);

  @override
  State<DashboardSupervisor> createState() => _DashboardSupervisorState();
}

class _DashboardSupervisorState extends State<DashboardSupervisor> {
  List<Map<dynamic, dynamic>>? data1;
  List<Map<dynamic, dynamic>>? data2;
  DateTime time = DateTime.now();
  Duration month = const Duration(days: 60);

  Future<List<Map<dynamic, dynamic>>> getdata1() async {
    QuerySnapshot _myDocMec = await FirebaseFirestore.instance
        .collection('Usuarios')
        .where("categoria", isEqualTo: "Mecânico")
        .where("ativado", isEqualTo: true)
        .get();
    List<DocumentSnapshot> _myMecCount = _myDocMec.docs;
    QuerySnapshot _myDocEst = await FirebaseFirestore.instance
        .collection('Usuarios')
        .where("categoria", isEqualTo: "Estoque")
        .where("ativado", isEqualTo: true)
        .get();
    List<DocumentSnapshot> _myEstCount = _myDocEst.docs;
    QuerySnapshot _myDocSup = await FirebaseFirestore.instance
        .collection('Usuarios')
        .where("categoria", isEqualTo: "Supervisor")
        .where("ativado", isEqualTo: true)
        .get();
    List<DocumentSnapshot> _mySupCount = _myDocSup.docs;
    data1 = [
      {'category': 'Mecânicos', 'Quantidade': _myMecCount.length},
      {'category': 'Estoquistas', 'Quantidade': _myEstCount.length},
      {'category': 'Supervisores', 'Quantidade': _mySupCount.length}
    ];
    return data1!;
  }

  Future<List<Map<dynamic, dynamic>>> getdata2(date) async {
    QuerySnapshot _myDocEmit = await FirebaseFirestore.instance
        .collection('OSs')
        .where("estoquista", isEqualTo: false)
        .where("data", isGreaterThan: date)
        .get();
    List<DocumentSnapshot> _myEmitCount = _myDocEmit.docs;
    QuerySnapshot _myDocAprov = await FirebaseFirestore.instance
        .collection('OSs')
        .where("estoquista", isEqualTo: true)
        .where("feita", isEqualTo: false)
        .get();
    List<DocumentSnapshot> _myAprovCount = _myDocAprov.docs;
    QuerySnapshot _myDocFin = await FirebaseFirestore.instance
        .collection('OSs')
        .where("feita", isEqualTo: true)
        .get();
    List<DocumentSnapshot> _myFinCount = _myDocFin.docs;
    data2 = [
      {'category': 'OS Emitida', 'Quantidade': _myEmitCount.length},
      {'category': 'OS Aprovada', 'Quantidade': _myAprovCount.length},
      {'category': 'OS Finalizada', 'Quantidade': _myFinCount.length}
    ];
    return data2!;
  }

  @override
  Widget build(BuildContext context) {
    DateTime newDate = time.subtract(month);
    Timestamp myTimeStamp = Timestamp.fromDate(newDate);
    return Scaffold(
        backgroundColor: lightyellow,
        appBar: AppBar(
          toolbarHeight: 70,
          backgroundColor: blue,
          title: Text(
            "Relatórios",
            style: GoogleFonts.poppins(
                fontSize: 23, fontWeight: FontWeight.w600, color: lightyellow),
          ),
          actions: const <Widget>[
            ProfileAppBar(
              nameColor: lightyellow,
            )
          ],
        ),
        body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "Usuários Ativos",
              style: GoogleFonts.poppins(
                  fontSize: 22, fontWeight: FontWeight.w600, color: blue),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          FutureBuilder(
              future: getdata1(),
              builder:
                  (BuildContext context, AsyncSnapshot<dynamic> snapshot1) {
                if (snapshot1.connectionState == ConnectionState.done) {
                  return Container(
                      height: 400,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: -5,
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          )
                        ],
                      ),
                      child: Chart(
                        data: data1!,
                        variables: {
                          'category': Variable(
                            accessor: (Map map) => map['category'] as String,
                          ),
                          'Quantidade': Variable(
                            accessor: (Map map) => map['Quantidade'] as num,
                            scale: LinearScale(min: 0),
                          ),
                        },
                        transforms: [
                          Proportion(
                            variable: 'Quantidade',
                            as: 'percent',
                          ),
                        ],
                        elements: [
                          IntervalElement(
                            position: Varset('percent') / Varset('category'),
                            modifiers: [StackModifier()],
                            color: ColorAttr(
                                variable: 'category',
                                values: [pink, darkyellow, blue]),
                            label: LabelAttr(
                              encoder: (tuple) => Label(
                                  tuple['category'] +
                                      ": " +
                                      tuple['Quantidade'].toString(),
                                  LabelStyle(
                                    style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  )),
                            ),
                          )
                        ],
                        coord: PolarCoord(
                          transposed: true,
                          dimCount: 1,
                        ),
                      ));
                } else if (snapshot1.hasError) {
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
              }),
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "OS dos últimos 60 dias",
              style: GoogleFonts.poppins(
                  fontSize: 22, fontWeight: FontWeight.w600, color: blue),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          FutureBuilder(
              future: getdata2(myTimeStamp),
              builder:
                  (BuildContext context, AsyncSnapshot<dynamic> snapshot2) {
                if (snapshot2.connectionState == ConnectionState.done) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 500,
                    child: Chart(
                      data: data2!,
                      variables: {
                        'category': Variable(
                          accessor: (Map map) => map['category'] as String,
                        ),
                        'Quantidade': Variable(
                          accessor: (Map map) => map['Quantidade'] as num,
                        ),
                      },
                      elements: [
                        IntervalElement(
                          label: LabelAttr(
                            encoder: (tuple) => Label(
                                tuple['Quantidade'].toString(),
                                LabelStyle(
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                )),
                          ),
                          color: ColorAttr(
                              variable: 'category',
                              values: [blue, darkyellow, Colors.lightGreen]),
                        )
                      ],
                      axes: [
                        AxisGuide(
                          line: StrokeStyle(color: Colors.black),
                          grid:
                              StrokeStyle(color: Colors.black.withOpacity(0.5)),
                          label: LabelStyle(
                              style: const TextStyle(
                                  fontSize: 10, color: Colors.black)),
                        ),
                        AxisGuide(
                          grid:
                              StrokeStyle(color: Colors.black.withOpacity(0.5)),
                          label: LabelStyle(
                            style: const TextStyle(
                                fontSize: 10, color: Colors.black),
                            offset: const Offset(-7.5, 0),
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (snapshot2.hasError) {
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
              }),
          const SizedBox(
            height: 35,
          )
        ])));
  }
}
