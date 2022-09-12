import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sgm/modules/users/stock/pages/gerenciaStock.dart';

class HomeStockController extends ChangeNotifier {
  Future<String> getString(docSupervisor) async {
    String? nameSupervisor;
    await FirebaseFirestore.instance
        .collection("Usuarios")
        .doc(docSupervisor)
        .get()
        .then((datasnapshot) {
      nameSupervisor = datasnapshot.data()!["nome"];
    });

    return nameSupervisor ?? "Carregando";
  }

  void Function() gerenciaEstoque(context) {
    return () {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const GerenciaStock()));
    };
  }

  void Function() navigateBack(context) {
    return () {
      Navigator.pop(context);
    };
  }
}
