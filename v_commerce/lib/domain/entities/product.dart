import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Product extends Equatable{
  final String? id;
  final String name;
  final String reference;
  final String description;
  final double price;
  final String image;
  final String materials;
  final bool promotion;
  final int sales;
  final double rate;
  final LocalProvider provider;
  final LocalDimensions dimensions;
  final LocalCategory category;
  final LocalSubCategory subCategory;

  const Product({required this.id, required this.name, required this.reference, required this.description, required this.price,
   required this.image, required this.materials, required this.promotion, required this.sales, required this.rate, required this.provider,
   required this.dimensions, required this.category,required this.subCategory});

  @override
  List<Object?> get props => [id, name, reference,description,price,image,materials,promotion,sales,rate,provider,dimensions,category,subCategory];
}

class LocalProvider extends Equatable{
  final String id;
  final String name;

 const LocalProvider({required this.id,required this.name});
 
  @override
  List<Object?> get props => [id,name];
}

class LocalDimensions extends Equatable{
  final double? height;
  final double? width;
  final double? thickness;

 const LocalDimensions({ this.height, this.width,this.thickness});
 
  @override
  List<Object?> get props => [height,width,thickness];
}

class LocalCategory extends Equatable{
  final String id;
  final String title;
 const LocalCategory({required this.id,required this.title});
 
  @override
  List<Object?> get props => [id,title];
}

class LocalSubCategory extends Equatable{
  final String id;
  final String title;
 const LocalSubCategory({required this.id,required this.title});
 
  @override
  List<Object?> get props => [id,title];
}
