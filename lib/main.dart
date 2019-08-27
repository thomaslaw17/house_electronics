import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:house_electronics/data/roomDAO.dart';
import 'package:house_electronics/pages/homePage.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RoomList>.value(
      value: RoomList(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark(),
        home: HomePage(),
      ),
    );
  }
}
