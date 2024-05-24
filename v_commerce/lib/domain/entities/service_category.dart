import 'package:equatable/equatable.dart';

class ServiceCategory extends Equatable{
  final String id;
  final String title;
  final String image;

 const ServiceCategory({required this.title, required this.image,required this.id});
  @override
  List<Object?> get props =>[title,image,id];
}