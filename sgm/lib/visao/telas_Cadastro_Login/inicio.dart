// Tela de início do app.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sgm/Pacote_de_Ajuda/cores.dart';
import 'package:sgm/visao/telas_Cadastro_Login/login_cadastro.dart';

class Inicio extends StatefulWidget {
  const Inicio({ Key? key }) : super(key: key);

  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
 
  
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: amareloClaro,
      statusBarIconBrightness: Brightness.dark
    ));

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: amareloClaro,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: const [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(25, 0, 0, 0),
                    child: CircleAvatar(
                      backgroundColor: azul,
                      radius: 98,
                      child: CircleAvatar(
                      radius: 90,
                      backgroundImage: AssetImage('assets/pricipal/icone_app.png'),
                     ),
                    )
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: const [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(25, 50, 0, 0),
                    child: Text(
                      'Sistema de Gestão\nda Mecânica',
                      style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 30,
                            color: azul
                          ),
                    ),
                  ),
                ],
              ),
             /* SvgPicture.asset(
                'assets/images/Tela_incial.svg',
                width: 400,
                height: 400,
                fit: BoxFit.contain,
              ),*/
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                child: SizedBox(
                  width: 300,
                  height: 60,
                  child: TextButton(
                    style: TextButton.styleFrom(
                    backgroundColor: amareloEscuro,
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: const BorderSide(color: azul, width: 3)
                    ),
                    elevation: 6,
                    
                    ),
                    onPressed: () {
                      Navigator.push(
                         context,
                         PageTransition(
                           child: const LoginCadastro(),
                           type: PageTransitionType.bottomToTop)
                        );
                      debugPrint('Button pressed ...');
                    },
                    child: const Text("Começar", style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 20,
                    color: azul
                    ),),
                   
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Todos direitos reservados © 2022 Codil Alimentos Ltda.',
                      style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            color: azul
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}