class ShopLoginModel{
  bool ? status;
  String? message;
UserData? data;
ShopLoginModel({this.status, this.message, this.data});
ShopLoginModel.fromApi(Map<String, dynamic> fromapi){
  status= fromapi['status'];
  message= fromapi['message'];
  data= fromapi['data'];

}
}
class UserData{
  String?id;
  String?name;
  String?image;
  String?email;
  String?phone;
  int?points;
  int?credits;
  String?token;


 // UserData ({this.id, this.name, this.image, this.email, this.phone, this.token,this.credits,this.points});
UserData.fromApi(Map<String, dynamic> fromapi)
{
  id=fromapi['id'];
  name=fromapi['name'];
  image=fromapi['image'];
  email=fromapi['email'];
  phone=fromapi['phone'];
  points=fromapi['points'];
  credits=fromapi['credits'];
  token=fromapi['token'];

}
}