import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:house_electronics/models/room.dart';
import 'package:http/http.dart' as http;

class RoomList with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Room> _rooms = List<Room>();
  List<Room> get rooms => _rooms;

  RoomList() {
    getRoomList();
  }

  set rooms(List<Room> rooms) {
    _rooms = rooms;
    notifyListeners();
  }

  static String url = "http://private-1e863-house4591.apiary-mock.com/";

  void updateIsLoading(bool isLoading) {
    this._isLoading = isLoading;
    notifyListeners();
  }

  void getRoomList() async {
    updateIsLoading(true);

    http.Response res = await http.get(Uri.encodeFull(url + "rooms"),
        headers: {"Accept": "application/json"});

    if (res.statusCode == 200) {
      Map<String, dynamic> data = json.decode(res.body);

      List<String> rest = data["rooms"].keys.toList();

      _rooms = rest.map<Room>((roomName) {
        Map<dynamic, bool> states = Map<dynamic, bool>();

        data["rooms"][roomName]["fixtures"].forEach((fixture) {
          states[fixture] = false;
        });

        return Room.fromJson(roomName, data["rooms"][roomName], states);
      }).toList();
    }

    updateIsLoading(false);
  }

  void updateFixture(String roomName, String fixture, bool state) async {
    updateIsLoading(true);

    http.Response res;

    _rooms.forEach((room) {
      if (room.name == roomName) {
        room.fixtureStates[fixture] = state;
      }
    });

    notifyListeners();

    if (state) {
      res = await http.get(Uri.encodeFull(
          url + roomName.toLowerCase() + "/" + fixture.toLowerCase() + "/on"));
    } else {
      res = await http.get(Uri.encodeFull(
          url + roomName.toLowerCase() + "/" + fixture.toLowerCase() + "/off"));
    }

    if (res.statusCode == 200 && res.body == "true") {
      updateIsLoading(false);
    }
  }

  void updateWeather() async {
    http.Response res;

    res = await http.get(Uri.encodeFull(url + "/weather/cold"),
        headers: {"Accept": "application/json"});

    if (res.statusCode == 200) {
      Map<String, dynamic> data = json.decode(res.body);

      if (data["consolidated_weather"][0]["the_temp"] < 25) {
        _rooms.forEach((room) {
          if (room.fixtures.contains("AC")) {
            room.fixtureStates["AC"] = true;
          }
        });
      }
    }
  }
}
