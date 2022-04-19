class ChangeFavorites{
  bool ? status;
  String? message;
  ChangeFavorites.fromApi(Map<String , dynamic> fromApi)
  {
    status = fromApi['status'];
    message = fromApi['message'];
  }
}