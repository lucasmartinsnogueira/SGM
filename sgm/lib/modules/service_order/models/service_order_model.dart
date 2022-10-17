import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceOrderModel {
  int? carreta;
  int? cavalo;
  Timestamp? data;
  String? descricao;
  String? docEstoquista;
  String? docSupervisor;
  bool? esperaEst;
  bool? estoquista;
  bool? feita;
  bool? igm;
  String? imagem;
  String? itens;
  Map<String, dynamic>? mecanicos;
  String? titulo;
  String? id;
  bool? status;
  int? tempoEspec;

  ServiceOrderModel({
    this.carreta,
    this.cavalo,
    this.data,
    this.descricao,
    this.docEstoquista,
    this.docSupervisor,
    this.esperaEst,
    this.estoquista,
    this.feita,
    this.igm,
    this.imagem,
    this.itens,
    this.mecanicos,
    this.titulo,
    this.id,
    this.status,
    this.tempoEspec
  });

  ServiceOrderModel copyWith(
      {int? carreta,
      int? cavalo,
      Timestamp? data,
      String? descricao,
      String? docEstoquista,
      String? docSupervisor,
      bool? esperaEst,
      bool? estoquista,
      bool? feita,
      bool? igm,
      String? imagem,
      String? itens,
      Map<String, dynamic>? mecanicos,
      String? titulo,
      String? id,
      bool? status,
      int? tempoEspec}) {
    return ServiceOrderModel(
        carreta: carreta ?? this.carreta,
        cavalo: cavalo ?? this.cavalo,
        data: data ?? this.data,
        descricao: descricao ?? this.descricao,
        docEstoquista: docEstoquista ?? this.docEstoquista,
        docSupervisor: docSupervisor ?? this.docSupervisor,
        esperaEst: esperaEst ?? this.esperaEst,
        estoquista: estoquista ?? this.estoquista,
        feita: feita ?? this.feita,
        igm: igm ?? this.igm,
        imagem: imagem ?? this.imagem,
        itens: itens ?? this.itens,
        mecanicos: mecanicos ?? this.mecanicos,
        titulo: titulo ?? this.titulo,
        id: id ?? this.id,
        status: status ?? this.status,
        tempoEspec: tempoEspec ?? this.tempoEspec
        );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'carreta': carreta,
      'cavalo': cavalo,
      'data': data,
      'descricao': descricao,
      'docEstoquista': docEstoquista,
      'docSupervisor': docSupervisor,
      'esperaEst': esperaEst,
      'estoquista': estoquista,
      'feita': feita,
      'igm': igm,
      'imagem': imagem,
      'itens': itens,
      'mecanicos': mecanicos,
      'titulo': titulo,
      'id': id,
      'status': status,
      'tempoEspec': tempoEspec
    };
  }

  factory ServiceOrderModel.fromMap(Map<String, dynamic> map) {
    return ServiceOrderModel(
      carreta: map['carreta'] != null ? map['carreta'] as int : null,
      cavalo: map['cavalo'] != null ? map['cavalo'] as int : null,
      data: map['data'] != null ? map['data'] as Timestamp : null,
      descricao: map['descricao'] != null ? map['descricao'] as String : null,
      docEstoquista:
          map['docEstoquista'] != null ? map['docEstoquista'] as String : null,
      docSupervisor:
          map['docSupervisor'] != null ? map['docSupervisor'] as String : null,
      esperaEst: map['esperaEst'] != null ? map['esperaEst'] as bool : null,
      estoquista: map['estoquista'] != null ? map['estoquista'] as bool : null,
      feita: map['feita'] != null ? map['feita'] as bool : null,
      igm: map['igm'] != null ? map['igm'] as bool : null,
      imagem: map['imagem'] != null ? map['imagem'] as String : null,
      itens: map['itens'] != null ? map['itens'] as String : null,
      mecanicos: map['mecanicos'] != null
          ? map['mecanicos'] as Map<String, dynamic>
          : null,
      titulo: map['titulo'] != null ? map['titulo'] as String : null,
      id: map['id'] != null ? map['id'] as String : null,
      status: map['status'] != null ? map['status'] as bool : null,
       tempoEspec: map['tempoEspec'] != null ? map['tempoEspec'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceOrderModel.fromJson(String source) =>
      ServiceOrderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'UsuarioModel(carreta: $carreta, cavalo: $cavalo, data: $data, descricao: $descricao, docEstoquista: $docEstoquista, docSupervisor: $docSupervisor, esperaEst: $esperaEst, estoquista: $estoquista, feita: $feita, igm: $igm, imagem: $imagem, itens: $itens, mecanicos: $mecanicos, titulo: $titulo, status: $status, tempoEspec: $tempoEspec )';

  @override
  bool operator ==(covariant ServiceOrderModel other) {
    if (identical(this, other)) return true;

    return other.carreta == carreta &&
        other.cavalo == cavalo &&
        other.data == data &&
        other.descricao == descricao &&
        other.docEstoquista == docEstoquista &&
        other.docSupervisor == docSupervisor &&
        other.esperaEst == esperaEst &&
        other.estoquista == estoquista &&
        other.feita == feita &&
        other.igm == igm &&
        other.imagem == imagem &&
        other.itens == itens &&
        other.mecanicos == mecanicos &&
        other.titulo == titulo &&
        other.status == status &&
        other.tempoEspec == tempoEspec;
  }

  @override
  int get hashCode =>
      carreta.hashCode ^
      cavalo.hashCode ^
      data.hashCode ^
      descricao.hashCode ^
      docEstoquista.hashCode ^
      docSupervisor.hashCode ^
      esperaEst.hashCode ^
      estoquista.hashCode ^
      feita.hashCode ^
      igm.hashCode ^
      imagem.hashCode ^
      itens.hashCode ^
      mecanicos.hashCode ^
      titulo.hashCode ^
      status.hashCode ^
      tempoEspec.hashCode;

  bool isValid() {
    if (carreta == null) {
      throw Exception("Carreta não informado");
    }

    if (cavalo == null) {
      throw Exception("Cavalo não informada");
    }

    if (data == null) {
      throw Exception("Data não informado");
    }

    if (descricao == null || descricao!.isEmpty) {
      throw Exception("Descrião não informado");
    }

    if (docEstoquista == null || docEstoquista!.isEmpty) {
      throw Exception("DocEstoquista não informado");
    }

    if (docSupervisor == null || docSupervisor!.isEmpty) {
      throw Exception("docSupervisor não informado");
    }

    if (esperaEst == null) {
      throw Exception("Espera do estoque não informado");
    }
    if (estoquista == null) {
      throw Exception("Estoquista não informado");
    }
    if (feita == null) {
      throw Exception("Status não informado");
    }

    if (igm == null) {
      throw Exception("OS não inserida no banco externo");
    }

    if (imagem == null || imagem!.isEmpty) {
      throw Exception("OS sem imagem");
    }

    if (itens == null || itens!.isEmpty) {
      throw Exception("OS sem itens");
    }

    if (mecanicos == null) {
      throw Exception("OS sem aribuição de mecânicos");
    }

    if (titulo == null || titulo!.isEmpty) {
      throw Exception("OS sem sem título");
    }

    return true;
  }
}
