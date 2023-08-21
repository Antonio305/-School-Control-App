// To parse this JSON data, do
//
//     final subjects = subjectsFromJson(jsonString);


import 'dart:convert';

class Subjects {
    Subjects({
        required this.name,
        required this.teachers,
        required this.semestre,
        required this.uid,
    });

    String name;
    SubjectTeacher teachers;
    SubjectSemestre semestre;
    String uid;

    factory Subjects.fromRawJson(String str) => Subjects.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Subjects.fromJson(Map<String, dynamic> json) => Subjects(
        name: json["name"],
        teachers: SubjectTeacher.fromJson(json["teachers"]),
        semestre: SubjectSemestre.fromJson(json["semestre"]),
        uid: json["uid"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "teachers": teachers.toJson(),
        "semestre": semestre.toJson(),
        "uid": uid,
    };
}

class SubjectSemestre {
    SubjectSemestre({
        required this.id,
        required this.name,
    });

    String id;
    String name;

    factory SubjectSemestre.fromRawJson(String str) => SubjectSemestre.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory SubjectSemestre.fromJson(Map<String, dynamic> json) => SubjectSemestre(
        id: json["_id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
    };
}

class SubjectTeacher {
    SubjectTeacher({
        required this.id,
        required this.name,
        required this.lastName,
        required this.secondName,
    });

    String id;
    String name;
    String lastName;
    String secondName;

    factory SubjectTeacher.fromRawJson(String str) => SubjectTeacher.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory SubjectTeacher.fromJson(Map<String, dynamic> json) => SubjectTeacher(
        id: json["_id"],
        name: json["name"],
        lastName: json["lastName"],
        secondName: json["secondName"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "lastName": lastName,
        "secondName": secondName,
    };
}
