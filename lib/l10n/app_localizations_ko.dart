// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => 'FMD';

  @override
  String get hiddenSpot => '히든스팟';

  @override
  String get heroDescription => '비밀 장소를 저장하고 다시 찾아가요!';

  @override
  String get savedLocation => '저장된 장소';

  @override
  String get saveCurrentLocation => '현재 위치 저장하기';

  @override
  String get viewSavedLocation => '저장된 장소 보기';

  @override
  String get tipsTitle => '💡 사용 팁';

  @override
  String get mainGuide1 => '• 산삼·낚시 등 나만의 히든 스팟을 저장하세요!';

  @override
  String get mainGuide2 => '• 장소를 저장할 때 메모와 사진을 추가할 수 있습니다.';

  @override
  String get mainGuide3 => '• 오프라인에서도 모든 기능을 사용할 수 있습니다.';

  @override
  String get loadingFail => '불러오기 실패하였습니다.';

  @override
  String get retry => '다시 시도하기';

  @override
  String get noSavedSpots => '저장된 장소가 없습니다';

  @override
  String get addFirstSpot => '첫 번째 비밀 장소를 저장해보세요!';

  @override
  String get goToSave => '위치 저장하러 가기';

  @override
  String get distance => '거리: ';

  @override
  String get savedAt => '저장: ';

  @override
  String imageCount(int count) {
    return '$count장';
  }

  @override
  String get deleteDialogTitle => '장소를 삭제하시겠습니까?';

  @override
  String get deleteDialogDesc => '이 장소를 삭제하면 복구할 수 없습니다.';

  @override
  String get cancel => '취소';

  @override
  String get delete => '삭제';

  @override
  String get mapOpenFail => '맵을 여는데 실패했습니다.\n잠시후에 다시 시도해주세요';

  @override
  String get imageFileNotFound => '이미지 파일이 존재하지 않습니다.';

  @override
  String get saveCurrentLocationTitle => '현재 위치를 저장하시겠습니까?';

  @override
  String get saveCurrentLocationDesc1 => '장소의 이름, 메모, 사진을 추가하여 나중에 쉽게 찾을 수 있도록';

  @override
  String get saveCurrentLocationDesc2 => '저장하세요!';

  @override
  String get placeNameLabel => '장소 이름';

  @override
  String get placeNameHint => '장소 이름을 입력하세요';

  @override
  String get memoLabel => '메모 (선택사항)';

  @override
  String get memoHint => '메모를 입력하세요';

  @override
  String get photoLabel => '사진 (선택사항)';

  @override
  String get addPhotoHint => '사진을 추가하려면 클릭하세요';

  @override
  String get addPhotoTitle => '사진 추가';

  @override
  String get takePhoto => '사진 촬영';

  @override
  String get pickFromGallery => '앨범에서 선택';

  @override
  String get save => '저장';

  @override
  String get locationSavedSnapshot => '현재 위치를 저장했어요.';

  @override
  String get cancelConfirmSnapshot => '한 번 더 취소를 누르면 입력한 내용이 사라집니다.';

  @override
  String get compassTitle => '나침반';

  @override
  String get distanceAndDirection => '목적지까지의 거리와 방향';

  @override
  String get distanceToDest => '목적지까지 거리';

  @override
  String accuracyLabel(String accuracy) {
    return '정확도: ±${accuracy}m';
  }

  @override
  String get gpsSearching => 'GPS 신호 찾는 중...';

  @override
  String get accuracyWarning => '이 반경 내에서는 위치 안내가 부정확할 수 있습니다.';

  @override
  String spotCount(int count) {
    return '$count개';
  }

  @override
  String characterCount(int current, int max) {
    return '$current/$max자';
  }
}
