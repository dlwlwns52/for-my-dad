import 'package:hive/hive.dart';
import './hive_model.dart';

class SpotRepository {
  static final SpotRepository _instance = SpotRepository._internal();
  factory SpotRepository() => _instance;
  SpotRepository._internal();
  static const String _boxName = 'spotBox';
  Box<Spot>? _box;

  Future<Box<Spot>> get box async {
    _box ??= await Hive.openBox<Spot>(_boxName);
    return _box!;
  }

  // MARK: CRUD 메서드

  /// 모든 Spot 불러오기
  Future<List<Spot>> getAllSpots() async {
    final b = await box;
    return b.values.toList();
  }

  /// Spot 추가
  Future<void> addSpot(Spot spot) async {
    final b = await box;
    await b.add(spot);
  }

  /// 특정 Spot 수정
  Future<void> updateSpot(int index, Spot updatedSpot) async {
    final b = await box;
    await b.putAt(index, updatedSpot);
  }

  /// 특정 Spot 삭제
  Future<void> deleteSpot(int index) async {
    final b = await box;
    await b.deleteAt(index);
  }

  /// 모든 Spot 삭제
  Future<void> clearAll() async {
    final b = await box;
    await b.clear();
  }
}
