import 'package:sgm/modules/users/stock/pages/gerenciastock.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeStockController extends ChangeNotifier {
  Future<String> getString(docSupervisor) async {
    String? nameSupervisor;
    await FirebaseFirestore.instance
        .collection("Usuarios")
        .doc(docSupervisor)
        .get()
        .then((datasnapshot) {
      if (datasnapshot.data() != null) {
        nameSupervisor = datasnapshot.data()!["nome"];
      } else {
        nameSupervisor = "Erro";
      }
    });

    return nameSupervisor ?? "Carregando";
  }

  void Function() gerenciaEstoque(context, titulo, descricao, carreta, cavalo,
      imagem, supervisor, mecanicos, data, itens, docRef, esperaEst) {
    return () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => GerenciaStock(
                    titulo: titulo,
                    descricao: descricao,
                    carreta: carreta,
                    cavalo: cavalo,
                    docSupervisor: supervisor,
                    listMecanicos: mecanicos,
                    data: data,
                    imagem: imagem,
                    itens: itens,
                    docRef: docRef,
                    esperaEst: esperaEst,
                  )));
    };
  }

  void Function() navigateBack(context) {
    return () {
      Navigator.pop(context);
    };
  }
}
