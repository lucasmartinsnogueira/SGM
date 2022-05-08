// Tela de início do app.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sgm/modules/login_signup/pages/login_cadastro.dart';
import 'package:sgm/shared/help/colors.dart';

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
      statusBarColor: lightyellow,
      statusBarIconBrightness: Brightness.dark
    ));

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: lightyellow,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.03,
                        left: 25
                      ),
                      child: const CircleAvatar(
                        backgroundColor: blue,
                        radius: 98,
                        child: CircleAvatar(
                        radius: 90,
                        backgroundImage: AssetImage('assets/pricipal/icone_app.png'),
                       ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.03,
                        left: 25
                      ),
                      child: const Text(
                        'Sistema de Gestão\nda Mecânica',
                        style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 30,
                              color: blue
                            ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.45,
                  child: Image.asset("assets/pricipal/tela_inicial.png")),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: 60,
                  child: TextButton(
                    style: TextButton.styleFrom(
                    backgroundColor: darkyellow,
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: const BorderSide(color: blue, width: 3)
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
                    color: blue
                    ),),
                   
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(
                    top: MediaQuery.of(context).size.height * 0.03
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Todos direitos reservados © 2022 Codil Alimentos Ltda.',
                        style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              color: blue
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}