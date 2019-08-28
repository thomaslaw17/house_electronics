class Room {
  String name;
  List<dynamic> fixtures;
  Map<dynamic, bool> fixtureStates;

  Room({this.name, this.fixtures, this.fixtureStates});

  factory Room.fromJson(
      String name, Map<String, dynamic> json, Map<dynamic, bool> states) {
    return Room(name: name, fixtures: json["fixtures"], fixtureStates: states);
  }
}
