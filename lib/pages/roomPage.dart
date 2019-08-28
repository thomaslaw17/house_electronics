import 'package:flutter/material.dart';
import 'package:house_electronics/data/roomDAO.dart';
import 'package:house_electronics/models/room.dart';
import 'package:provider/provider.dart';

class RoomPage extends StatelessWidget {
  final int roomNumber;

  RoomPage(this.roomNumber);

  @override
  Widget build(BuildContext context) {
    final Room room = Provider.of<RoomList>(context).rooms[roomNumber];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(room.name),
      ),
      body: ListView.builder(
        itemCount: room.fixtures.length,
        itemBuilder: (context, i) {
          return SwitchListTile(
            title: Text(room.fixtures[i]),
            value: room.fixtureStates[room.fixtures[i]],
            onChanged: (state) {
              Provider.of<RoomList>(context)
                  .updateFixture(room.name, room.fixtures[i], state);
            },
          );
        },
      ),
    );
  }
}
