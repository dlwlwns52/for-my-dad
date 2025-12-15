import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fms/Module/db/hive_service.dart';
import 'package:fms/StoreLocationViewmodel.dart';
import 'package:fms/UIApplication/main_screen.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:fms/Module/db/hive_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fms/l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await Hive.initFlutter();
  Hive.registerAdapter(SpotAdapter());

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => StoreLocationViewmodel(SpotService())..init(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852), // 피그마 기준
      minTextAdapt: true, // 글자 크기 조정
      splitScreenMode: true, // 앱 창 크기 변경시 자동 스케일링
      builder: (context, child) {
        return MaterialApp(
          title: 'FMD',
          theme: ThemeData(fontFamily: 'Pretendard'),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('ko'), // Korean
            Locale('en'), // English
            Locale('ja'), // Japanese
          ],
          home: const MainScreen(),
        );
      },
    );
  }
}
