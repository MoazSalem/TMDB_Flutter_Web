import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tmdb_web/core/routing/router.dart';
import 'core/di/dependency_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
        scrollbars: false,
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown,
        },
      ),
      debugShowCheckedModeBanner: false,
      title: 'TMDB Web',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'quicksand',
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          surface: Colors.black,
          seedColor: const Color(0xff76b792),
          primary: const Color(0xff76b792),
          brightness: Brightness.dark,
        ),
      ),
      routerConfig: AppRouter.router,
    );
  }
}
