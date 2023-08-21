// Postman Echo is service you can use to test your REST clients and make sample API calls.
// It provides endpoints for `GET`, `POST`, `PUT`, various auth mechanisms and other utility
// endpoints.
//
// The documentation for the endpoints as well as example responses can be found at
// [https://postman-echo.com](https://postman-echo.com/?source=echo-collection-app-onboarding)
// To parse this JSON data, do
//
//     final horario = horarioFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class Horario {
    Horario({
        required this.schoolYear,
        required this.semestre,
        required this.group,
        required this.hours,
        required this.monday,
        required this.tuesday,
        required this.wednesday,
        required this.thursday,
        required this.friday,
        required this.uid,
    });

    SchoolYear schoolYear;
    Dates semestre;
    Dates group;
    List<String> hours;
    List<Dates> monday;
    List<Dates> tuesday;
    List<Dates> wednesday;
    List<Dates> thursday;
    List<Dates> friday;
    String uid;

    factory Horario.fromJson(String str) => Horario.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Horario.fromMap(Map<String, dynamic> json) => Horario(
        schoolYear: SchoolYear.fromMap(json["schoolYear"]),
        semestre: Dates.fromMap(json["semestre"]),
        group: Dates.fromMap(json["group"]),
        hours: List<String>.from(json["hours"].map((x) => x)),
        monday: List<Dates>.from(json["monday"].map((x) => Dates.fromMap(x))),
        tuesday: List<Dates>.from(json["tuesday"].map((x) => Dates.fromMap(x))),
        wednesday: List<Dates>.from(json["wednesday"].map((x) => Dates.fromMap(x))),
        thursday: List<Dates>.from(json["thursday"].map((x) => Dates.fromMap(x))),
        friday: List<Dates>.from(json["friday"].map((x) => Dates.fromMap(x))),
        uid: json["uid"],
    );

    Map<String, dynamic> toMap() => {
        "schoolYear": schoolYear.toMap(),
        "semestre": semestre.toMap(),
        "group": group.toMap(),
        "hours": List<dynamic>.from(hours.map((x) => x)),
        "monday": List<dynamic>.from(monday.map((x) => x.toMap())),
        "tuesday": List<dynamic>.from(tuesday.map((x) => x.toMap())),
        "wednesday": List<dynamic>.from(wednesday.map((x) => x.toMap())),
        "thursday": List<dynamic>.from(thursday.map((x) => x.toMap())),
        "friday": List<dynamic>.from(friday.map((x) => x.toMap())),
        "uid": uid,
    };
}

class Dates {
    Dates({
        required this.id,
        required this.name,
    });

    String id;
    String name;

    factory Dates.fromJson(String str) => Dates.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Dates.fromMap(Map<String, dynamic> json) => Dates(
        id: json["_id"],
        name: json["name"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "name": name,
    };
}

class SchoolYear {
    SchoolYear({
        required this.id,
        required this.initialDate,
        required this.finalDate,
    });

    String id;
    DateTime initialDate;
    DateTime finalDate;

    factory SchoolYear.fromJson(String str) => SchoolYear.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory SchoolYear.fromMap(Map<String, dynamic> json) => SchoolYear(
        id: json["_id"],
        initialDate: DateTime.parse(json["initialDate"]),
        finalDate: DateTime.parse(json["finalDate"]),
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "initialDate": initialDate.toIso8601String(),
        "finalDate": finalDate.toIso8601String(),
    };
}
