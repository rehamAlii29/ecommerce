class ShopHomeModel{
  bool?status;
  ShopHomeDataModel? data;
  ShopHomeModel.fromApi(Map<String, dynamic> fromApi){
    status= fromApi['status'];
    data = ShopHomeDataModel.fromApifromApi(fromApi['status']); // l2nha msh kema wa7da heya object w kol element gwa el object 3bara 3n object bardo :D
  }
}
class ShopHomeDataModel{
 List<Banners>? banners;
List<Products>? products;
ShopHomeDataModel.fromApifromApi(Map<String, dynamic> fromApi){}
}
class Banners {

}
class Products{}