import 'package:sgm/modules/users/stock/controllers/home_stock_Controller.dart';
import 'package:sgm/shared/help/colors.dart';
import 'package:flutter/material.dart';

class GerenciaStock extends StatefulWidget {
  const GerenciaStock({Key? key}) : super(key: key);

  @override
  State<GerenciaStock> createState() => _GerenciaStockState();
}

class _GerenciaStockState extends State<GerenciaStock> {
  final _controller = HomeStockController();
  GlobalKey<FormState>  formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea
    (child: Scaffold(
      appBar: AppBar(
        title: const Text("Gerenciar Estoque da OS", style: TextStyle(color: blue),),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded), color: blue, 
          onPressed: _controller.navigateBack(context),),
        backgroundColor: darkyellow,
      ),
      body: SingleChildScrollView(child: Column(
        children: [
          Text("Formuláriom OS"),
          Form(
            key: formKey,
            child: Column(
              children: [
                Text("Título"),
                Text("Descrição"),
                Text("Carreta"),
                Text("Cavalo"),
                Text("Imagem"),
                Text("Emitida pelo supervisor:"),
                Text("Mecânicos"),
                Text("Data"),
                Text("itens necessários"),
                Text("Mudar igm"),
                Text("mudar Colocar em espera")
              ],
            ),
          )
        ],
      ),)
    ),
    
    );
    
  }
}