import 'package:equatable/equatable.dart';

class Reclamation extends Equatable {
  final String? id;
  final String user;
  final List<String> sales;
  final String reference;
  final double price;
  final String status;
  final DateTime date;


 const Reclamation({this.id,required this.date, required this.user, required this.sales, required this.reference,required this.price, required this.status});
 
  @override
  List<Object?> get props =>[id,user,sales,reference,price,date,status];
  
}
