// Postman Echo is service you can use to test your REST clients and make sample API calls.
// It provides endpoints for `GET`, `POST`, `PUT`, various auth mechanisms and other utility
// endpoints.
//
// The documentation for the endpoints as well as example responses can be found at
// [https://postman-echo.com](https://postman-echo.com/?source=echo-collection-app-onboarding)
// To parse this JSON data, do
//
//     final student = studentFromMap(jsonString);

import 'dart:convert';



class Student {
  Student({
    required this.studentTutor,
    required this.name,
    required this.lastName,
    required this.secondName,
    required this.gender,
    required this.dateOfBirth,
    required this.bloodGrade,
    required this.curp,
    required this.age,
    
    required this.town,
    required this.numberPhone,
    this.email,
    required this.tuition,
    required this.password,
    required this.status,
    required this.rol,
    this.specialtyArea,
    required this.group,
    required this.semestre,
    required this.subjects,
    required this.generation,
  });

  String name;
  String lastName;
  String secondName;
  String gender;
  DateTime dateOfBirth;
  String bloodGrade;
  String curp;
  int age;
  String town;
  int numberPhone;
  String? email;
  String tuition;
  String password;
  bool status;
  String rol;
  StudentTutor studentTutor;
  String? specialtyArea;

  String group;
  List<String> semestre;
  List<String> subjects;
  String generation;

  factory Student.fromJson(String str) => Student.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Student.fromMap(Map<String, dynamic> json) => Student(
      name: json["name"],
      lastName: json["lastName"],
      secondName: json["secondName"],
      gender: json["gender"],
      dateOfBirth: DateTime.parse(json["dateOfBirth"]),
      bloodGrade: json["bloodGrade"],
      curp: json["curp"],
      age: json["age"],
      town: json["town"],
      numberPhone: json["numberPhone"],
      email: json['email'],
      tuition: json["tuition"],
      password: json["password"],
      status: json["status"],
      rol: json["rol"],
      studentTutor: StudentTutor.fromMap(json["student_tutor"]),
      specialtyArea: json['specialtyArea'],
      group: json["group"],
      semestre: List<String>.from(json["semestre"].map((x) => x)),
      subjects: List<String>.from(json["subjects"].map((x) => x)),
      generation: json["generation"]
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "lastName": lastName,
        "secondName": secondName,
        "gender": gender,
        "dateOfBirth": dateOfBirth.toIso8601String(),
        "bloodGrade": bloodGrade,
        "curp": curp,
        "age": age,
        "town": town,
        "numberPhone": numberPhone,
        "email": email,
        "tuition": tuition,
        "password": password,
        "status": status,
        "rol": rol,
        "student_tutor": studentTutor.toMap(),
        "specialtyArea": specialtyArea,
        "group": group,
        "semestre": List<dynamic>.from(semestre.map((x) => x)),
        "subjects": List<dynamic>.from(subjects.map((x) => x)),
        "generation": generation,
      };
}





class StudentTutor {
    StudentTutor({
       required this.nameTutor,
       required this.lastNameTutor,
       required this.secondNameTutor,
       required this.kinship,
       required this.numberPhoneTutor,
    });

    String nameTutor;
    String lastNameTutor;
    String secondNameTutor;
    String kinship;
    int numberPhoneTutor;

    factory StudentTutor.fromJson(String str) => StudentTutor.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory StudentTutor.fromMap(Map<String, dynamic> json) => StudentTutor(
        nameTutor: json["nameTutor"],
        lastNameTutor: json["lastNameTutor"],
        secondNameTutor: json["secondNameTutor"],
        kinship: json["kinship"],
        numberPhoneTutor: json["numberPhoneTutor"],
    );

    Map<String, dynamic> toMap() => {
        "nameTutor": nameTutor,
        "lastNameTutor": lastNameTutor,
        "secondNameTutor": secondNameTutor,
        "kinship": kinship,
        "numberPhoneTutor": numberPhoneTutor,
    };
}
