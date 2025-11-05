import 'package:hive/hive.dart';

part 'hive_model.g.dart';

@HiveType(typeId: 0)
class Spot {
  @HiveField(0)
  String placeName;

  @HiveField(1)
  String? memo;

  @HiveField(2)
  String? imagePath;

  Spot({required this.placeName, required this.memo, required this.imagePath});
}
