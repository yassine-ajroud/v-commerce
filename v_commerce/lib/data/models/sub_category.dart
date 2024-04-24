import 'package:v_commerce/domain/entities/sub_catergory.dart';

class SubCategoryModel extends SubCategory {

  const SubCategoryModel(
 { 
    required super.id,
    required super.title,
    required super.image
}
    );

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) => SubCategoryModel(
      id: json['_id'],
      title: json['title'],
      image: json['image'],
      );

}
