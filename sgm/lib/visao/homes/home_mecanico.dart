import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:sgm/Pacote_de_Ajuda/cores.dart';
import 'package:sgm/main.dart';
import 'package:sgm/services/auth_services.dart';

class HomeMecanico extends StatefulWidget {
  const HomeMecanico({ Key? key }) : super(key: key);

  @override
  _HomeMecanicoState createState() => _HomeMecanicoState();
}

class _HomeMecanicoState extends State<HomeMecanico> {

  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: amareloClaro,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
               GestureDetector(
                onTap: () async {
                 await context.read<AuthService>().logout();
                 Navigator.pushReplacement(
                 context,
                 PageTransition(
                 child: const MyApp(),
                type: PageTransitionType.topToBottom)
                );
                },
                child: const Center(child: Padding(
                  padding: EdgeInsets.only(
                    left: 25,
                    right: 25,
                    top: 300
                  ),
                  child: Text(
                    "Home Estoque, clique aqui para sair", 
                    textAlign: TextAlign.center,
                    style: TextStyle(
                    color: azul, 
                    fontSize: 30
                  ),
                  ),
                )))
              ],
            ),
          ),
        ),
      ),
    );
  }
}