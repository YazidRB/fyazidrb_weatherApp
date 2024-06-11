import 'package:flutter/material.dart';
import 'package:my_first_app/pages/homePage.dart';
import 'package:my_first_app/themes/themeprovider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyAPpState();
  }
}

class MyAPpState extends State<StatefulWidget> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Themeprovider(),
      builder: (context, child) => Consumer<Themeprovider>(
        builder: (context, theme, child) => MaterialApp(
            darkTheme: ThemeData.dark(),
            debugShowCheckedModeBanner: false,
            theme: theme.themeDate,
            home: Homepage()),
      ),
    );
  }
}
