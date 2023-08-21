// To parse this JSON data, do
//
//     final adviserTutor = adviserTutorFromJson(jsonString);

import 'dart:convert';

import 'package:sistema_escolar_prepa/models/teacher.dart';

import 'generations.dart';

class AdviserTutor {
  AdviserTutor({
    required this.id,
    required this.group,
    required this.semestre,
    required this.generation,
    required this.adviser,
    required this.tutor,
    required this.status,
    required this.v,
  });

  String id;
  Adviser group;
  Adviser semestre;
  Generation generation;
  Teachers adviser;
  Teachers tutor;
  bool status;
  int v;

  factory AdviserTutor.fromRawJson(String str) =>
      AdviserTutor.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AdviserTutor.fromJson(Map<String, dynamic> json) => AdviserTutor(
        id: json["_id"],
        group: Adviser.fromJson(json["group"]),
        semestre: Adviser.fromJson(json["semestre"]),
        generation: Generation.fromMap(json["generation"]),
        adviser: Teachers.fromJson(json["adviser"]),
        tutor: Teachers.fromJson(json["tutor"]),
        status: json["status"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "group": group.toJson(),
        "semestre": semestre.toJson(),
        "generation": generation.toJson(),
        "adviser": adviser.toJson(),
        "tutor": tutor.toJson(),
        "status": status,
        "__v": v,
      };
}

class Adviser {
  Adviser({
    required this.name,
    required this.uid,
  });

  String name;
  String uid;

  factory Adviser.fromRawJson(String str) => Adviser.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Adviser.fromJson(Map<String, dynamic> json) => Adviser(
        name: json["name"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "uid": uid,
      };
}
