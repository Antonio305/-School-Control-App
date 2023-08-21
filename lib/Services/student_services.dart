import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;
import 'package:sistema_escolar_prepa/models/host.dart';

import 'dart:convert';

import '../models/for_student_create.dart';
import '../models/students.dart';

class StudentsServices extends ChangeNotifier {
  final String baseUrl = ConnectionHost.baseUrl;
  final headers = {'content-type': 'application/json'};

  // get students all students
  final storage = const FlutterSecureStorage();

  bool status = false;

  List<Students> students = [];
  Future getStudents() async {
    // final url = Uri.http(baseUrl, '/api/student');
    final url = ConnectionHost.myUrl('/api/student', {});

    final resp = await http.get(url, headers: headers);

    final List<dynamic> respBody = json.decode(resp.body);

    final student = respBody.map((e) => Students.fromMap(e)).toList();
    students = [...student];
    print('studnet');
    notifyListeners();
    //  final dataMap = data["semestre"];

    // for (var element in respBody) {
    //   final datasss = Students.fromMap(element);
    //   students.add(datasss);

    // }
    // print(students);

    //  print(dataMap);
    // print(respBody[1]);
  }

// function for create studnet

  Future registerStudent(Student student) async {
    String? token = await storage.read(key: 'token');

    Map<String, String> headers = {
      'content-type': 'application/json',
      'x-token': token!
    };

    status = true;
    ChangeNotifier();

    // final url = Uri.http(baseUrl, '/api/student');

    final url = ConnectionHost.myUrl('/api/student', {});

    final resp = await http.post(url, headers: headers, body: student.toJson());
    final respBody = json.decode(resp.body);

    print(respBody);

    status = false;
    ChangeNotifier();
  }

  Future updateStudent(Student student ,String id ) async {
    String? token = await storage.read(key: 'token');

    Map<String, String> headers = {
      'content-type': 'application/json',
      'x-token': token!
    };

    status = true;
    ChangeNotifier();

    // final url = Uri.http(baseUrl, '/api/student');

    final url = ConnectionHost.myUrl('/api/student/controlSchool/$id', {});

    final resp = await http.put(url, headers: headers, body: student.toJson());
    final respBody = json.decode(resp.body);

    print(respBody);

    status = false;
    ChangeNotifier();
  }
}
