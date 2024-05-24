import 'package:v_commerce/domain/entities/service.dart';

// ignore: must_be_immutable
class ServiceModel extends Service{
  ServiceModel({super.id,super.cost,super.courtesy,super.quality,super.ponctuality,super.rate, required super.service, required super.description, required super.experience, required super.images, required super.userId});

factory ServiceModel.fromJson(Map<String,dynamic>json)=>ServiceModel(service: json['service'],
 description: json['description'], experience:  json['experience'], images:  json['images'], userId: json['userId'],
 id:json['_id'],courtesy: json['courtesy'],quality: json['quality'],cost:json['cost'],ponctuality: json['Punctuality'],
 rate: json['rate']
  );


Map<String,dynamic> toJson()=>{
  "description":description,
  "experience":experience,
  "service":service,
  "userId":userId,
"images":images
}  ;
}