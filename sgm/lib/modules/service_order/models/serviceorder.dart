import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceOrder {
  String? title;
  Map<String, dynamic> mechanicals = {};
  int? cavalo;
  int? carreta;
  String? description;
  bool? done;
  bool? stock;
  bool? igm;
  bool? waitStock;
  String? itens;
  String? image;
  String? docSupervisor;
  DateTime? data;

  ServiceOrder(
      this.title,
      this.mechanicals,
      this.cavalo,
      this.carreta,
      this.description,
      this.done,
      this.stock,
      this.igm,
      this.waitStock,
      this.itens,
      this.image,
      this.docSupervisor,
      this.data);

  Future<String> registerOS(ServiceOrder registerOS) async {
    DocumentReference docRef =
        await FirebaseFirestore.instance.collection("OSs").add({
      "titulo": registerOS.title,
      "mecanicos": registerOS.mechanicals,
      "cavalo": registerOS.cavalo,
      "carreta": registerOS.carreta,
      "descricao": registerOS.description,
      "feita": registerOS.done,
      "estoquista": registerOS.stock,
      "igm": registerOS.igm,
      "esperaEst": registerOS.waitStock,
      "itens": registerOS.itens,
      "imagem": registerOS.image,
      "docSupervisor": registerOS.docSupervisor,
      "data": registerOS.data,
    });
    return docRef.id;
  }

  Future<void> registerDocEachMec(String docOS, String uidMec) async {
    await FirebaseFirestore.instance
        .collection("OSs")
        .doc(docOS)
        .collection("trabalhos")
        .doc(uidMec)
        .set({
      "status": false,
      "mec": uidMec,  
      // "tempo": 0 #esse tempo vai dar.
    });
  }
}
