import 'package:hive/hive.dart';

part 'hive_model.g.dart';

@HiveType(typeId: 0)
class Spot {
  @HiveField(0)
  String placeName;

  @HiveField(1)
  String? memo;

  @HiveField(2)
  List<String>? imagePath;

  @HiveField(3)
  double latitude; // 위도

  @HiveField(4)
  double longitude; // 경도

  @HiveField(5)
  DateTime createdAt = DateTime.now();

  Spot({
    required this.placeName,
    required this.memo,
    required this.imagePath,
    required this.latitude,
    required this.longitude,
  });
}
