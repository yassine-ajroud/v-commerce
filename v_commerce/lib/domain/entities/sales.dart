import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Sales extends Equatable{
  final String? id;
  final String productId;
  final String providerId;
  final String userId;
   int quantity;
  final List<SaleStatus> status;
   double totalPrice;

   Sales({ this.id,required this.productId,required this.providerId,required this.userId,required this.quantity,required this.status,required this.totalPrice});
  
  @override
  List<Object?> get props => [id,productId,providerId,userId,quantity,status,totalPrice];


}

class SaleStatus extends Equatable{
  final String index;
  final DateTime? date;
  final int status;

  const SaleStatus({required this.index, required this.date, required this.status});
  @override
  List<Object?> get props => [index,status,date];
  
}