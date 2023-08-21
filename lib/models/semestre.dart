// Postman Echo is service you can use to test your REST clients and make sample API calls.
// It provides endpoints for `GET`, `POST`, `PUT`, various auth mechanisms and other utility
// endpoints.
//
// The documentation for the endpoints as well as example responses can be found at
// [https://postman-echo.com](https://postman-echo.com/?source=echo-collection-app-onboarding)
// To pars requirede this JSON data, do
//
//     final semestre = semestreFromMap(jsonString);

import 'dart:convert';

class Semestre {
  Semestre({
    required this.name,
    required this.periodic,
    required this.cursando,
    required this.uid,
  });

  String name;
  String periodic;
  bool cursando;
  String uid;

  factory Semestre.fromJson(String str) => Semestre.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Semestre.fromMap(Map<String, dynamic> json) => Semestre(
        name: json["name"],
        periodic: json["periodic"],
        cursando: json["cursando"],
        uid: json["uid"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "periodic": periodic,
        "cursando": cursando,
        "_id": uid,
      };
}
