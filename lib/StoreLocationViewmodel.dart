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

  Future<void> deleteAt(int index) async {
    try {
      await _spotService.deleteSpot(index);
      spots.removeAt(index);
      notifyListeners();
    } catch (e) {
      error = '삭제 실패: $e';
      printDebug("deleteAt 에러 : $e");
      notifyListeners();
    }
  }

  String formatDate(DateTime dt) {
    return DateFormat('yyyy-MM-dd HH:mm').format(dt);
  }
}
