
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class HomeStockController extends ChangeNotifier {
dynamic snapshots;
  void getOSatributes() {
     snapshots = FirebaseFirestore.instance
        .collection("Usuarios")
        .where("categoria", isEqualTo: "Mecânico")
        .where("ativado", isEqualTo: true)
        .orderBy("nome")
        .snapshots();
  }
}
