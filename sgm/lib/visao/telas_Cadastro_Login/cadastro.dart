

import 'package:brasil_fields/brasil_fields.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sgm/Pacote_de_Ajuda/cores.dart';
import 'package:sgm/banco_de_dados/firestore.dart';
import 'package:sgm/services/auth_services.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({ Key? key }) : super(key: key);

  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  GlobalKey<FormState>  formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;
  TextEditingController nome = TextEditingController();
  TextEditingController cpf = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController senha = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 45
      ),
      child: Form(
        key: formKey,
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
                  controller: nome,
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
                    RegExp regExp = RegExp(r"[\w-._]+");
                    Iterable matches = regExp.allMatches(value);
                    int count = matches.length;
                    if(count <= 1){
                      return "*Insira seu nome completo";
                    }
                    else if(value.length == 3){
                      return "*O texto não é um nome";
                    }
                    
                    
                    return null;
                  },
                ),
              ),
            ),
          ),
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
                  controller: cpf,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CpfInputFormatter()
                  ],
                  keyboardType: TextInputType.number,
                      cursorColor: azul,
                        decoration: const InputDecoration(   
                        fillColor: azul,
                        focusColor: azul,
                        hoverColor: azul,
                        border: InputBorder.none, 
                        icon: Icon(Icons.badge,color: azul,),                         
                        labelText: 'CPF:',
                        labelStyle: TextStyle(
                          color: azul,
                        )
                        ),
                  
                  validator: (value){
                    if(value == null || value.isEmpty) {
                      return "*Campo obrigatório";
                    }
                    else if(value.length != 14){
                      return "*CPF incompleto";
                    }
                    return null;
            
                  },
                ),
              ),
            ),
          ),
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
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                      cursorColor: azul,
                        decoration: const InputDecoration(   
                        fillColor: azul,
                        focusColor: azul,
                        hoverColor: azul,
                        border: InputBorder.none, 
                        icon: Icon(Icons.mail,color: azul,),                         
                        labelText: 'E-mail:',
                        labelStyle: TextStyle(
                          color: azul,
                        )
                        ),
                  
                  validator: (value){
                    if(value == null || value.isEmpty) {
                      return "*Campo obrigatório";
                    }
                    else if(isEmail(value) == false){
                      return "*E-mail inválido";
                    }
                    return null;
            
                  },
                ),
              ),
            ),
          ),
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
                  controller: senha,
                  obscureText: !_passwordVisible,
                  keyboardType: TextInputType.text,
                      cursorColor: azul,
                        decoration: InputDecoration(   
                        suffixIcon: IconButton(
                       icon: Icon(
                        _passwordVisible
                         ? Icons.visibility
                         : Icons.visibility_off,
                        color: azul,
                        ),
                        onPressed: (){
                          setState(() {
                             _passwordVisible = !_passwordVisible;
                          });
                        },
                        ),
                        fillColor: azul,
                        focusColor: azul,
                        hoverColor: azul,
                        border: InputBorder.none, 
                        icon: const Icon(Icons.vpn_key,color: azul,),                         
                        labelText: 'Senha:',
                        labelStyle: const TextStyle(
                          color: azul,
                        ),
                        ),
                        
                  
                  validator: (value){
                    if(value == null || value.isEmpty) {
                      return "*Campo obrigatório";
                    }
                    else if(value.length < 6){
                      return "A senha deve ter pelo menos 6 caracteres";
                    }
                    return null;
            
                  },
                ),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
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
                          if(formKey.currentState!.validate()){
                            String cpfnovo = cpf.text;
                            if(GetUtils.isCpf(cpfnovo)){
                              debugPrint("CPF válido");
                              registrar();
                            } else {
                              debugPrint("CPF inválido");
                            }
                            
                          }
                          
                        },
                        child: (loading == false)
                        ? const Text("Cadastrar", style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 20,
                        color: azul
                        ),)
                        : const CircularProgressIndicator(
                          color: azul,
                        )
                      ),
          ),
        ],)
      ),
    );
  }
  bool isEmail(String em) {
  String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = RegExp(p);
  return regExp.hasMatch(em);
}
  registrar() async{
    setState(() {
      loading = true;
    });
     try{
      await context.read<AuthService>().registrar(email.text, senha.text);
      String novoUser = AuthService().auth.currentUser!.uid.toString();
      await criacaoUser(novoUser, nome.text, cpf.text, email.text);
      Navigator.pop(context);
    } on AuthException catch(e){
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
        loading = false;
      });
     
    }
  }
}