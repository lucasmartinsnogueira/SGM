// Início da aplicação.

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgm/services/auth_services.dart';
import 'package:sgm/shared/cores.dart';
import 'package:sgm/widgets/auth_check.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => AuthService())
    ],
      child: const MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: azul,
        // Inserir tema da aplicação
      ),
      home: const AuthCheck(),
    );
  }
}
