import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgm/modules/login_signup/inicio.dart';
import 'package:sgm/modules/users/general_user/pages/home_page.dart';
import 'package:sgm/services/auth_services.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({ Key? key }) : super(key: key);

  @override
  _AuthCheckState createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context); 

    if (auth.isLoading) {
      return loading();
    }
    else if(auth.usuario == null) {
    return const Inicio();
    }
    else {
    return const HomePage();
    }
  }
  loading(){
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}