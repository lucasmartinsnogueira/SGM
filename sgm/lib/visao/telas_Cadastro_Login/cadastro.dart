import 'package:flutter/material.dart';
import 'package:sgm/Pacote_de_Ajuda/cores.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({ Key? key }) : super(key: key);

  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final GlobalKey<FormState>  _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 45
      ),
      child: Form(
        key: _formKey,
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: rosa.withOpacity(0.6),
                border: Border.all(
                  width: 2,
                  color: azul
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(20)
                )
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  bottom: 2
                ),
                child: TextFormField(
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.name,
                      cursorColor: azul,
                        decoration: const InputDecoration(   
                        fillColor: azul,
                        focusColor: azul,
                        hoverColor: azul,
                        border: InputBorder.none, 
                        icon: Icon(Icons.person,color: azul,),                         
                        labelText: 'Nome Completo:',
                        labelStyle: TextStyle(
                          color: azul,
                        )
                        ),
                  
                  validator: (value){
                    if(value == null || value.isEmpty) {
                      return "*Campo obrigatório";
                    }
                    return null;
            
                  },
                ),
              ),
            ),
          ),
          SizedBox(
            width: 400,
            height: 50,
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
                          if(_formKey.currentState!.validate()){

                          }
                        },
                        child: const Text("Cadastrar", style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 20,
                        color: azul
                        ),),
                       
                      ),
          ),
        ],)
      ),
    );
  }
}