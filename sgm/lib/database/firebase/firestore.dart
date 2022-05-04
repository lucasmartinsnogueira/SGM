
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sgm/modules/users/mechanical/pages/home_mecanico.dart';
import 'package:sgm/modules/users/stock/pages/home_estoque.dart';
import 'package:sgm/modules/users/supervisor/pages/inicial_supervisor.dart';
import 'package:sgm/services/auth_services.dart';


// Criação do Usuário
criacaoUser(String codUser, String categoria, String nome, String cpf, String email){
  FirebaseFirestore db = FirebaseFirestore.instance;
  bool ativado = false;

  db.collection("Usuarios").doc(codUser).set({
    "categoria" : categoria,
    "nome" : nome,
    "cpf": cpf,
    "email": email,
    "ativado": ativado,
    "imagem": null
  });
}

// Vericação da ativação

vefificarAtivacao(context) async {
  String usuario = AuthService().auth.currentUser!.uid.toString();
  var result = await FirebaseFirestore.instance.collection("Usuarios").doc(usuario).get();  
  String categoria = result["categoria"];
  bool ativado = result["ativado"];
  if(ativado == true && categoria == "Mecânico"){
      Navigator.pushReplacement(
        context,
        PageTransition(
        child: const HomeMecanico(),
        type: PageTransitionType.bottomToTop)
        );
        
  }
  else if(ativado == true && categoria == "Estoque"){
     Navigator.pushReplacement(
        context,
        PageTransition(
        child: const HomeEstoque(),
        type: PageTransitionType.bottomToTop)
        );
  }
  else if(ativado == true && categoria == "Supervisor"){
    Navigator.pushReplacement(
        context,
        PageTransition(
        child: const InicialSupervisor(),
        type: PageTransitionType.bottomToTop)
        );
  }
}