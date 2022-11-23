// Responsável pelo página de login
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgm/services/auth_services.dart';
import 'package:sgm/shared/help/colors.dart';

class Login extends StatefulWidget {
  const Login({ Key? key }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState>  formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;
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
                color: pink.withOpacity(0.6),
                border: Border.all(
                  width: 2,
                  color: blue
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
                      cursorColor: blue,
                        decoration: const InputDecoration(   
                        fillColor: blue,
                        focusColor: blue,
                        hoverColor: blue,
                        border: InputBorder.none, 
                        icon: Icon(Icons.mail,color: blue,),                         
                        labelText: 'E-mail:',
                        labelStyle: TextStyle(
                          color: blue,
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
                color: pink.withOpacity(0.6),
                border: Border.all(
                  width: 2,
                  color: blue
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
                      cursorColor: blue,
                        decoration: InputDecoration(   
                        suffixIcon: IconButton(
                       icon: Icon(
                        _passwordVisible
                         ? Icons.visibility
                         : Icons.visibility_off,
                        color: blue,
                        ),
                        onPressed: (){
                          setState(() {
                             _passwordVisible = !_passwordVisible;
                          });
                        },
                        ),
                        fillColor: blue,
                        focusColor: blue,
                        hoverColor: blue,
                        border: InputBorder.none, 
                        icon: const Icon(Icons.vpn_key,color: blue,),                         
                        labelText: 'Senha:',
                        labelStyle: const TextStyle(
                          color: blue,
                        ),
                        ),
                        
                  
                  validator: (value){
                    if(value == null || value.isEmpty) {
                      return "*Campo obrigatório";
                    }
                    else if(value.length < 6){
                      return "*A senha deve ter pelo menos 6  caracteres";
                    }
                    return null;
            
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.02
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
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
                          onPressed: (){
                             if(formKey.currentState!.validate()){
                               setState(() {
                                 
                               });
                               login();
                             }
                          },
                          child: 
                          (loading == false)
                          ? const Text("Entrar", style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 20,
                          color: blue
                          ),
                          )
                          : const CircularProgressIndicator(
                            color: blue,
                          )

              
                        ),
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
  login() async{
    setState(() {
      loading = true;
    });
    try{
      
      await context.read<AuthService>().login(email.text, senha.text);
      Navigator.pop(context);
      
      
    } on AuthException catch(e){
     
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
        loading = false;
      });
    
    }
  }
}

