
import 'package:v_commerce/domain/entities/service_category.dart';

class ServiceCategoryModel extends ServiceCategory {

  const ServiceCategoryModel(
 { 
    required super.id,
    required super.title,
    required super.image
}
    );

  factory ServiceCategoryModel.fromJson(Map<String, dynamic> json) => ServiceCategoryModel(
      id: json['_id'],
      title: json['title'],
      image: json['image'],
      );

}
