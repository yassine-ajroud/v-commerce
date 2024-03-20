import '../../domain/entities/user.dart';

class UserModel extends User{
  const UserModel({super.id,required super.address,required super.image, required super.ban, required super.role, required super.firstName, required super.lastName, required super.email, required super.phone,  super.password,required super.oAuth});
 
 factory UserModel.fromJson(Map<String,dynamic> json)=>UserModel(
  id:json['_id'],
  image: json['imageUrl'],
  address: json['address'],
  ban: json['ban'],
  oAuth: json['OAuth'],
  role: json['role'],
  firstName: json['firstName'],
  lastName: json['lastName'],
  email: json['email'],
  phone: json['phone'],
  password: json['password']
  );

  Map<String,dynamic> toJson()=>{
    'firstName':firstName,
    'lastName':lastName,
    'email':email,
    'OAuth':oAuth,
    'phone':phone,
    'address':address,
    'role':role,
    'ban':ban,
    'password':password,
    'imageUrl':image
  };
}