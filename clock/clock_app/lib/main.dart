import 'package:clock_app/model/enums.dart';
import 'package:clock_app/view/homepage.dart';
import 'package:clock_app/model/menu_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider<MenuInfo>(
          create: (context) => MenuInfo(MenuType.clock), child: HomePage()),
    );
  }
}
