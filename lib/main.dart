import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tmdb_web/core/routing/router.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'core/di/dependency_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    setUrlStrategy(PathUrlStrategy());
  }
  await setupGetIt();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      builder: (context, child) => ResponsiveSizer(
        builder: (context, orientation, screenType) {
          return child!;
        },
      ),
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown,
        },
      ),
      debugShowCheckedModeBanner: false,
      title: 'TMDB Web',
      darkTheme: ThemeData(
        useMaterial3: true,
        primaryColor: const Color(0xff039ac3),
        brightness: Brightness.dark,
        indicatorColor: Colors.white,
        canvasColor: Colors.black,
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        scrollbarTheme: const ScrollbarThemeData().copyWith(
          thumbVisibility: MaterialStateProperty.all(true),
          thumbColor: MaterialStateProperty.all(
            const Color(0xff039ac3).withOpacity(0.5),
          ),
        ),
      ),
      themeMode: ThemeMode.dark,
      routerConfig: AppRouter.router,
    );
  }
}
