// Postman Echo is service you can use to test your REST clients and make sample API calls.
// It provides endpoints for `GET`, `POST`, `PUT`, various auth mechanisms and other utility
// endpoints.
//
// The documentation for the endpoints as well as example responses can be found at
// [https://postman-echo.com](https://postman-echo.com/?source=echo-collection-app-onboarding)
// To parsrequirede this JSON data, do
//
//     final generation = generationFromMap(jsonString);

import 'dart:convert';

class Generation {
  Generation({
    required this.initialDate,
    required this.finalDate,
    required this.uid,
  });

  DateTime initialDate;
  DateTime finalDate;
  String uid;

  factory Generation.fromJson(String str) =>
      Generation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Generation.fromMap(Map<String, dynamic> json) => Generation(
        initialDate: DateTime.parse(json["initialDate"]),
        finalDate: DateTime.parse(json["finalDate"]),
        uid: json["uid"],
      );

  Map<String, dynamic> toMap() => {
        "initialDate": initialDate.toIso8601String(),
        "finalDate": finalDate.toIso8601String(),
        "uid": uid,
      };
}

