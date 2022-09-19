import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GerenciaStockController extends ChangeNotifier {
  Future<List<String?>> getStringSupervisor(docSupervisor) async {
    List<String?>? nameSupervisor = [];
    await FirebaseFirestore.instance
        .collection("Usuarios")
        .doc(docSupervisor)
        .get()
        .then((datasnapshot) {
      nameSupervisor.add(datasnapshot.data()!["nome"]);
      nameSupervisor.add(datasnapshot.data()!["email"]);
      nameSupervisor.add(datasnapshot.data()!["cpf"]);
    });

    return nameSupervisor;
  }

  Future<List<String?>> getStringMechanics(listMecanicos) async {
    List<String> dataMecanicos = [];
    for (int i = 0; i < listMecanicos.length; i++) {
      await FirebaseFirestore.instance
          .collection("Usuarios")
          .doc(listMecanicos["mecanico${0 + 1}"])
          .get()
          .then((datasnapshot) {
        dataMecanicos.add(datasnapshot.data()!["nome"]);
        dataMecanicos.add(datasnapshot.data()!["email"]);
        dataMecanicos.add(datasnapshot.data()!["cpf"]);
      });
    }

    return dataMecanicos;
  }

  void Function() navigateBack(context) {
    return () {
      Navigator.pop(context);
    };
  }
}
