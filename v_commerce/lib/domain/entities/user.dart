import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String? password;
  final String? image;
  final String? address;
  final bool ban;
  final String role;
  final String? oAuth;
  final String? gender;
  final String? birthDate;


  const User(
      {
      this.id,
      required this.birthDate,
      required this.gender,
      required this.oAuth,
      required this.address,
      required this.image,
      required this.ban,
      required this.role,  
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.phone,
       this.password});

  @override
  List<Object?> get props => [firstName,lastName,email,phone,password,ban,id,role,image,address,oAuth,gender,birthDate];

}