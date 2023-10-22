import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:galaxy_planet/providers/planet_provider.dart';
import 'package:galaxy_planet/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarColor: Colors.transparent));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PlanetProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Galaxy Planet',
        theme: ThemeData(
          textTheme: const TextTheme(
              bodyMedium: TextStyle(
                  fontSize: 19,
                  height: 1.1,
                  color: Colors.white,
                  fontWeight: FontWeight.w500)),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
