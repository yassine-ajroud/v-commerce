import 'package:v_commerce/domain/entities/reclamation.dart';

class ReclamationModel extends Reclamation{
  const ReclamationModel({super.id,required super.date, required super.user, required super.sales, required super.reference, required super.price, required super.status});

  factory ReclamationModel.fromJson(Map<String,dynamic> json)=>ReclamationModel(
   id:json['_id'], 
   date: DateTime.parse(json['createdAt']),
   user: json['user'],
   sales: json['sales'],
   reference: json['reference'],
   price: double.parse(json['price'].toString()),
   status: json['status']);


  Map<String , dynamic> toJson()=>{
    'user':user,
    'sales':sales,
    'reference':reference,
    'price':price,
    'status':status
  }; 
}