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
    /*FirebaseFirestore.instance.collection("Usuarios").get().then((value){
        for (var element in value.docs) {
          debugPrint(element.data().toString());
        }
    }
    );*/ // teste
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
                                child: IconButton(icon: const Icon(Icons.edit, color: rosa,), onPressed: (){},),
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

}