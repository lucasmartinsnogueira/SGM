class ServiceOrder {
  String? title;
  List<Map<String, dynamic>> mechanicals = [];
  int? cavalo;
  int? carreta;
  String? description;
  bool? done;
  bool? stock;
  bool? igm;
  DateTime? data;

  ServiceOrder(
      String title,
      List<Map<String, dynamic>> mechanicals,
      int cavalo,
      int carreta,
      String description,
      bool done,
      bool stock,
      bool igm,
      DateTime data);
}