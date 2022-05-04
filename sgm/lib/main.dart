// Início da aplicação com função de inicialização.

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgm/core/app.dart';
import 'package:sgm/services/auth_services.dart';

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


