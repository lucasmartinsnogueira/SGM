



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgm/Pacote_de_Ajuda/cores.dart';
import 'package:sgm/modelo/usuario.dart';
import 'package:sgm/services/auth_services.dart';
import 'package:sgm/visao/telas_Cadastro_Login/cadastro.dart';
import 'package:sgm/widgets/custom_alert_dialog.dart';
import 'package:sgm/widgets/image_picker.dart';

class AccountManagement extends StatefulWidget {
  const AccountManagement({ Key? key }) : super(key: key);

  @override
  _AccountManagementState createState() => _AccountManagementState();
}

class _AccountManagementState extends State<AccountManagement> {

  @override
  Widget build(BuildContext context) {
   AuthService auth = Provider.of<AuthService>(context); 

    var snapshots = FirebaseFirestore.instance.collection("Usuarios").doc(auth.usuario!.uid).snapshots();
     return 
        Scaffold(
        backgroundColor: amareloClaro,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: azul,
          leading: IconButton(onPressed: (){
             Scaffold.of(context).openDrawer();
          }, icon: const Icon(Icons.density_medium)),
          actions: <Widget>[
            IconButton(onPressed: (){}, icon: const Icon(Icons.ac_unit_rounded))
          ],
        ),
        body: SafeArea(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 95,
              child: StreamBuilder(
                stream: snapshots,
                builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {  
                 if(snapshot.hasError){
                   return Center(
                     child: Text("Error ${snapshot.error}"),
                   );
                 }
                 if (snapshot.connectionState == ConnectionState.waiting){
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                 }
                 return SingleChildScrollView(
                   child: Column(children: [
                     Stack(
                       clipBehavior: Clip.none,
                       alignment: Alignment.center,
                       children: [
                         Container(
                           width: MediaQuery.of(context).size.width,
                           height: 70,
                           color: azul, 
                         ),
                         Positioned(
                           top: 1,
                           child: Container(
                             decoration: BoxDecoration(
                               shape: BoxShape.circle,
                               border: Border.all(
                                 width: 8,
                                 color: amareloClaro
                               )
                             ),
                             child: const CircleAvatar(
                               backgroundColor: Colors.black,
                               radius: 60,
                               backgroundImage: NetworkImage(
                                 "https://wl-incrivel.cf.tsp.li/resize/728x/jpg/a01/4e2/b650fd528ea1b7610750cd479b.jpg"
                               ),
                             ),
                           ),
                         ),
                         Positioned(
                           bottom: 35,
                           child: Container(
                             decoration: const BoxDecoration(
                               shape: BoxShape.circle,
                               color: azul
                               
                             ),
                             child: IconButton(icon: const Icon(Icons.edit, color: rosa,), onPressed: () { 
                               ImagePickerClass newImagePicker = ImagePickerClass();
                               newImagePicker.showImagePicker(context);
                              },)))
                       ],
                     
                     ),
                     Padding(
                       padding: const EdgeInsets.only(
                         top: 75,
                         bottom: 8,
                         left: 8,
                         right: 8
                       ),
                       child: Container(
                         decoration: BoxDecoration(
                           borderRadius: const BorderRadius.all(Radius.circular(10)),
                           color: azul.withOpacity(0.7),
                           boxShadow: [
                             BoxShadow(
                               color: Colors.grey.withOpacity(0.6),
                               spreadRadius: 2,
                               blurRadius: 4,
                               offset: const Offset(0, 3), 
                              ),
                           ],
                         ),
                         child: Padding(
                           padding: const EdgeInsets.only(
                             top: 5,
                             bottom: 5
                           ),
                           child: ListTile(
                             leading: const Icon(Icons.vpn_key_outlined),
                             title: const Text("ID "),
                             
                             subtitle: Text(auth.usuario!.uid.toString()),
                            
                             ),
                         ),
                       ),
                     ),
                     
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Container(
                         decoration: BoxDecoration(
                           borderRadius: const BorderRadius.all(Radius.circular(10)),
                           color: azul.withOpacity(0.7),
                           boxShadow: [
                             BoxShadow(
                               color: Colors.grey.withOpacity(0.6),
                               spreadRadius: 2,
                               blurRadius: 4,
                               offset: const Offset(0, 3), 
                              ),
                           ],
                         ),
                         child: Padding(
                           padding: const EdgeInsets.only(
                             top: 5,
                             bottom: 5
                           ),
                           child: ListTile(
                             leading: const Icon(Icons.face_outlined),
                             title: const Text("Nome "),
                             subtitle: Text(snapshot.data!["nome"].toString()),
                             trailing: CircleAvatar(
                               backgroundColor: azul,
                               child: IconButton(icon: const Icon(Icons.edit, color: rosa,), onPressed: (){
                                 modalNome(context, snapshot.data!["nome"].toString(), auth.usuario!.uid);
                               },),
                             ),
                             ),
                         ),
                       ),
                     ),
                                   
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Container(
                         decoration: BoxDecoration(
                           borderRadius: const BorderRadius.all(Radius.circular(10)),
                           color: azul.withOpacity(0.7),
                           boxShadow: [
                             BoxShadow(
                               color: Colors.grey.withOpacity(0.6),
                               spreadRadius: 2,
                               blurRadius: 4,
                               offset: const Offset(0, 3), 
                              ),
                           ],
                         ),
                         child: Padding(
                           padding: const EdgeInsets.only(
                             top: 5,
                             bottom: 5
                           ),
                           child: ListTile(
                             leading: const Icon(Icons.fingerprint_outlined),
                             title: const Text("CPF "),
                             subtitle: Text(snapshot.data!["cpf"].toString()),
                             trailing: const CircleAvatar(
                               backgroundColor: azul,
                               child: Icon(Icons.radio_button_checked_outlined, color: Colors.green
                              )
                             ),
                             ),
                         ),
                       ),
                     ),
                 
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Container(
                         decoration: BoxDecoration(
                           borderRadius: const BorderRadius.all(Radius.circular(10)),
                           color: azul.withOpacity(0.7),
                           boxShadow: [
                             BoxShadow(
                               color: Colors.grey.withOpacity(0.6),
                               spreadRadius: 2,
                               blurRadius: 4,
                               offset: const Offset(0, 3), 
                              ),
                           ],
                         ),
                         child: Padding(
                           padding: const EdgeInsets.only(
                             top: 5,
                             bottom: 5
                           ),
                           child: ListTile(
                             leading: const Icon(Icons.category_outlined),
                             title: const Text("Categoria "),
                             subtitle: Text(snapshot.data!["categoria"].toString()),
                             trailing: const CircleAvatar(
                               backgroundColor: azul,
                               child: Icon(Icons.psychology_outlined, color: Colors.green
                              )
                             ),
                             ),
                         ),
                       ),
                     ),
                    
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Container(
                         decoration: BoxDecoration(
                           borderRadius: const BorderRadius.all(Radius.circular(10)),
                           color: azul.withOpacity(0.7),
                           boxShadow: [
                             BoxShadow(
                               color: Colors.grey.withOpacity(0.6),
                               spreadRadius: 2,
                               blurRadius: 4,
                               offset: const Offset(0, 3), 
                              ),
                           ],
                         ),
                         child: Padding(
                           padding: const EdgeInsets.only(
                             top: 5,
                             bottom: 5
                           ),
                           child: ListTile(
                             leading: const Icon(Icons.lock_open_outlined),
                             title: const Text("Ativação "),
                             
                             subtitle: Text(
                               (snapshot.data!["ativado"] == true)
                               ?"Ativado"
                               :"Inativo"
                               ),
                             trailing: CircleAvatar(
                               backgroundColor: azul,
                               child: Icon(Icons.radio_button_checked, color: 
                               (snapshot.data!["ativado"] == true)
                               ?Colors.green
                               :vermelho)
                             ),
                             ),
                         ),
                       ),
                     ),
                     
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Container(
                         decoration: BoxDecoration(
                           borderRadius: const BorderRadius.all(Radius.circular(10)),
                           color: azul.withOpacity(0.7),
                           boxShadow: [
                             BoxShadow(
                               color: Colors.grey.withOpacity(0.6),
                               spreadRadius: 2,
                               blurRadius: 4,
                               offset: const Offset(0, 3), // changes position of shadow
                              ),
                           ],
                         ),
                         child: Padding(
                           padding: const EdgeInsets.only(
                             top: 5,
                             bottom: 5
                           ),
                           child: ListTile(
                             leading: const Icon(Icons.mail_outline),
                             title: const Text("E-mail "),
                             
                             subtitle: Text(snapshot.data!["email"].toString()),
                             trailing: CircleAvatar(
                               backgroundColor: azul,
                               child: IconButton(icon: const Icon(Icons.edit, color: rosa,), onPressed: (){
                                 modalEmail(context, snapshot.data!["email"], auth.usuario!.uid);
                               },),
                             ),
                             ),
                         ),
                       ),
                     ),
                     
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Container(
                         decoration: BoxDecoration(
                           borderRadius: const BorderRadius.all(Radius.circular(10)),
                           color: azul.withOpacity(0.7),
                           boxShadow: [
                             BoxShadow(
                               color: Colors.grey.withOpacity(0.6),
                               spreadRadius: 2,
                               blurRadius: 4,
                               offset: const Offset(0, 3), // changes position of shadow
                              ),
                           ],
                         ),
                         child: Padding(
                           padding: const EdgeInsets.only(
                             top: 5,
                             bottom: 5
                           ),
                           child: ListTile(
                             leading: const Icon(Icons.password_outlined),
                             title: const Text("Senha "),
                             
                             subtitle: const Text("******"),
                             trailing: CircleAvatar(
                               backgroundColor: azul,
                               child: IconButton(icon: const Icon(Icons.edit, color: rosa,), onPressed: (){modalSenha(context, snapshot.data!["email"], auth.usuario!.uid);},),
                             ),
                             ),
                         ),
                       ),
                     ),
                    const SizedBox(
                      height: 15,
                    )      
                   ]),
                 );
                }
             ),
            )
        )
        );

  }

modalNome(BuildContext context, nomefirestore, uid) {
  var form = GlobalKey<FormState>();
  var nome = TextEditingController(text: nomefirestore);
  bool isloading = false;
  showDialog(context: context, builder: (BuildContext context)
  {
    return StatefulBuilder(
      builder: (context, setState) {
      return AlertDialog(
        
        title: const Text("Alterar nome"),
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      backgroundColor: amareloClaro,
      actions: [
      (isloading == true)
      ?const ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(45)),
        child: SizedBox(
          width: 100,
          height: 25,
          child: LinearProgressIndicator(backgroundColor: rosa,
          color: azul,)
        ),
      )
      :const SizedBox(),
      Container(
        decoration: BoxDecoration( 
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(
            width: 3,
            color: Colors.red
          )
        ),
        child: 
        IconButton(
          tooltip: "Cancelar",
          onPressed: (){
            Navigator.pop(context);
          }, icon: const Icon(Icons.clear, color: Colors.red,)),
      ),
      Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(
            width: 3,
            color: Colors.green
          )
        ),
        child: 
        IconButton(
          tooltip: "Salvar",
          onPressed: () async {
            if (form.currentState!.validate()){
              setState((){
                isloading = true;
              });
              try{
              await FirebaseFirestore.instance.collection("Usuarios").doc(uid).update({
                "nome": nome.text
              });
              }
              catch(e){
                 ScaffoldMessenger.of(context).showSnackBar(
               const  SnackBar(content: Text("Erro! Tente novamente mais tarde."))
              );
              debugPrint(e.toString());
              }
              Navigator.pop(context);
            }
          }, icon: const Icon(Icons.check, color: Colors.green,)),
      )
      ],
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Padding(
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
                    child: Form(
                      key: form,
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
                          else if(value == nomefirestore){
                            return"*Insira um nome diferente";
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
              ),
      ),
      );
      }
    );
  });
  
}

modalEmail(BuildContext context, emailAntigo, uid) {
  bool _passwordVisible = false;
  var form = GlobalKey<FormState>();
  var emailSignIn = TextEditingController(text: emailAntigo);
  var senhaAtual = TextEditingController();
  var alterarEmail = TextEditingController();
  bool isloading = false;
  showDialog(context: context, builder: (BuildContext context)
  {
    return StatefulBuilder(
      builder: (context, setState){
      return AlertDialog(
        
        title: const Text("Alterar e-mail"),
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      backgroundColor: amareloClaro,
      actions: [
      (isloading == true)
      ?const ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(45)),
        child: SizedBox(
          width: 100,
          height: 25,
          child: LinearProgressIndicator(backgroundColor: rosa,
          color: azul,)
        ),
      )
      :const SizedBox(),
      Container(
        decoration: BoxDecoration( 
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(
            width: 3,
            color: Colors.red
          )
        ),
        child: 
        IconButton(
          tooltip: "Cancelar",
          onPressed: (){
            Navigator.pop(context);
          }, icon: const Icon(Icons.clear, color: Colors.red,)),
      ),
      Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(
            width: 3,
            color: Colors.green
          )
        ),
        child: 
        IconButton(
          tooltip: "Salvar",
          onPressed: () async {
            
              if (form.currentState!.validate()){
              setState(() {
              isloading = true;
             });
              try{
              await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailSignIn.text, password: senhaAtual.text);
              await FirebaseAuth.instance.currentUser!.updateEmail(alterarEmail.text);
              await FirebaseFirestore.instance.collection("Usuarios").doc(uid).update({
                "email": alterarEmail.text
              });
              ScaffoldMessenger.of(context).showSnackBar(
               const  SnackBar(content: Text("E-mail Atualizado."))
              );
              
            }
            catch(e){
              ScaffoldMessenger.of(context).showSnackBar(
               const  SnackBar(content: Text("Erro! Verifique os dados inseridos."))
              );
              debugPrint(e.toString());
            }
           
            Navigator.pop(context);
            }
          }, icon: const Icon(Icons.check, color: Colors.green,)),
      )
      ],
      content: SizedBox(
       height: 400,
        child: Form(
          key: form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             const Padding(
               padding: EdgeInsets.only(left: 15, bottom: 2),
               child: Text("Insira os dados de login:",),
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
                            controller: emailSignIn,
                            keyboardType: TextInputType.emailAddress,
                                cursorColor: azul,
                                  decoration: const InputDecoration(   
                                  fillColor: azul,
                                  focusColor: azul,
                                  hoverColor: azul,
                                  border: InputBorder.none, 
                                  icon: Icon(Icons.mail,color: azul,),                         
                                  labelText: 'E-mail atual:',
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
                              else if(value == alterarEmail.text){
                                return"*E-mails devem ser diferentes";
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
                              controller: senhaAtual,
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
                                  return "*Menos de 6 caracteres";
                                }
                                return null;
                                        
                              },
                            ),
                          ),
                          
                          
                          
                        ),
                      ),
                      const Padding(
               padding: EdgeInsets.only(left: 15, bottom: 2, top: 4),
               child: Text("Insira o novo e-mail:",),
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
                            controller: alterarEmail,
                            keyboardType: TextInputType.emailAddress,
                                cursorColor: azul,
                                  decoration: const InputDecoration(   
                                  fillColor: azul,
                                  focusColor: azul,
                                  hoverColor: azul,
                                  border: InputBorder.none, 
                                  icon: Icon(Icons.mail,color: azul,),                         
                                  labelText: 'Novo e-mail:',
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
                              else if(emailSignIn.text == value){
                                return"*E-mails devem ser diferentes";
                              }
                              return null;
                                    
                            },
                            ),
                          ),
                          
                          
                          
                        ),
                      ),
          
            ]
        
          ),
        ),
      ),
      );
      }
    );
  });
}


modalSenha(BuildContext context, emailAntigo, uid) {
  bool _passwordVisible = false;
  var form = GlobalKey<FormState>();
  var emailSignIn = TextEditingController(text: emailAntigo);
  var senhaAtual = TextEditingController();
  var alterarSenha = TextEditingController();
  bool isloading = false;
  showDialog(context: context, builder: (BuildContext context)
  {
    return StatefulBuilder(
      builder: (context, setState){
      return AlertDialog(
        
        title: const Text("Alterar senha"),
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      backgroundColor: amareloClaro,
      actions: [
      (isloading == true)
      ?const ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(45)),
        child: SizedBox(
          width: 100,
          height: 25,
          child: LinearProgressIndicator(backgroundColor: rosa,
          color: azul,)
        ),
      )
      :const SizedBox(),
      Container(
        decoration: BoxDecoration( 
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(
            width: 3,
            color: Colors.red
          )
        ),
        child: 
        IconButton(
          tooltip: "Cancelar",
          onPressed: (){
            Navigator.pop(context);
          }, icon: const Icon(Icons.clear, color: Colors.red,)),
      ),
      Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(
            width: 3,
            color: Colors.green
          )
        ),
        child: 
        IconButton(
          tooltip: "Salvar",
          onPressed: () async {
            
              if (form.currentState!.validate()){
              setState(() {
              isloading = true;
             });
              try{
              await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailSignIn.text, password: senhaAtual.text);
              await FirebaseAuth.instance.currentUser!.updatePassword(alterarSenha.text);
              ScaffoldMessenger.of(context).showSnackBar(
               const  SnackBar(content: Text("Senha Atualizada."))
              );
              
            }
            catch(e){
              ScaffoldMessenger.of(context).showSnackBar(
               const  SnackBar(content: Text("Erro! Verifique os dados inseridos."))
              );
              debugPrint(e.toString());
            }
           
            Navigator.pop(context);
            }
          }, icon: const Icon(Icons.check, color: Colors.green,)),
      )
      ],
      content: SizedBox(
       height: 400,
        child: Form(
          key: form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             const Padding(
               padding: EdgeInsets.only(left: 15, bottom: 2),
               child: Text("Insira os dados de login:",),
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
                            controller: emailSignIn,
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
                              controller: senhaAtual,
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
                                    labelText: 'Senha atual:',
                                    labelStyle: const TextStyle(
                                      color: azul,
                                    ),
                                    ),
                                    
                              
                              validator: (value){
                                if(value == null || value.isEmpty) {
                                  return "*Campo obrigatório";
                                }
                                else if(value.length < 6){
                                  return "*Menos de 6 caracteres";
                                }
                                else if(value == alterarSenha.text){
                                  return "*As senhas devem ser diferentes";
                                }
                                return null;
                                        
                              },
                            ),
                          ),
                          
                          
                          
                        ),
                      ),
                      const Padding(
               padding: EdgeInsets.only(left: 15, bottom: 2, top: 4),
               child: Text("Insira a nova senha:",),
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
                              controller: alterarSenha,
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
                                    labelText: 'Nova senha:',
                                    labelStyle: const TextStyle(
                                      color: azul,
                                    ),
                                    ),
                                    
                              
                              validator: (value){
                                if(value == null || value.isEmpty) {
                                  return "*Campo obrigatório";
                                }
                                else if(value.length < 6){
                                  return "*Menos de 6 caracteres";
                                }
                                else if(value == senhaAtual.text){
                                  return "*As senhas devem ser diferentes";
                                }
                                return null;
                                        
                              },
                            ),
                          ),
                          
                          
                          
                        ),
                      ),
          
            ]
        
          ),
        ),
      ),
      );
      }
    );
  });

}



  bool isEmail(String em) {
  String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = RegExp(p);
  return regExp.hasMatch(em);
   }
}


 
