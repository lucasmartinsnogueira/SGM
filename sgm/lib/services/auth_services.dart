import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthException implements Exception {
  String message;
  AuthException(this.message);
}

class AuthService extends ChangeNotifier{
  FirebaseAuth auth = FirebaseAuth.instance;
  User? usuario;
  bool isLoading = true;

  AuthService(){
    authCheck();
  }
  authCheck(){
    auth.authStateChanges().listen((User? user) {
      usuario = (user == null) ? null : user;
      isLoading = false;
      notifyListeners();
    });
  }
  registrar(String email, String senha) async{
    try{
      await auth.createUserWithEmailAndPassword(email: email, password: senha); 
      getUser();
    } on FirebaseAuthException catch(e){
      if(e.code == "weak-password"){
        throw AuthException("A senha é muito fraca.");
      }
      else if (e.code == "email-already-in-use"){
        throw AuthException("E-mail já cadastrado.");
      }
    }
  }
  getUser(){
    usuario = auth.currentUser;
    notifyListeners();
  }
   login(String email, String senha) async{
    try{
      await auth.signInWithEmailAndPassword(email: email, password: senha); 
      getUser();
    } on FirebaseAuthException catch(e){
      if(e.code == "user-not-found"){
        throw AuthException("E-mail não encontrado. Cadastre-se!");
      }
      else if (e.code == "wrong-password"){
        throw AuthException("Senha incorreta. Tente novamente!");
      }
    }
  }
  logout()async {
    await auth.signOut();
    getUser();
  }
}