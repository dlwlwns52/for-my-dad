// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'FMD';

  @override
  String get hiddenSpot => '隠れスポット';

  @override
  String get heroDescription => '秘密の場所を保存して、また訪れましょう！';

  @override
  String get savedLocation => '保存された場所';

  @override
  String get saveCurrentLocation => '現在地を保存';

  @override
  String get viewSavedLocation => '保存された場所を見る';

  @override
  String get tipsTitle => '💡 ヒント';

  @override
  String get mainGuide1 => '• 山参・釣りなど、自分だけの隠れスポットを保存しましょう！';

  @override
  String get mainGuide2 => '• 場所を保存する際にメモや写真を追加できます。';

  @override
  String get mainGuide3 => '• オフラインでもすべての機能を使用できます';

  @override
  String get loadingFail => '読み込みに失敗しました。';

  @override
  String get retry => '再試行';

  @override
  String get noSavedSpots => '保存された場所がありません';

  @override
  String get addFirstSpot => '最初の秘密の場所を保存してみましょう！';

  @override
  String get goToSave => '場所を保存しに行く';

  @override
  String get distance => '距離: ';

  @override
  String get savedAt => '保存: ';

  @override
  String imageCount(int count) {
    return '$count枚';
  }

  @override
  String get deleteDialogTitle => '場所を削除しますか？';

  @override
  String get deleteDialogDesc => 'この場所を削除すると復元できません。';

  @override
  String get cancel => 'キャンセル';

  @override
  String get delete => '削除';

  @override
  String get mapOpenFail => 'マップを開けませんでした。\n後でもう一度お試しください。';

  @override
  String get imageFileNotFound => '画像ファイルが見つかりません。';

  @override
  String get saveCurrentLocationTitle => '現在地を保存しますか？';

  @override
  String get saveCurrentLocationDesc1 => '場所の名前、メモ、写真を追加して、後で';

  @override
  String get saveCurrentLocationDesc2 => '見つけやすくしましょう！';

  @override
  String get placeNameLabel => '場所の名前';

  @override
  String get placeNameHint => '場所の名前を入力';

  @override
  String get memoLabel => 'メモ (任意)';

  @override
  String get memoHint => 'メモを入力';

  @override
  String get photoLabel => '写真 (任意)';

  @override
  String get addPhotoHint => 'クリックして写真を追加';

  @override
  String get addPhotoTitle => '写真を追加';

  @override
  String get takePhoto => '写真を撮る';

  @override
  String get pickFromGallery => 'アルバムから選択';

  @override
  String get save => '保存';

  @override
  String get locationSavedSnapshot => '現在地を保存しました。';

  @override
  String get cancelConfirmSnapshot => 'もう一度キャンセルを押すと入力内容が削除されます。';

  @override
  String get compassTitle => 'コンパス';

  @override
  String get distanceAndDirection => '目的地までの距離と方向';

  @override
  String get distanceToDest => '目的地までの距離';

  @override
  String accuracyLabel(String accuracy) {
    return '精度: ±${accuracy}m';
  }

  @override
  String get gpsSearching => 'GPS信号を検索中...';

  @override
  String get accuracyWarning => 'この半径内では位置案内が不正確になる可能性があります。';

  @override
  String spotCount(int count) {
    return '$count件';
  }

  @override
  String characterCount(int current, int max) {
    return '$current/$max文字';
  }
}
