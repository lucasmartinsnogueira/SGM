import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgm/Pacote_de_Ajuda/cores.dart';
import 'package:sgm/banco_de_dados/firestore.dart';
import 'package:sgm/services/auth_services.dart';

import 'package:sgm/widgets/custom_alert_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      backgroundColor: amareloClaro,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: FutureBuilder(
            future: vefificarAtivacao(context),
            builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done){
              if(snapshot.hasError){
                showDialog(
                  context: context,
                    builder: (BuildContext context) {
                      return const CustomAlertDialog(
                        title: "Erro!",
                        message: "Ocorreu um erro inesperando. Entre em contato com a equpe SGM",
                        popOnCancel: true,
                          );
                        },
                      );
              }
            return const Center(child: SizedBox(
                width: 150,
                height: 150,
                child: CircularProgressIndicator(
                  backgroundColor: azul,
                  strokeWidth: 10,
                  color: rosa,
                ),
              )
            );
            }
            if(snapshot.connectionState == ConnectionState.done){
            return RefreshIndicator(
              color: rosa,
              backgroundColor: azul,
              onRefresh: atualizarPagina,
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (_, int index){
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.20
                        ),
                        child: Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Image.asset("assets/pricipal/cadeado.png")),
                        )),
                        const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text(
                           
                            "A equipe da SGM irá analisar seus dados em até um dia útil",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            
                            fontFamily: 'Poppins',
                            fontSize: 25,
                            color: azul
                            ),),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.05
                          ),
                          child: TextButton(
                            style: TextButton.styleFrom(
                            backgroundColor: amareloClaro,
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: const BorderSide(color: rosa, width: 3)
                            
                            ),
                            elevation: 6
                        
                            ),
                            onPressed: () {
                              context.read<AuthService>().logout();
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(3.0),
                              child: Text("Fazer login com outra conta", style: TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: 20,
                              color: azul
                              ),),
                            ),
                           
                          ),
                        ),
                  ],
                );
                }
              ),
            );
            }
              else{
                return const Center(child: Text("Ocorreu um erro, entre em contato com a equipe SGM"));
              }
            
            }
          ),
        ),
      ),
    );
  }

  Future <void> atualizarPagina()  async {

    setState(() {
      
    });
    return Future.delayed(const Duration(seconds: 1));
  }
}