import 'dart:convert';

class UserModel {
  bool? ativado;
  String? categoria;
  String? cpf;
  String? email;
  String? image;
  String? name;

  UserModel({
    this.ativado,
    this.categoria,
    this.cpf,
    this.email,
    this.image,
    this.name,
  });

  UserModel copyWith({
    bool? ativado,
    String? categoria,
    String? cpf,
    String? email,
    String? image,
    String? name,
  }) {
    return UserModel(
      ativado: ativado ?? this.ativado,
      categoria: categoria ?? this.categoria,
      cpf: cpf ?? this.cpf,
      email: email ?? this.email,
      image: image ?? this.image,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ativado': ativado,
      'categoria': categoria,
      'cpf': cpf,
      'email': email,
      'image': image,
      'name': name,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      ativado: map['ativado'] != null ? map['ativado'] as bool : null,
      categoria: map['categoria'] != null ? map['categoria'] as String : null,
      cpf: map['cpf'] != null ? map['cpf'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'UserModel(ativado: $ativado, categoria: $categoria, cpf: $cpf, email: $email, image: $image, name: $name)';

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.ativado == ativado &&
        other.categoria == categoria &&
        other.cpf == cpf &&
        other.email == email &&
        other.image == image &&
        other.name == name;
        
  }

  @override
  int get hashCode =>
      ativado.hashCode ^
      categoria.hashCode ^
      cpf.hashCode ^
      email.hashCode ^
      image.hashCode ^
      name.hashCode;
      

  bool isValid() {
    if (ativado == null) {
      throw Exception("Não foi informado o status da conta");
    }

    if (categoria == null || categoria!.isEmpty) {
      throw Exception("Categoria do usuário não foi informada");
    }

    if (cpf == null || cpf!.isEmpty) {
      throw Exception("cpf do usuário não foi informado");
    }

    if (email == null || email!.isEmpty) {
      throw Exception("e-mail do usuário não foi informado");
    }

    if (image == null || image!.isEmpty) {
      throw Exception("Usuário sem imagem");
    }

    if (name == null || name!.isEmpty) {
      throw Exception("usuário sem imagem de perfil");
    }

    return true;
  }
}
