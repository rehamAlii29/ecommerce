class CategoriesModel{
  bool ? status;
CategoriesDataModel? data;
  CategoriesModel.fromApi(Map<String , dynamic> fromApi ){
    status = fromApi['status'];
    data = CategoriesDataModel.fromApi(fromApi['data']);
  }
}
class CategoriesDataModel{
int?current_page;
List<DataOfDataModel> data =[];
CategoriesDataModel.fromApi(Map<String,dynamic> fromApi)
{
  current_page = fromApi['current_page'];
  for(var element in fromApi['data']){
    data.add(DataOfDataModel.fromApi(element));
  }
}
}
class DataOfDataModel{
  int ? id;
  String ? name;
  String?image;
  DataOfDataModel.fromApi(Map <String , dynamic> fromApi){
    id = fromApi['id'];
    name = fromApi['name'];
    image = fromApi['image'];

  }
}