import 'package:sgm/modules/users/general_user/models/user_model.dart';

class UserRepository{
  Future<void> incluir(UserModel usuario)async{

  }
  Future<void> excluir(UserModel usuario) async{

  }
  Future<void> alterar(UserModel usuario) async{

  }
  Future<UserModel> selecionar(String email) async{
    return UserModel();

  }
  Future<List<UserModel>> selecionarTodos() async{
    return <UserModel>[];

  }
}