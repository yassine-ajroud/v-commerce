
import '../../domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel(
      {
      required super.category,  
      required super.id,  
      required super.name,
      required super.description,
      required super.price,
      required super.subCategory,
      required super.image,
      required super.dimensions,
      required super.provider,
      required super.reference, required super.materials, required super.promotion, required super.sales, required super.rate
});

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(id: json['_id'],category:LocalCategoryModel.fromJson( json['category']),reference: json['reference'],
      name: json['name'], description: json['description'], price: double.parse(json['price'].toString()) ,subCategory:LocalSubCategoryModel.fromJson( json['subCategory']),
      image: json['image'],promotion:json['promotion'],sales: json['sales'],rate: json['rate'],
      provider:LocalProviderModel.fromJson(json['provider']),dimensions:LocalDimensionsModel.fromJson(json['dimensions']), materials: json['materials'] );

  Map<String, dynamic> toJson() => {
        '_id':id,
        'reference':reference,
        'category':category,
        'subCategory':subCategory,
        'dimensions':dimensions,
        'provider':provider,
        'materials':materials,
        'sales':sales,
        'promotion':promotion,
        'name': name,
        'description': description,
        'price': price,
        'image':image,
      };
}

class LocalCategoryModel extends LocalCategory{
  const LocalCategoryModel({required super.id, required super.title});
  factory LocalCategoryModel.fromJson(Map<String,dynamic> json)=>LocalCategoryModel(id: json['id'], title: json['title']);
}

class LocalSubCategoryModel extends LocalSubCategory{
  const LocalSubCategoryModel({required super.id, required super.title});
  factory LocalSubCategoryModel.fromJson(Map<String,dynamic> json)=>LocalSubCategoryModel(id: json['id'], title: json['title']);
}

class LocalDimensionsModel extends LocalDimensions{
  const LocalDimensionsModel({super.height,super.width,super.thickness});
  factory LocalDimensionsModel.fromJson(Map<String,dynamic> json)=>LocalDimensionsModel(height: json['height'],width: json['width'],thickness: json['thickness']);
}

class LocalProviderModel extends LocalProvider{
  const LocalProviderModel({required super.id, required super.name});
  factory LocalProviderModel.fromJson(Map<String,dynamic> json)=>LocalProviderModel(id: json['id'],name: json['name']);

}