import 'package:flutter/material.dart';
import 'package:fyazidrb_weatherapp/pages/home_page.dart';
import 'package:fyazidrb_weatherapp/themes/themeprovider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Themeprovider(),
      builder: (context, child) => Consumer<Themeprovider>(
        builder: (context, theme, child) => MaterialApp(
            darkTheme: ThemeData.dark(),
            debugShowCheckedModeBanner: false,
            theme: theme.themeDate,
            home: const Homepage()),
      ),
    );
  }
}
