import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/host.dart';
import '../models/subjects.dart';

class SubjectServices extends ChangeNotifier {
  List<Subjects> subjects = [];

  // base  url la cual es local
  // final String baseUrl = "localhost:8080";
  final String baseUrl = ConnectionHost.baseUrl;

  // funtion para obtener los datos

  final headers = {'content-Type': 'application/json'};

  // contructor de la clase
  // SubjectServices() {
  //   getSubjects();

  // }

  Future getSubjects() async {
    // final url = Uri.http(baseUrl, 'api/matery');
    final url = ConnectionHost.myUrl('api/matery', {});
    final resp = await http.get(url, headers: headers);

//  print(resp.body);

    final List<dynamic> subject = json.decode(resp.body);

    subjects = subject.map((e) => Subjects.fromJson(e)).toList();
    notifyListeners();
    // print(resp.body);

    //  subjects.add(subject);
    // final Map<String, dynamic>  decodeResp = json.decode(resp.body);

    // final subject = Subject.fromMap(decodeResp);

    // if (resp.statusCode == 200) {

    //   print('datos de materia  obtenidos  con exito ');
    // } else {
    //   print('HA SURGIDO UN GRAVE ERROR');
    // }
  }

  //  method for create subjets
  Future createSubject(
      String nameMateria, String teacherID, String semestreID) async {
    // final url = Uri.http(baseUrl, '/api/matery');
    final url = ConnectionHost.myUrl('/api/matery', {});

    Map<String, dynamic> data = {
      "name": nameMateria,
      "teacher": teacherID,
      "semestre": semestreID
    };
    final resp =
        await http.post(url, headers: headers, body: json.encode(data));

    print(resp.body);
    if (resp.hashCode == 200) {
      print('MATERIA CREADO CON EXITO');
    } else {
      print('has hackeado la nasa');
    }
  }

  // mostrar materia por semestre

  Future allSubjectForSemestre(String idSemestre) async {
    // final url = Uri.http(baseUrl, 'api/matery/$idSemestre');
    final url = ConnectionHost.myUrl('api/matery/$idSemestre', {});

    final resp = await http.get(url, headers: headers);

    final List<dynamic> respBody = json.decode(resp.body);

    print(resp.body);
    // ageregamos los datos en la lista
    final subject = respBody.map((value) => Subjects.fromJson(value)).toList();
    subjects = [...subject];
    notifyListeners();

    // retorna una lista d maeria en la cual es por smestre
  }
}
