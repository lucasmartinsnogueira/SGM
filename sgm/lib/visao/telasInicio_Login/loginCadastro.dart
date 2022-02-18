// Tela de Login e Cadastro no aplicativo.

import 'package:flutter/material.dart';
import 'package:sgm/Pacote_de_Ajuda/cores.dart';

class LoginCadastro extends StatefulWidget {
  const LoginCadastro({ Key? key }) : super(key: key);

  @override
  _LoginCadastroState createState() => _LoginCadastroState();
}

class _LoginCadastroState extends State<LoginCadastro> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color(0XFFF2F2F2),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.30,
                decoration: BoxDecoration(
                  
                  color: amareloClaro,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50)

                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.7),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), 
                    )
    ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}