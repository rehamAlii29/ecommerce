class ShopHomeModel{
  bool?status;
  ShopHomeDataModel? data;
  ShopHomeModel.fromApi(Map<String, dynamic> fromApi){
    status= fromApi['status'];
    data = ShopHomeDataModel.fromApifromApi(fromApi['status']); // l2nha msh kema wa7da heya object w kol element gwa el object 3bara 3n object bardo :D
  }
}
class ShopHomeDataModel{
 List<Banners>? banners=[];
List<Products>? products=[];
ShopHomeDataModel.fromApifromApi(Map<String, dynamic> fromApi){
  for(var element in fromApi['banners']){
    banners!.add(element);
  }
  for(var element in fromApi['products']){
    products!.add(element);
  }

}
}
class Banners {
int? id;
String?image;
Banners.fromApi(Map<String, dynamic> fromApi){
  id= fromApi['id'];
  image= fromApi['image'];

}
}
class Products{
  int?id;
  dynamic price;
  dynamic old_price;
  dynamic discount;
  String?image;
String?name;
bool?in_favorites;
bool?in_cart;
Products.fromApi(Map<String, dynamic> fromApi){
  id = fromApi['id'];
  price = fromApi['price'];
  old_price = fromApi['old_price'];
  discount = fromApi['discount'];
  image = fromApi['image'];
  in_favorites = fromApi['in_favorites'];
  in_cart = fromApi['in_cart'];

}
}