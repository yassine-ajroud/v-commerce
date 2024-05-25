import 'package:v_commerce/domain/entities/service.dart';

// ignore: must_be_immutable
class ServiceModel extends MyService{
  ServiceModel({super.id,super.cost,super.courtesy,super.quality,super.ponctuality,super.rate, required super.service, required super.description, required super.experience, required super.images, required super.userId});

factory ServiceModel.fromJson(Map<String,dynamic>json)=>ServiceModel(service: json['service'],
 description: json['description'], experience:   int.parse(json['experience'].toString()), images:  (json['images'] as List).map((e) => e.toString()).toList(), userId: json['userId'],
 id:json['_id'],courtesy:  double.parse(json['courtesy'].toString()),quality:  double.parse(json['quality'].toString()),cost: double.parse(json['cost'].toString()),ponctuality: double.parse(json['Punctuality'].toString()),
 rate:  double.parse(json['rate'].toString())
  );


Map<String,dynamic> toJson()=>{
  "description":description,
  "experience":experience,
  "service":service,
  "userId":userId,
"images":images
}  ;
}