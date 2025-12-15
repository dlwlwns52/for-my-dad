// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'FMD';

  @override
  String get hiddenSpot => 'Hidden Spot';

  @override
  String get heroDescription => 'Save your secret spots and visit them again!';

  @override
  String get savedLocation => 'Saved Locations';

  @override
  String get saveCurrentLocation => 'Save Current Location';

  @override
  String get viewSavedLocation => 'View Saved Locations';

  @override
  String get tipsTitle => '💡 Tips';

  @override
  String get mainGuide1 =>
      '• Save your own hidden spots like wild ginseng or fishing spots!';

  @override
  String get mainGuide2 =>
      '• You can add memos and photos when saving a location.';

  @override
  String get mainGuide3 => '• You can use all features even offline.';

  @override
  String get loadingFail => 'Failed to load.';

  @override
  String get retry => 'Try Again';

  @override
  String get noSavedSpots => 'No saved spots';

  @override
  String get addFirstSpot => 'Save your first secret spot!';

  @override
  String get goToSave => 'Go to Save Location';

  @override
  String get distance => 'Distance: ';

  @override
  String get savedAt => 'Saved: ';

  @override
  String imageCount(int count) {
    return '$count images';
  }

  @override
  String get deleteDialogTitle => 'Delete this spot?';

  @override
  String get deleteDialogDesc => 'This action cannot be undone.';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get mapOpenFail => 'Failed to open map.\nPlease try again later.';

  @override
  String get imageFileNotFound => 'Image file not found.';

  @override
  String get saveCurrentLocationTitle => 'Save current location?';

  @override
  String get saveCurrentLocationDesc1 =>
      'Add a name, memo, and photos to easily find';

  @override
  String get saveCurrentLocationDesc2 => 'your spot later!';

  @override
  String get placeNameLabel => 'Place Name';

  @override
  String get placeNameHint => 'Enter place name';

  @override
  String get memoLabel => 'Memo (Optional)';

  @override
  String get memoHint => 'Enter memo';

  @override
  String get photoLabel => 'Photos (Optional)';

  @override
  String get addPhotoHint => 'Click to add photos';

  @override
  String get addPhotoTitle => 'Add Photo';

  @override
  String get takePhoto => 'Take Photo';

  @override
  String get pickFromGallery => 'Pick from Gallery';

  @override
  String get save => 'Save';

  @override
  String get locationSavedSnapshot => 'Location saved.';

  @override
  String get cancelConfirmSnapshot => 'Press cancel again to discard.';

  @override
  String get compassTitle => 'Compass';

  @override
  String get distanceAndDirection => 'Distance and Direction';

  @override
  String get distanceToDest => 'Distance to destination';

  @override
  String accuracyLabel(String accuracy) {
    return 'Accuracy: ±${accuracy}m';
  }

  @override
  String get gpsSearching => 'Searching for GPS...';

  @override
  String get accuracyWarning =>
      'Guidance may be inaccurate within this radius.';

  @override
  String spotCount(int count) {
    return '$count Spots';
  }

  @override
  String characterCount(int current, int max) {
    return '$current/$max';
  }
}
