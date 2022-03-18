

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgm/Pacote_de_Ajuda/cores.dart';
import 'package:sgm/modelo/usuario.dart';
import 'package:sgm/services/auth_services.dart';
import 'package:sgm/widgets/custom_alert_dialog.dart';

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
     return SafeArea(
      child: CustomScrollView(
       slivers: <Widget>[
        SliverAppBar(
          shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25))),
          backgroundColor: azul,
          shadowColor: Colors.black,
          leading: IconButton(onPressed: (){
            Scaffold.of(context).openDrawer();
          }, icon: const Icon(Icons.density_medium)),
          actions: <Widget>[
            IconButton(onPressed: (){}, icon: const Icon(Icons.ac_unit_rounded))
          ],
          pinned: true,
          floating: true,
          expandedHeight: 120.0,
          flexibleSpace: const Center(
            child: FlexibleSpaceBar(
              title: Text('Supervisor'),
            ),
          ),
        ),
        SliverToBoxAdapter(
             child: SingleChildScrollView(
               child: SizedBox(
                 width: MediaQuery.of(context).size.width,
                 height: MediaQuery.of(context).size.height - 220,
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
                    return Column(children: [
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
                              title: const Text("Ativado "),
                              
                              subtitle: Text(snapshot.data!["ativado"].toString()),
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
                                child: IconButton(icon: const Icon(Icons.edit, color: rosa,), onPressed: (){},),
                              ),
                              ),
                          ),
                        ),
                      ),
                        
             
                    ]);
                   }
                ),
               ),
             )
        )
      ],

      ),
    );
  }

modalNome(BuildContext context, nomefirestore, uid) {
  var form = GlobalKey<FormState>();
  var nome = TextEditingController(text: nomefirestore);
  showDialog(context: context, builder: (BuildContext context)
  {
    return AlertDialog(
      
      title: const Text("Alterar nome"),
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    backgroundColor: amareloClaro,
    actions: [
    
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
            
            await FirebaseFirestore.instance.collection("Usuarios").doc(uid).update({
              "nome": nome.text
            });
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
  });
  
}
}
