class SearchModel{
  bool? status;
  String?message;
Data? date;
  SearchModel.fromjson(Map<String, dynamic> json)
  {
    status = json['status'];
    message =json['message'];
    date= Data.fromjson(json['data']);
  }
}
class Data{
  int? current_page;
  List<Product> products=[];
  Data.fromjson (Map<String, dynamic> fromjson)
  {
    current_page = fromjson['current_page'];
    for(var element in fromjson['data'])
      {
        products.add(Product.fromJson(element));
      }

  }

}
class Product {
  int? id;
  dynamic price;
 dynamic oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;



  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }}