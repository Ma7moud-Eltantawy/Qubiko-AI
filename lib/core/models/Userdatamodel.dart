import 'package:quickai/core/entities/UserData.dart';

class Userdatamodel extends UserData{
  Userdatamodel( {
    required super.email,
    required super.userid,
    required super.name,
    required super.phone,
    required super.pic,
    required super.verified, required super.Premiun, required super.premuimtodate, required super.Premuimplan, required super.DateofBirth});
  factory Userdatamodel.fromjson(Map<String,dynamic> json)
  {
    return Userdatamodel(
        userid: json['id'].toString(),
        name: json['name'].toString(),
        phone: json['phone'].toString(),
        pic: json['pic'].toString(),
        verified: json['ver'],
      Premiun: json['prem'],
      premuimtodate: json['premtodate'].toString(),
      Premuimplan: json['premplan'].toString(),
      DateofBirth: json['dateofbirth'],
      email: json['email'],

    );

  }

  Map<String,dynamic> tojson(){
    return{
      "id":userid,
      "name":name,
      "phone":phone,
      "pic":pic,
      "ver":verified,
      "prem":Premiun,
      "premtodate":premuimtodate,
      "premplan":Premuimplan,
      "dateofbirth":DateofBirth,
      "email":email,


    };

  }

}