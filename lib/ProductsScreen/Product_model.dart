
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Product_model.g.dart';

@HiveType(typeId : 0)
@JsonSerializable()
class Product {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String category;
  @HiveField(2)
  final String name;
  @HiveField(3)
  final String picture;
  @HiveField(4)
  final double price;
  @HiveField(5)
  final double duration;
  @HiveField(6)
  final String hintTitle;
  @HiveField(7)
  final String hintDescription;
  @HiveField(8)
  int count = 0;

  Product({ this.id, this.hintTitle, this.hintDescription, this.price, this.duration, this.picture, this.category, this.name});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['uuid'] as String,
        name: json['name'] as String,
        hintDescription: json['hint']['description'] as String,
        picture: json['picture'] as String,
        price: json['price'] as double,
        duration: json['duration'] as double,
        hintTitle: json['hint']['title'] as String,
        category: json['category'] as String
    );
  }
}