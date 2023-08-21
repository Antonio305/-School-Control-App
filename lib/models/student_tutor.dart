


import 'dart:convert';

class StudentTutor {
    StudentTutor({
        this.id,
       required this.nameTutor,
       required this.lastNameTutor,
       required this.secondNameTutor,
       required this.kinship,
       required this.numberPhoneTutor,
        this.v,
    });

    String? id;
    String nameTutor;
    String lastNameTutor;
    String secondNameTutor;
    String kinship;
    int numberPhoneTutor;
    int? v;

    factory StudentTutor.fromJson(String str) => StudentTutor.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory StudentTutor.fromMap(Map<String, dynamic> json) => StudentTutor(
        id: json["_id"],
        nameTutor: json["nameTutor"],
        lastNameTutor: json["lastNameTutor"],
        secondNameTutor: json["secondNameTutor"],
        kinship: json["kinship"],
        numberPhoneTutor: json["numberPhoneTutor"],
        v: json["__v"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "nameTutor": nameTutor,
        "lastNameTutor": lastNameTutor,
        "secondNameTutor": secondNameTutor,
        "kinship": kinship,
        "numberPhoneTutor": numberPhoneTutor,
        "__v": v,
    };
}
