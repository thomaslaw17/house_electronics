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

      _rooms = rest
          .map<Room>((key) => Room.fromJson(key, data["rooms"][key]))
          .toList();
    }
    updateIsLoading(false);
  }

  void updateFixture(String roomName, String fixture, bool state) async {
    updateIsLoading(true);
    http.Response res;

    if (state) {
      res = await http
          .get(Uri.encodeFull(url + roomName + "/" + fixture + "/on"));
    } else {
      res = await http
          .get(Uri.encodeFull(url + roomName + "/" + fixture + "/off"));
    }

    if (res.statusCode == 200) {}

    updateIsLoading(false);
  }
}
