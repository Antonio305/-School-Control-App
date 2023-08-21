import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'package:sistema_escolar_prepa/models/flutter_secure_storage.dart';
import 'package:sistema_escolar_prepa/models/teacher.dart';

import '../models/host.dart';

class TeachaerServices extends ChangeNotifier {
//   create list tewacher
  List<Teachers> teachers = [];

  // TeachaerServices() {
  //   getTeachers();
  // }

  bool status = false;

  Teachers teacherForID = Teachers(
      name: '',
      lastName: '',
      secondName: '',
      gender: '',
      collegeDegree: '',
      typeContract: '',
      status: true,
      rol: '',
      numberPhone: '',
      email: '',
      tuition: '',
      uid: '');

  //  base  url
  final String baseUrl = ConnectionHost.baseUrl;

// HEADERS
  final headers = {'content-Type': 'application/json'};
  final storage = SecureStorage.storage;

  Future getTeachers() async {
    // final url = Uri.http(baseUrl, '/api/teacher');
    final url = ConnectionHost.myUrl('/api/teacher', {});

    final headers = {'content-Type': 'application/json'};

    final resp = await http.get(url, headers: headers);

    final List<dynamic> respBody = json.decode(resp.body);

    // final respBody = json.decode(resp.body);

    final teacher = respBody.map((e) => Teachers.fromJson(e)).toList();
    teachers = [...teacher];
    notifyListeners();

    // for (var element in respBody) {
    //   final dataTeacher = Teachers.fromMap(element);
    //   teachers.add(dataTeacher);

    // }
    // notifyListeners();

    // return teachers;

    // print("datos teachers lista  $teachers");
    // // notifyListeners();
    // if (resp.statusCode == 200) {
    //   print(resp.body);
    //   print(teachers);
    // } else {
    //   print('algo salio mal');
    // }
  }




  Future getForId(String? token) async {
    // String? token = await storage.read(key: 'token');
    // final url = Uri.http(baseUrl, 'api/teacher/$idTeacher');
    final url =
        ConnectionHost.myUrl('/api/teacher/searchTeachersByToken/DIRECTOR', {});
    print('url para la el  director');
    print(url);
    final headers = {'content-Type': 'application/json', 'x-token': token!};

    final resp = await http.get(url, headers: headers);

    final Map<String, dynamic> respBody = json.decode(resp.body);
    print(respBody);

    teacherForID = Teachers.fromJson(respBody);
    notifyListeners();

    // print(respBody['name']);

    // fianl datos = Teachers(name: name, lastName: lastName, secondName: secondName, gender: gender, collegeDegree: collegeDegree, typeContract: typeContract, status: status, rol: rol, tuition: tuition, password: password, uid: uid)

    // teacherForID = Teachers.fromMap(respBody);
    // return teacherForID;

    // notifyListeners();

    // return teacher;
  }

// create data teacher ( register teachers)

  Future createTeacher(Teachers teacher) async {
    // final url = Uri.http(baseUrl, '/api/teacher');
    final url = ConnectionHost.myUrl('/api/teacher', {});
    status = true;
    notifyListeners();

    final resp = await http.post(
      url,
      headers: headers,
      body: json.encode(teacher.toJson()),
    );

    status = false;
    notifyListeners();

    if (resp.statusCode == 200) {
      final Map<String, dynamic> respBody = json.decode(resp.body);

      print(respBody);
    } else {
      print(resp);
    }
  }
}
