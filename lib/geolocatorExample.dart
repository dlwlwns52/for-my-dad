import 'dart:async';
import 'dart:io' show Platform;

import 'package:baseflow_plugin_template/baseflow_plugin_template.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

/// Defines the main theme color.
final MaterialColor themeMaterialColor =
    BaseflowPluginExample.createMaterialColor(
      const Color.fromRGBO(48, 49, 60, 1),
    );

void main() {
  runApp(const GeolocatorWidget());
}

/// Example [Widget] showing the functionalities of the geolocator plugin
class GeolocatorWidget extends StatefulWidget {
  /// Creates a new GeolocatorWidget.
  const GeolocatorWidget({super.key});

  /// Utility method to create a page with the Baseflow templating.
  static ExamplePage createPage() {
    return ExamplePage(
      Icons.location_on,
      (context) => const GeolocatorWidget(),
    );
  }

  @override
  State<GeolocatorWidget> createState() => _GeolocatorWidgetState();
}

class _GeolocatorWidgetState extends State<GeolocatorWidget> {
  static const String _kLocationServicesDisabledMessage =
      'Location services are disabled.';
  static const String _kPermissionDeniedMessage = 'Permission denied.';
  static const String _kPermissionDeniedForeverMessage =
      'Permission denied forever.';
  static const String _kPermissionGrantedMessage = 'Permission granted.';

  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  final List<_PositionItem> _positionItems = <_PositionItem>[];
  StreamSubscription<Position>? _positionStreamSubscription;
  StreamSubscription<ServiceStatus>? _serviceStatusStreamSubscription;
  bool positionStreamStarted = false;

  @override
  void initState() {
    super.initState();
    _toggleServiceStatusStream();
  }

  PopupMenuButton _createActions() {
    return PopupMenuButton(
      elevation: 40,
      onSelected: (value) async {
        switch (value) {
          case 1:
            _getLocationAccuracy();
            break;
          case 2:
            _requestTemporaryFullAccuracy();
            break;
          case 3:
            _openAppSettings();
            break;
          case 4:
            _openLocationSettings();
            break;
          case 5:
            setState(_positionItems.clear);
            break;
          default:
            break;
        }
      },
      itemBuilder: (context) => [
        if (Platform.isIOS)
          const PopupMenuItem(value: 1, child: Text("Get Location Accuracy")),
        if (Platform.isIOS)
          const PopupMenuItem(
            value: 2,
            child: Text("Request Temporary Full Accuracy"),
          ),
        const PopupMenuItem(value: 3, child: Text("Open App Settings")),
        if (Platform.isAndroid || Platform.isWindows)
          const PopupMenuItem(value: 4, child: Text("Open Location Settings")),
        const PopupMenuItem(value: 5, child: Text("Clear")),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    const sizedBox = SizedBox(height: 10);

    return BaseflowPluginExample(
      pluginName: 'Geolocator',
      githubURL: 'https://github.com/Baseflow/flutter-geolocator',
      pubDevURL: 'https://pub.dev/packages/geolocator',
      appBarActions: [_createActions()],
      pages: [
        ExamplePage(
          Icons.location_on,
          (context) => Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surface,
            body: ListView.builder(
              itemCount: _positionItems.length,
              itemBuilder: (context, index) {
                final positionItem = _positionItems[index];
                // 로그값 나올때
                if (positionItem.type == _PositionItemType.log) {
                  return ListTile(
                    title: Text(
                      positionItem.displayValue,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                } else {
                  // 위치 값 나올때
                  return Card(
                    child: ListTile(
                      tileColor: themeMaterialColor,
                      title: Text(
                        positionItem.displayValue,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                }
              },
            ),
            floatingActionButton: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //MARK: 위치 정보 실시간 구독
                FloatingActionButton(
                  onPressed: () {
                    positionStreamStarted = !positionStreamStarted;
                    _toggleListening();
                  },
                  tooltip: (_positionStreamSubscription == null)
                      ? 'Start position updates'
                      : _positionStreamSubscription!.isPaused
                      ? 'Resume'
                      : 'Pause',
                  backgroundColor: _determineButtonColor(),
                  child:
                      (_positionStreamSubscription == null ||
                          _positionStreamSubscription!.isPaused)
                      ? const Icon(Icons.play_arrow)
                      : const Icon(Icons.pause),
                ),
                sizedBox,
                //MARK:  즉시 현재 위치를 한 번 조회
                FloatingActionButton(
                  onPressed: _getCurrentPosition,
                  child: const Icon(Icons.my_location),
                ),
                sizedBox,
                //MARK: 기기에 저장된 마지막 알려진 위치를 불러오는 버튼
                FloatingActionButton(
                  onPressed: _getLastKnownPosition,
                  child: const Icon(Icons.bookmark),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _getCurrentPosition() async {
    // 위치 권한 받아옴
    final hasPermission = await _handlePermission();

    // 위치 권한 false 시 반환
    if (!hasPermission) {
      return;
    }

    //현재 위치 받아옴
    final position = await _geolocatorPlatform.getCurrentPosition();

    _updatePositionList(_PositionItemType.position, position.toString());
  }

  Future<bool> _handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // 스마트폰의 GPS 버튼이 꺼져 있는지 확인
    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _updatePositionList(
        _PositionItemType.log,
        _kLocationServicesDisabledMessage,
      );

      return false;
    }

    permission = await _geolocatorPlatform.checkPermission();
    // 위치 권한 거부 상태 - 앱에서 위치 권한시 거부함
    if (permission == LocationPermission.denied) {
      // 위치 권한 재요청
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        _updatePositionList(_PositionItemType.log, _kPermissionDeniedMessage);
        return false;
      }
    }
    // 앱 위치권한 영구 거부 - 사용자가 설정에서 거부함
    if (permission == LocationPermission.deniedForever) {
      _updatePositionList(
        _PositionItemType.log,
        _kPermissionDeniedForeverMessage,
      );
      // 설정으로 이동하는 기능 추가

      return false;
    }
    // 성공시 로그 저장
    _updatePositionList(_PositionItemType.log, _kPermissionGrantedMessage);
    return true;
  }

  void _updatePositionList(_PositionItemType type, String displayValue) {
    _positionItems.add(_PositionItem(type, displayValue));
    setState(() {});
  }

  bool _isListening() =>
      !(_positionStreamSubscription == null ||
          _positionStreamSubscription!.isPaused);

  Color _determineButtonColor() {
    return _isListening() ? Colors.green : Colors.red;
  }

  void _toggleServiceStatusStream() {
    if (_serviceStatusStreamSubscription == null) {
      final serviceStatusStream = _geolocatorPlatform.getServiceStatusStream();
      _serviceStatusStreamSubscription = serviceStatusStream
          .handleError((error) {
            _serviceStatusStreamSubscription?.cancel();
            _serviceStatusStreamSubscription = null;
          })
          .listen((serviceStatus) {
            String serviceStatusValue;
            if (serviceStatus == ServiceStatus.enabled) {
              if (positionStreamStarted) {
                _toggleListening();
              }
              serviceStatusValue = 'enabled';
            } else {
              if (_positionStreamSubscription != null) {
                setState(() {
                  _positionStreamSubscription?.cancel();
                  _positionStreamSubscription = null;
                  _updatePositionList(
                    _PositionItemType.log,
                    'Position Stream has been canceled',
                  );
                });
              }
              serviceStatusValue = 'disabled';
            }
            _updatePositionList(
              _PositionItemType.log,
              'Location service has been $serviceStatusValue',
            );
          });
    }
  }

  void _toggleListening() {
    if (_positionStreamSubscription == null) {
      final positionStream = _geolocatorPlatform.getPositionStream();
      _positionStreamSubscription = positionStream
          .handleError((error) {
            _positionStreamSubscription?.cancel();
            _positionStreamSubscription = null;
          })
          .listen(
            (position) => _updatePositionList(
              _PositionItemType.position,
              position.toString(),
            ),
          );
      _positionStreamSubscription?.pause();
    }

    setState(() {
      if (_positionStreamSubscription == null) {
        return;
      }

      String statusDisplayValue;
      if (_positionStreamSubscription!.isPaused) {
        _positionStreamSubscription!.resume();
        statusDisplayValue = 'resumed';
      } else {
        _positionStreamSubscription!.pause();
        statusDisplayValue = 'paused';
      }

      _updatePositionList(
        _PositionItemType.log,
        'Listening for position updates $statusDisplayValue',
      );
    });
  }

  @override
  void dispose() {
    if (_positionStreamSubscription != null) {
      _positionStreamSubscription!.cancel();
      _positionStreamSubscription = null;
    }

    super.dispose();
  }

  void _getLastKnownPosition() async {
    final position = await _geolocatorPlatform.getLastKnownPosition();
    if (position != null) {
      _updatePositionList(_PositionItemType.position, position.toString());
    } else {
      _updatePositionList(
        _PositionItemType.log,
        'No last known position available',
      );
    }
  }

  void _getLocationAccuracy() async {
    final status = await _geolocatorPlatform.getLocationAccuracy();
    _handleLocationAccuracyStatus(status);
  }

  void _requestTemporaryFullAccuracy() async {
    final status = await _geolocatorPlatform.requestTemporaryFullAccuracy(
      purposeKey: "TemporaryPreciseAccuracy",
    );
    _handleLocationAccuracyStatus(status);
  }

  void _handleLocationAccuracyStatus(LocationAccuracyStatus status) {
    String locationAccuracyStatusValue;
    if (status == LocationAccuracyStatus.precise) {
      locationAccuracyStatusValue = 'Precise';
    } else if (status == LocationAccuracyStatus.reduced) {
      locationAccuracyStatusValue = 'Reduced';
    } else {
      locationAccuracyStatusValue = 'Unknown';
    }
    _updatePositionList(
      _PositionItemType.log,
      '$locationAccuracyStatusValue location accuracy granted.',
    );
  }

  void _openAppSettings() async {
    final opened = await _geolocatorPlatform.openAppSettings();
    String displayValue;

    if (opened) {
      displayValue = 'Opened Application Settings.';
    } else {
      displayValue = 'Error opening Application Settings.';
    }

    _updatePositionList(_PositionItemType.log, displayValue);
  }

  void _openLocationSettings() async {
    final opened = await _geolocatorPlatform.openLocationSettings();
    String displayValue;

    if (opened) {
      displayValue = 'Opened Location Settings';
    } else {
      displayValue = 'Error opening Location Settings';
    }

    _updatePositionList(_PositionItemType.log, displayValue);
  }
}

enum _PositionItemType { log, position }

class _PositionItem {
  _PositionItem(this.type, this.displayValue);

  final _PositionItemType type;
  final String displayValue;
}
