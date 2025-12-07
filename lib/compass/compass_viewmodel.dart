import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';

class CompassViewModel extends ChangeNotifier {
  final double targetLat;
  final double targetLng;

  StreamSubscription<CompassEvent>? _compassSubscription;
  StreamSubscription<Position>? _positionSubscription;

  double? _heading;
  double? _bearing;
  double? _distance;
  double? _accuracy;

  double? get heading => _heading;
  double? get bearing => _bearing;
  double? get distance => _distance;
  double? get accuracy => _accuracy;

  CompassViewModel({required this.targetLat, required this.targetLng}) {
    _startListening();
  }

  @override
  void dispose() {
    _compassSubscription?.cancel();
    _positionSubscription?.cancel();
    super.dispose();
  }

  void _startListening() {
    // 나침반 리스너
    _compassSubscription = FlutterCompass.events!.listen((event) {
      _heading = event.heading;
      _accuracy = event.accuracy;
      notifyListeners();
    });

    // 위치 리스너
    const locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 5,
    );

    _positionSubscription =
        Geolocator.getPositionStream(locationSettings: locationSettings).listen(
          (position) {
            _calculateTargetInfo(position);
          },
        );

    // 초기값 가져오기
    Geolocator.getCurrentPosition(locationSettings: locationSettings).then((
      position,
    ) {
      _calculateTargetInfo(position);
    });
  }

  void _calculateTargetInfo(Position currentPos) {
    _distance = Geolocator.distanceBetween(
      currentPos.latitude,
      currentPos.longitude,
      targetLat,
      targetLng,
    );

    _bearing = Geolocator.bearingBetween(
      currentPos.latitude,
      currentPos.longitude,
      targetLat,
      targetLng,
    );

    notifyListeners();
  }

  String formatDistance(double? meters) {
    if (meters == null) return "--m";
    if (meters >= 1000) {
      return "${(meters / 1000).toStringAsFixed(1)}km";
    }
    return "${meters.toStringAsFixed(0)}m";
  }
}
