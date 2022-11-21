import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sgm/database/firebase/firestore.dart';
import 'package:sgm/services/auth_services.dart';
import 'package:sgm/shared/help/colors.dart';
import 'package:sgm/shared/widgets/choice_chip_data.dart';
import 'package:sgm/shared/widgets/choice_chips.dart';
import 'package:sgm/shared/widgets/custom_alert_dialog.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({ Key? key }) : super(key: key);

  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  GlobalKey<FormState>  formKey = GlobalKey<FormState>();
  TextEditingController nome = TextEditingController();
  TextEditingController cpf = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController senha = TextEditingController();
  bool _passwordVisible = false;
  bool loading = false;
  int index = 3;
  final double spacing = 12;
  List<ChoiceChipData> choiceChips = ChoiceChips.all;
  String ? categoria;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 45,
                left: 12,
                bottom: 6
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: const Text("Qual sua categoria:", textAlign: TextAlign.start, style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 20,
                            color: blue,
                            fontWeight: FontWeight.bold
                            ),),),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 4
              ),
              child: buildChoiceChips(),
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
                    controller: nome,
                    textCapitalization: TextCapitalization.words,
                    keyboardType: TextInputType.name,
                        cursorColor: blue,
                          decoration: const InputDecoration(   
                          fillColor: blue,
                          focusColor: blue,
                          hoverColor: blue,
                          border: InputBorder.none, 
                          icon: Icon(Icons.person,color: blue,),                         
                          labelText: 'Nome Completo:',
                          labelStyle: TextStyle(
                            color: blue,
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
                    controller: cpf,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CpfInputFormatter()
                    ],
                    keyboardType: TextInputType.number,
                        cursorColor: blue,
                          decoration: const InputDecoration(   
                          fillColor: blue,
                          focusColor: blue,
                          hoverColor: blue,
                          border: InputBorder.none, 
                          icon: Icon(Icons.badge,color: blue,),                         
                          labelText: 'CPF:',
                          labelStyle: TextStyle(
                            color: blue,
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
              padding: const EdgeInsets.only(
                top: 8,
                left: 8,
                right: 8
              ),
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
                        return "A senha deve ter pelo menos 6 caracteres";
                      }
                      return null;
              
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 10
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
                            onPressed: () {
                              String cpfnovo = cpf.text;
                              if(formKey.currentState!.validate()){
                                if(categoria == null){
                               showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const CustomAlertDialog(
                                      title: "Campo não preenchido",
                                      message: "É obrigatório possuir uma categoria para se cadastrar no app",
                                      popOnCancel: true,
                                    );
                                  },
                                );
                              }
                                 else if(GetUtils.isCpf(cpfnovo)){
                                  debugPrint("CPF válido");
                                  registrar();
                                } else {
                                  debugPrint("CPF inválido");
                                   showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const CustomAlertDialog(
                                      title: "CPF inválido",
                                      message: "O CPF inserido é inválido. Confira e insira novamente",
                                      popOnCancel: true,
                                    );
                                  },
                                );
                              }
                                }
                                
                              
                              
                              
                            },
                            child: (loading == false)
                            ? const Text("Cadastrar", style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 20,
                            color: blue
                            ),)
                            : const CircularProgressIndicator(
                              color: blue,
                            )
                          ),
              ),
            ),
          ],),
        )
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
      await criacaoUser(novoUser, categoria!, nome.text, cpf.text, email.text);
      Navigator.pop(context);
    } on AuthException catch(e){
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
        loading = false;
      });
     
    }
  }
  Widget buildChoiceChips() => Wrap(
        runSpacing: spacing,
        spacing: spacing,
        children: choiceChips
            .map((choiceChip) => ChoiceChip(
              avatar: choiceChip.circleAvatar,
              elevation: 3,
              
                  label: Text(choiceChip.label!),
                  labelStyle: const TextStyle(
                      fontWeight: FontWeight.bold, color: Color(0XFFF2F2F2)),
                      
                  onSelected: (isSelected) => setState(() {
                    (categoria != choiceChip.categoria)
                    ?categoria = choiceChip.categoria
                    :categoria = null;
                    choiceChips = choiceChips.map((otherChip) {
                      final newChip = otherChip.copy(isSelected: false);

                      return choiceChip == newChip
                          ? newChip.copy(isSelected: isSelected)
                          : newChip;
                    }).toList();
                  }),
                  selected: choiceChip.isSelected!,
                  selectedColor: blue,
                  backgroundColor: pink.withOpacity(0.7),
                ))
            .toList(),
      );
}