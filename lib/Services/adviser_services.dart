import 'package:flutter/material.dart';
import 'package:sistema_escolar_prepa/models/adviser_tutor.dart';
import '../models/host.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class AdivserTutorServies extends ChangeNotifier {
  // baser Url
  String baseUrl = ConnectionHost.baseUrl;

  Map<String, String> headers = {'Content-Type': 'application/json'};

// craete adviser tutor "group":"63f95ec1723de0c9e3bdf3ae",

  List<AdviserTutor> adviserTutors = [];

  // to verify the status // para verficar el estado
  bool status = false;

  Future createAdviserTutor(String group, String semestre, String generation,
      String adviser, String tutor) async {
    status = true;
    notifyListeners();

    // final url = Uri.http(baseUrl, '/api/adviserTutor');
    final url = ConnectionHost.myUrl('/api/adviserTutor', {});

    final data = {
      "group": group,
      "semestre": semestre,
      "generation": generation,
      "adviser": adviser,
      "tutor": tutor
    };

    final resp =
        await http.post(url, body: json.encode(data), headers: headers);

    // List<dynamic> respBody = json.decode(resp.body);

    // final adviserT = respBody.map((e) => AdviserTutor.fromJson(e)).toList();
    // adviserTutors = [...adviserT];
    // notifyListeners();
    // // final respBody = json.decode(resp.body);

    print(resp.body);
    status = false;
    notifyListeners();
  }

  Future getAdviserTutor() async {
    // final url = Uri.http(baseUrl, '/api/adviserTutor');

    final url = ConnectionHost.myUrl('/api/adviserTutor', {});

    final resp = await http.get(url, headers: headers);

    List<dynamic> respBody = json.decode(resp.body);

    final adviserT = respBody.map((e) => AdviserTutor.fromJson(e)).toList();
    adviserTutors = [...adviserT];
    notifyListeners();
    print(respBody);
  }



  Future getAdviserTutorsByGeneration(String generation) async {
    // final url = Uri.http(baseUrl, '/api/adviserTutor');

    final url = ConnectionHost.myUrl('/api/adviserTutor/$generation/controlSchool', {});

    final resp = await http.get(url, headers: headers);

    List<dynamic> respBody = json.decode(resp.body);

    final adviserT = respBody.map((e) => AdviserTutor.fromJson(e)).toList();
    adviserTutors = [...adviserT];
    notifyListeners();
    print(respBody);
  }
}
