abstract class DataSourceServiceOrder {
  Future<void> incluir(Map<String, dynamic> os);
  
  Future<void> excluir(Map<String, dynamic> os);
  
  Future<void> alterar(Map<String, dynamic> os);
  
  Future<Map<String, dynamic>> selecionar(String id);
  
  Future<List<Map<String, dynamic>>> selecionarTodos();
}
