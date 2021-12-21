import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'routes/quiz.dart';
import 'routes/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(QuizApp()));
}

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'home',
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/quiz': (context) => Quiz(),
      },
      theme: ThemeData(
        textTheme: GoogleFonts.londrinaSolidTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
    );
  }
}
