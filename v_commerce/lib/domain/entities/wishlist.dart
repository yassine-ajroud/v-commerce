import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class WishList extends Equatable {
  final String id;
  final String userId;
  List<String> productsId;

  WishList({required this.id, required this.userId, required this.productsId});

  @override
  List<Object?> get props => [id, userId, productsId];
}
