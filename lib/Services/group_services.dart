
import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'package:sistema_escolar_prepa/models/host.dart';

import '../models/group.dart';


class GroupServices extends ChangeNotifier {
  // mapa param mostar los datos por id
  // Map<String, dynamic> group = {};

  // List<Groups> groups = [];

// instancia de la clase group
  Groups group = Groups(groups: [], msg: '');

// Basis for url

  // final String baseUrl = 'localhost:8080';

  // FUNCTION  TO GET  THE DATA

  final headers = {'content-type': 'application/json'};

  Future allGroup() async {
     // final url = Uri.http(baseUrl, '/api/group/groupForTeacher');
    final url = ConnectionHost.myUrl('/api/group/groupForTeacher', {});

    print(url);
    final resp = await http.get(url, headers: headers);

    // print(resp.body);
    final Map<String, dynamic> respBody = json.decode(resp.body);
    // notifyListeners();

    group = Groups.fromMap(respBody);
    notifyListeners();
    // final List<dynamic> data = groupsForId['students'];
    // print("datos" + data[0]);
  }

// function para crear los datos

  Future getGroupForId() async {

    // final url = Uri.http(baseUrl, '/api/group/groupForTeacher');
    final url = ConnectionHost.myUrl('/api/group/groupForTeacher', {});

    print(url);
    final resp = await http.get(url, headers: headers);

    // print(resp.body);
    final Map<String, dynamic> respBody = json.decode(resp.body);
    // notifyListeners();

    group = Groups.fromMap(respBody);
    notifyListeners();
    // final List<dynamic> data = groupsForId['students'];
    // print("datos" + data[0]);
  }

  // Obtener en las materia que da clase la maestre
}
