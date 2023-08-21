import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sistema_escolar_prepa/models/host.dart';

import 'package:http/http.dart' as http;

import '../models/flutter_secure_storage.dart';
import '../models/tuition.dart';

class TuitionServices extends ChangeNotifier {
// para saber el estatus de esto
  bool status = false;

// conecion al servicor
  final String baseUrl = ConnectionHost.baseUrl;

  // para el secure stoirage
  final storage = SecureStorage.storage;

  final Map<String, String> headers = {'Content-Type': 'application/json'};

  // crate List tpe Tuition
  List<Tuitions> tuitions = [];
  // create object Tuition
  Tuitions tuition = Tuitions(
      tuition: '',
      createdAt: null,
      id: '',
      status: false,
      user: User(name: '', lastName: '', secondName: '', uid: ''));

// get all tuition

  Future getAllTuition() async {
    // final url = Uri.http(baseUrl, '/api/tuition');
    final url = ConnectionHost.myUrl('/api/tuition', {});
    final resp = await http.get(url, headers: headers);
    final List<dynamic> respBody = json.decode(resp.body);

    // tuitions = respBody.map((e) => Tuitions.fromMap(e)).toList();
    tuitions = respBody.map((e) => Tuitions.fromJson(e)).toList();
    notifyListeners();

    print(respBody);
  }

// get all for tuition
  Future getTuitionName(String myTuition) async {
    status = false;
    // final url = Uri.http(baseUrl, '/api/tuition/${myTuition}');
    final url = ConnectionHost.myUrl('/api/tuition/${myTuition}', {});

    final resp = await http.get(url, headers: headers);
    // final Map<String, dynamic> respBody = json.decode(resp.body);

    // if(resp.statusCode != 200 && resp.statusCode != 201   ){
    //         print('No hay datos de la matricula');

    //         return null;
    // }
    final respBody = json.decode(resp.body);
    print(respBody);

    // if (respBody.containsKey('msg')) {
    //   // tuition = Tuitions(tuition: respBody['msg']);
    //   print(respBody);

    //   notifyListeners();
    //   return null;
    // }

    // status = true;
    // tuition = tuition.
    // notifyListeners();
    // return respBody;

    // print(respBody);

    // // tuition = Tuition.fromMap(respBody);
    // notifyListeners();
    // print(tuition.tuition);
  }

  // for add matriucla
  Future creatTuition(String tuition) async {
    String? token = await storage.read(key: 'token');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'x-token': token!
    };

    Map<String, dynamic> data = {'tuition': tuition};

status = true; 
notifyListeners();
    final url = ConnectionHost.myUrl('/api/tuition', {});
    final resp =
        await http.post(url, headers: headers, body: json.encode(data));

    final respBody = json.decode(resp.body);
    print(respBody);
    status = false; 
notifyListeners();

  }
}
