// import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:fms/Module/db/hive_Service.dart';
import 'package:fms/Module/db/hive_model.dart';
import 'package:fms/Module/utils/logger.dart';
import 'package:intl/intl.dart';

// import 'package:geolocator/geolocator.dart';
// import 'package:image_picker/image_picker.dart';

class StoreLocationViewmodel extends ChangeNotifier {
  final SpotService _spotService;

  StoreLocationViewmodel(this._spotService);

  bool isLoading = false;
  String? error;
  List<Spot> spots = [];

  Future<void> init() async {
    await loadSpots();
  }

  Future<void> loadSpots() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      spots = await _spotService.fetchAllSpots();

      notifyListeners();
    } catch (e) {
      error = e.toString();
      printDebug("loadSpots 에러 : $e");
    } finally {
      isLoading = false;
      printDebug("loadSpots 로딩 완료");
      notifyListeners();
    }
  }

  String formatDate(DateTime dt) {
    return DateFormat('yyyy-MM-dd HH:mm').format(dt);
  }

  //MARK: 저장된 내용 삭제
  Future<void> removeCurrentSpot({required int index}) async {
    try {
      // isPendingDelete = false;
      printDebug("removeurrentSpot 시작");
      await _spotService.deleteSpot(index);
      spots.removeAt(index);
      notifyListeners();
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      printDebug("removeurrentSpot 종료됨");
    }
  }
}
