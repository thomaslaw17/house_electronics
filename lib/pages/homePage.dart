import 'package:flutter/material.dart';
import 'package:house_electronics/data/roomDAO.dart';

import 'package:house_electronics/models/room.dart';
import 'package:house_electronics/pages/roomPage.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Room> rooms = Provider.of<RoomList>(context).rooms;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Home Electronics"),
        ),
        body: ListView.builder(
          padding: EdgeInsets.all(10.0),
          itemCount: rooms.length,
          itemBuilder: (context, i) {
            return Card(
              margin: EdgeInsets.symmetric(vertical: 5.0),
              elevation: 1.0,
              child: ListTile(
                title: Text(rooms[i].name),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RoomPage(i)));
                },
              ),
            );
          },
        ));
  }
}
