import 'package:equatable/equatable.dart';

class Fournisseur extends Equatable {
  final String name;
  final String address;
  final num phone;
  final String userID;
  final String id;

  const Fournisseur({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.userID
  });

  @override
  List<Object?> get props => [
        name,
        id,
        address,
        phone,
        userID
      ];
}
