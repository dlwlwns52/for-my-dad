import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ja'),
    Locale('ko'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In ko, this message translates to:
  /// **'FMD'**
  String get appTitle;

  /// No description provided for @hiddenSpot.
  ///
  /// In ko, this message translates to:
  /// **'히든스팟'**
  String get hiddenSpot;

  /// No description provided for @heroDescription.
  ///
  /// In ko, this message translates to:
  /// **'비밀 장소를 저장하고 다시 찾아가요!'**
  String get heroDescription;

  /// No description provided for @savedLocation.
  ///
  /// In ko, this message translates to:
  /// **'저장된 장소'**
  String get savedLocation;

  /// No description provided for @saveCurrentLocation.
  ///
  /// In ko, this message translates to:
  /// **'현재 위치 저장하기'**
  String get saveCurrentLocation;

  /// No description provided for @viewSavedLocation.
  ///
  /// In ko, this message translates to:
  /// **'저장된 장소 보기'**
  String get viewSavedLocation;

  /// No description provided for @tipsTitle.
  ///
  /// In ko, this message translates to:
  /// **'💡 사용 팁'**
  String get tipsTitle;

  /// No description provided for @mainGuide1.
  ///
  /// In ko, this message translates to:
  /// **'• 산삼·낚시 등 나만의 히든 스팟을 저장하세요!'**
  String get mainGuide1;

  /// No description provided for @mainGuide2.
  ///
  /// In ko, this message translates to:
  /// **'• 장소를 저장할 때 메모와 사진을 추가할 수 있습니다.'**
  String get mainGuide2;

  /// No description provided for @mainGuide3.
  ///
  /// In ko, this message translates to:
  /// **'• 오프라인에서도 모든 기능을 사용할 수 있습니다.'**
  String get mainGuide3;

  /// No description provided for @loadingFail.
  ///
  /// In ko, this message translates to:
  /// **'불러오기 실패하였습니다.'**
  String get loadingFail;

  /// No description provided for @retry.
  ///
  /// In ko, this message translates to:
  /// **'다시 시도하기'**
  String get retry;

  /// No description provided for @noSavedSpots.
  ///
  /// In ko, this message translates to:
  /// **'저장된 장소가 없습니다'**
  String get noSavedSpots;

  /// No description provided for @addFirstSpot.
  ///
  /// In ko, this message translates to:
  /// **'첫 번째 비밀 장소를 저장해보세요!'**
  String get addFirstSpot;

  /// No description provided for @goToSave.
  ///
  /// In ko, this message translates to:
  /// **'위치 저장하러 가기'**
  String get goToSave;

  /// No description provided for @distance.
  ///
  /// In ko, this message translates to:
  /// **'거리: '**
  String get distance;

  /// No description provided for @savedAt.
  ///
  /// In ko, this message translates to:
  /// **'저장: '**
  String get savedAt;

  /// No description provided for @imageCount.
  ///
  /// In ko, this message translates to:
  /// **'{count}장'**
  String imageCount(int count);

  /// No description provided for @deleteDialogTitle.
  ///
  /// In ko, this message translates to:
  /// **'장소를 삭제하시겠습니까?'**
  String get deleteDialogTitle;

  /// No description provided for @deleteDialogDesc.
  ///
  /// In ko, this message translates to:
  /// **'이 장소를 삭제하면 복구할 수 없습니다.'**
  String get deleteDialogDesc;

  /// No description provided for @cancel.
  ///
  /// In ko, this message translates to:
  /// **'취소'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In ko, this message translates to:
  /// **'삭제'**
  String get delete;

  /// No description provided for @mapOpenFail.
  ///
  /// In ko, this message translates to:
  /// **'맵을 여는데 실패했습니다.\n잠시후에 다시 시도해주세요'**
  String get mapOpenFail;

  /// No description provided for @imageFileNotFound.
  ///
  /// In ko, this message translates to:
  /// **'이미지 파일이 존재하지 않습니다.'**
  String get imageFileNotFound;

  /// No description provided for @saveCurrentLocationTitle.
  ///
  /// In ko, this message translates to:
  /// **'현재 위치를 저장하시겠습니까?'**
  String get saveCurrentLocationTitle;

  /// No description provided for @saveCurrentLocationDesc1.
  ///
  /// In ko, this message translates to:
  /// **'장소의 이름, 메모, 사진을 추가하여 나중에 쉽게 찾을 수 있도록'**
  String get saveCurrentLocationDesc1;

  /// No description provided for @saveCurrentLocationDesc2.
  ///
  /// In ko, this message translates to:
  /// **'저장하세요!'**
  String get saveCurrentLocationDesc2;

  /// No description provided for @placeNameLabel.
  ///
  /// In ko, this message translates to:
  /// **'장소 이름'**
  String get placeNameLabel;

  /// No description provided for @placeNameHint.
  ///
  /// In ko, this message translates to:
  /// **'장소 이름을 입력하세요'**
  String get placeNameHint;

  /// No description provided for @memoLabel.
  ///
  /// In ko, this message translates to:
  /// **'메모 (선택사항)'**
  String get memoLabel;

  /// No description provided for @memoHint.
  ///
  /// In ko, this message translates to:
  /// **'메모를 입력하세요'**
  String get memoHint;

  /// No description provided for @photoLabel.
  ///
  /// In ko, this message translates to:
  /// **'사진 (선택사항)'**
  String get photoLabel;

  /// No description provided for @addPhotoHint.
  ///
  /// In ko, this message translates to:
  /// **'사진을 추가하려면 클릭하세요'**
  String get addPhotoHint;

  /// No description provided for @addPhotoTitle.
  ///
  /// In ko, this message translates to:
  /// **'사진 추가'**
  String get addPhotoTitle;

  /// No description provided for @takePhoto.
  ///
  /// In ko, this message translates to:
  /// **'사진 촬영'**
  String get takePhoto;

  /// No description provided for @pickFromGallery.
  ///
  /// In ko, this message translates to:
  /// **'앨범에서 선택'**
  String get pickFromGallery;

  /// No description provided for @save.
  ///
  /// In ko, this message translates to:
  /// **'저장'**
  String get save;

  /// No description provided for @locationSavedSnapshot.
  ///
  /// In ko, this message translates to:
  /// **'현재 위치를 저장했어요.'**
  String get locationSavedSnapshot;

  /// No description provided for @cancelConfirmSnapshot.
  ///
  /// In ko, this message translates to:
  /// **'한 번 더 취소를 누르면 입력한 내용이 사라집니다.'**
  String get cancelConfirmSnapshot;

  /// No description provided for @compassTitle.
  ///
  /// In ko, this message translates to:
  /// **'나침반'**
  String get compassTitle;

  /// No description provided for @distanceAndDirection.
  ///
  /// In ko, this message translates to:
  /// **'목적지까지의 거리와 방향'**
  String get distanceAndDirection;

  /// No description provided for @distanceToDest.
  ///
  /// In ko, this message translates to:
  /// **'목적지까지 거리'**
  String get distanceToDest;

  /// No description provided for @accuracyLabel.
  ///
  /// In ko, this message translates to:
  /// **'정확도: ±{accuracy}m'**
  String accuracyLabel(String accuracy);

  /// No description provided for @gpsSearching.
  ///
  /// In ko, this message translates to:
  /// **'GPS 신호 찾는 중...'**
  String get gpsSearching;

  /// No description provided for @accuracyWarning.
  ///
  /// In ko, this message translates to:
  /// **'이 반경 내에서는 위치 안내가 부정확할 수 있습니다.'**
  String get accuracyWarning;

  /// No description provided for @spotCount.
  ///
  /// In ko, this message translates to:
  /// **'{count}개'**
  String spotCount(int count);

  /// No description provided for @characterCount.
  ///
  /// In ko, this message translates to:
  /// **'{current}/{max}자'**
  String characterCount(int current, int max);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ja', 'ko'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
