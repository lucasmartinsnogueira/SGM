
abstract class DataSourceUser {
  Future<void> incluir(Map<String, dynamic> usurio);
  
  Future<void> excluir(Map<String, dynamic> usurio);
  
  Future<void> alterar(Map<String, dynamic> usurio);
  
  Future<Map<String, dynamic>> selecionar(String docId);
  
  Future<List<Map<String, dynamic>>> selecionarTodos();
}
