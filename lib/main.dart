import 'package:flutter/material.dart';
import 'package:pokedex/presentation/welcome_screen/welcome_screen.dart';
import 'package:pokedex/utils/get_it_initialization.dart';
import 'package:pokedex/utils/urls.dart';

void main() {
  GetItInitialization().setupGetIt();
  Urls().initializeDio();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokedex',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: WelcomeScreen(),
    );
  }
}
