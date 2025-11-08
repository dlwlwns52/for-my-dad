import 'package:fms/Module/utils/logger.dart';
import './hive_model.dart';
import './hive_repository.dart';

class SpotService {
  final SpotRepository _repository = SpotRepository();

  //모든 값 불러오기
  Future<List<Spot>> fetchAllSpots() async {
    try {
      printDebug("fetchAllSpots 실행");
      final spots = await _repository.getAllSpots();
      return spots;
    } catch (e) {
      printDebug("fetchAllSpots 실패: $e");
      return [];
    }
  }

  // Spot 추가
  Future<void> addSpot(Spot spot) async {
    try {
      await _repository.addSpot(spot);
      printDebug("Spot 추가 완료 : ${spot.placeName}");
    } catch (e) {
      printDebug('addSpot 실패: $e');
    }
  }

  // 특정 Spot 수정
  Future<void> updateSpot(int index, Spot updatedSpot) async {
    try {
      await _repository.updateSpot(index, updatedSpot);
      printDebug("Spot 업데이트 완료 : ${updatedSpot.placeName}");
    } catch (e) {
      printDebug('updateSpot 실패: $e');
    }
  }

  Future<void> deleteSpot(int index) async {
    try {
      await _repository.deleteSpot(index);
      printDebug("Spot 업데이트 완료 : index=$index 번");
    } catch (e) {
      printDebug('deleteSpot 실패: $e');
    }
  }

  Future<void> clearAll() async {
    try {
      await _repository.clearAll();
      printDebug("모든 Spot 삭제 완료");
    } catch (e) {
      printDebug('clearAll 실패: $e');
    }
  }
}
