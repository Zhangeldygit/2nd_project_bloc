// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Product_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductAdapter extends TypeAdapter<Product> {
  @override
  final int typeId = 0;

  @override
  Product read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Product(
      id: fields[0] as String,
      hintTitle: fields[6] as String,
      hintDescription: fields[7] as String,
      price: fields[4] as double,
      duration: fields[5] as double,
      picture: fields[3] as String,
      category: fields[1] as String,
      name: fields[2] as String,
    )..count = fields[8] as int;
  }

  @override
  void write(BinaryWriter writer, Product obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.category)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.picture)
      ..writeByte(4)
      ..write(obj.price)
      ..writeByte(5)
      ..write(obj.duration)
      ..writeByte(6)
      ..write(obj.hintTitle)
      ..writeByte(7)
      ..write(obj.hintDescription)
      ..writeByte(8)
      ..write(obj.count);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
    id: json['id'] as String,
    hintTitle: json['hintTitle'] as String,
    hintDescription: json['hintDescription'] as String,
    price: (json['price'] as num)?.toDouble(),
    duration: (json['duration'] as num)?.toDouble(),
    picture: json['picture'] as String,
    category: json['category'] as String,
    name: json['name'] as String,
  )..count = json['count'] as int;
}

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'category': instance.category,
      'name': instance.name,
      'picture': instance.picture,
      'price': instance.price,
      'duration': instance.duration,
      'hintTitle': instance.hintTitle,
      'hintDescription': instance.hintDescription,
      'count': instance.count,
    };
