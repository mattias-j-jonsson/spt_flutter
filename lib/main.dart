import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart'; // För debugPaintSizeEnabled

import 'home_page.dart';




void main() {
  // debugPaintSizeEnabled=true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}


// a splash screen to be shown right before training session begins
// containing info about the length of the session
/* class _splashScreen extends StatelessWidget{
  const _splashScreen({required this.exerciseLength});

  final Duration exerciseLength;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('${exerciseLength.inMinutes}'),
    );  
  }
} */
