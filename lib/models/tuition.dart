// To parse this JSON data, do
//
//     final tuitions = tuitionsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Tuitions> tuitionsFromJson(String str) => List<Tuitions>.from(json.decode(str).map((x) => Tuitions.fromJson(x)));

String tuitionsToJson(List<Tuitions> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Tuitions {
    String id;
    String tuition;
    bool status;
    User user;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    Tuitions({
        required this.id,
        required this.tuition,
        required this.status,
        required this.user,
         this.createdAt,
         this.updatedAt,
         this.v,
    });

    Tuitions copyWith({
        String? id,
        String? tuition,
        bool? status,
        User? user,
        DateTime? createdAt,
        DateTime? updatedAt,
        int? v,
    }) => 
        Tuitions(
            id: id ?? this.id,
            tuition: tuition ?? this.tuition,
            status: status ?? this.status,
            user: user ?? this.user,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            v: v ?? this.v,
        );

    factory Tuitions.fromJson(Map<String, dynamic> json) => Tuitions(
        id: json["_id"],
        tuition: json["tuition"],
        status: json["status"],
        user: User.fromJson(json["user"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "tuition": tuition,
        "status": status,
        "user": user.toJson(),
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
    };
}

class User {
    String name;
    String lastName;
    String secondName;
    String uid;

    User({
        required this.name,
        required this.lastName,
        required this.secondName,
        required this.uid,
    });

    User copyWith({
        String? name,
        String? lastName,
        String? secondName,
        String? uid,
    }) => 
        User(
            name: name ?? this.name,
            lastName: lastName ?? this.lastName,
            secondName: secondName ?? this.secondName,
            uid: uid ?? this.uid,
        );

    factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        lastName: json["lastName"],
        secondName: json["secondName"],
        uid: json["uid"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "lastName": lastName,
        "secondName": secondName,
        "uid": uid,
    };
}
