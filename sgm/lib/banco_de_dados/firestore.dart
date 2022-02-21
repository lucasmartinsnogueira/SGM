import 'package:cloud_firestore/cloud_firestore.dart';

criacaoUser(String codUser, String nome, String cpf, String email){
  FirebaseFirestore db = FirebaseFirestore.instance;
  bool ativado = false;

  db.collection("Usuarios").doc(codUser).set({
    "nome" : nome,
    "cpf": cpf,
    "email": email,
    "ativado": ativado
  });
}