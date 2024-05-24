import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Service extends Equatable{
  final String? id;
  final String userId;
  String service;
  String description;
 final double? courtesy;
  final double? quality;
  final double? cost;
  final double? ponctuality;
  final double? rate;
  int experience;
  List<String> images;

  Service({required this.service,required this.description,required this.experience,required this.images, this.id, required this.userId,  this.courtesy,  this.quality,  this.cost,  this.ponctuality,  this.rate});
  
  @override
  List<Object?> get props => [id,userId,service,description,courtesy,quality,cost,ponctuality,rate,experience,images];

}