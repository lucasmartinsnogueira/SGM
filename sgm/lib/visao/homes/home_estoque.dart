import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgm/services/auth_services.dart';

class HomeEstoque extends StatefulWidget {
  const HomeEstoque({ Key? key }) : super(key: key);

  @override
  _HomeEstoqueState createState() => _HomeEstoqueState();
}

class _HomeEstoqueState extends State<HomeEstoque> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: Center(child: GestureDetector(
          onTap: (){
            context.read<AuthService>().logout();
          },
          child: const Text("Estoque"))),
      ),
    );
  }
}