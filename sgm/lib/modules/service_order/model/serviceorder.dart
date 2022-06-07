import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceOrder {
  String? title;
  List<Map<String, dynamic>> mechanicals = [];
  int? cavalo;
  int? carreta;
  String? description;
  bool? done;
  bool? stock;
  bool? igm;
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
      this.itens,
      this.image,
      this.docSupervisor,
      this.data);

      Future<String> registerOS(ServiceOrder registerOS) async {
       DocumentReference docRef = await FirebaseFirestore.instance.collection("OSs").add({
      "titulo": registerOS.title,
      "mecanicos": registerOS.mechanicals,
      "cavalo": registerOS.cavalo,
      "descricao": registerOS.description,
      "feita": registerOS.done,
      "estoquista": registerOS.stock,
      "igm": registerOS.igm,
      "imagem": registerOS.image,
      "docSupervisor": registerOS.docSupervisor
      
    }
    
    );
    return  docRef.id;
      }
}
