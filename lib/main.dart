import 'package:flutter/material.dart';
// import 'login_page.dart';
import 'home_page.dart';
import 'result_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initialization(null);  // splash screen wait

  runApp(const MyApp());
}

Future initialization(BuildContext? context) async {
  await Future.delayed(const Duration(seconds: 3));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BMI Calculator',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.black,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white70),
        ),
      ),
      initialRoute: '/home',
      routes: {
//        '/': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/result': (context) => const ResultPage(
              bmi: 0.0,
              bmiCategory: '',
              height: 0.0,
              age: 0,
              gender: '',
            ),
      },
    );
  }
}
