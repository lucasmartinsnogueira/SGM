import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sgm/shared/help/colors.dart';
import 'package:sgm/shared/widgets/auth_check.dart';

class MyApp extends StatelessWidget {
  
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: lightyellow,
      statusBarIconBrightness: Brightness.dark
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: pink
        // Inserir tema da aplicação
      ),
      home: const AuthCheck(),
    );
  }
}