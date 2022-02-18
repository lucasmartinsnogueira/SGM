// Início da aplicação.

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sgm/visao/telasInicio_Login/inicio.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Inserir tema da aplicação
      ),
      home: const Inicio(),
    );
  }
}
