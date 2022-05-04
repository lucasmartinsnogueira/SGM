// Tela de transição entre login e cadastro

import 'package:flutter/material.dart';
import 'package:sgm/modules/login_signup/cadastro.dart';
import 'package:sgm/modules/login_signup/login.dart';
import 'package:sgm/shared/help/colors.dart';



class LoginCadastro extends StatefulWidget {
  const LoginCadastro({ Key? key }) : super(key: key);

  @override
  _LoginCadastroState createState() => _LoginCadastroState();
}

class _LoginCadastroState extends State<LoginCadastro> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  double? margemParaMenuComClique;
  bool clicouNomeMenu = false;
 
  @override
  Widget build(BuildContext context) {
  double margemParaMenuSemClique = MediaQuery.of(context).size.width * 0.125;
  PageController _pageController = PageController();
  
   
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color(0XFFF2F2F2),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.30,
                  decoration: BoxDecoration(
                    
                    color: lightyellow,
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Stack(
                            children: [
                           SizedBox(
                      width: MediaQuery.of(context).size.width ,
                      height: MediaQuery.of(context).size.height * 0.22,
                      child: Image.asset("assets/pricipal/icone_app.png", fit: BoxFit.fitHeight,),
                      ),
                           Padding(
                             padding: const EdgeInsets.only(
                               left: 10
                             ),
                             child: SizedBox(
                               child: IconButton(
                                      icon: const Icon(Icons.expand_more_rounded,
                                      size: 45,
                                      color: blue,),
                                      onPressed: (){
                                        Navigator.pop(context);
                                      }, 
                                    ),
                             ),
                           ),
                            ]
                          )
                        ],
                      ),
                     
                        Column(
                          children: [
                          Row(
                            children: [
                              Expanded(child: TextButton(
                      style: TextButton.styleFrom(
                        primary: blue
                      ),
                      onPressed: () {
                      setState(() {
                      clicouNomeMenu = true;
                      margemParaMenuComClique = MediaQuery.of(context).size.width * 0.125;
                      _pageController.animateToPage(0, duration: const Duration(milliseconds: 300), curve: Curves.decelerate);
                      });
                      },
                      child: Text("Entrar", style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: MediaQuery.of(context).size.width * 0.048,
                      color: blue
                      ),),
                     
                    ),),
                              
                    Expanded(child: TextButton(
                      autofocus: false,
                      style: TextButton.styleFrom(
                        primary: blue
                      ),
                      onPressed: () {
                      setState(() {
                      clicouNomeMenu = true;
                      margemParaMenuComClique = MediaQuery.of(context).size.width * 0.625;
                       _pageController.animateToPage(1, duration: const Duration(milliseconds: 300), curve: Curves.decelerate);
                      });
                      },
                      child: Text("Cadastrar", style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: MediaQuery.of(context).size.width * 0.048,
                      color: blue
                      ),),
                     
                    ),)
                            ],
                          ),
                       
                          AnimatedPadding(
                            duration: const Duration(microseconds: 180000),
                            
                            padding: EdgeInsets.only(
                              left: clicouNomeMenu == false ? margemParaMenuSemClique : margemParaMenuComClique!,
                                                 
                            ),
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 10
                                ),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: blue,
                                    borderRadius: BorderRadius.all(Radius.circular(10))
                                  ),
                                  width: MediaQuery.of(context).size.width * 0.25,
                                  height: 12,
                                ),
                              ),
                            ),
                          ),
                          ]
                        ),
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - (MediaQuery.of(context).size.height * 0.30 + MediaQuery.of(context).padding.top),
                  child: PageView(
                    pageSnapping: false,
                    controller: _pageController,
                    onPageChanged: (index){
                     
                      debugPrint(index.toString());
                      setState(() {
                      clicouNomeMenu = true;
                      if(index == 0){
                         margemParaMenuComClique = MediaQuery.of(context).size.width * 0.125;
                      }
                      else if(index == 1){
                         margemParaMenuComClique = MediaQuery.of(context).size.width * 0.625;
                      }
                      });
                    },
                    children: const [
                     Login(),
                     Cadastro(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}