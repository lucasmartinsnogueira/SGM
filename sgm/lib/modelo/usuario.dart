class Usuario{
  bool? ativado;
  String? categoria;
  String? cpf;
  String? email;
  String? nome;
  

  Usuario();

  Usuario.fromDocument(Map data){
    if(data["ativado"] != null) ativado = data["ativado"] as bool;
    if(data["categoria"] != null) categoria = data["categoria"] as String;
    if(data["cpf"] != null) cpf = data["cpf"] as String;
    if(data["email"] != null) email = data["email"] as String;
    if(data["nome"] != null) nome = data["nome"] as String;
  }

   Map<String, dynamic> toMap(){
    return {
      if(ativado != null)          "ativado"        : ativado,
      if(categoria != null)        "categoria"      : categoria,
      if(cpf != null)              "cpf"            : cpf,
      if(email != null)            "email"          : email,
      if(nome != null)             "nome"           : nome,
    };
   }
}