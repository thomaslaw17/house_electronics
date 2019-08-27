class Room {
  String name;
  List<dynamic> fixtures;

  Room({this.name, this.fixtures});

  factory Room.fromJson(String name, Map<String, dynamic> json) {
    return Room(name: name, fixtures: json["fixtures"]);
  }
}
