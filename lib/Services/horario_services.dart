import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;

import '../models/horario.dart';
import '../models/host.dart';

class HorarioServices extends ChangeNotifier {
  // base url
  // final String baseUrl = "localhost:8080";
  final String baseUrl = ConnectionHost.baseUrl;

  final headers = {'Content-Type': 'application/json'};

  // instance class Horario
  List<Horario> horarios = [];

  // method all horarios
  Future allHorarios() async {
    // final url = Uri.http(baseUrl, '/api/horarios');
    final url = ConnectionHost.myUrl('/api/horarios', {});

    final resp = await http.get(url, headers: headers);

    final List<dynamic> respBody = json.decode(resp.body);

    print(respBody);

    horarios = respBody.map((e) => Horario.fromMap(e)).toList();
    notifyListeners();

    //print(horarios);

    // if (resp.hashCode == 200) {
    //   print('Tenemos datos a la vista');
    //   // print(resp.body);
    //   horarios = respBody.map((e) => Horario.fromMap(e)).toList();
    // print(horarios);
    // } else {
    //   print('Rayos la nasa no ha  detectado');
    //   print(resp.body);
    // }
  }

// funcion para craer los hroarios

  Future createHorario(
      String generacion,
      String semestre,
      String group,
      List hours,
      List monday,
      List tuesday,
      wednesday,
      List thursday,
      List friday) async {
    // final url = Uri.http(baseUrl, '/api/horarios');
    final url = ConnectionHost.myUrl('/api/horarios', {});

    // creamos el mapa de datos
    final Map<String, dynamic> data = {
      "schoolYear": generacion,
      "semestre": semestre,
      "group": group,
      "hours": hours,
      "monday": monday,
      "tuesday": tuesday,
      "wednesday": wednesday,
      "thursday": thursday,
      "friday": friday,
    };

    final resp =
        await http.post(url, headers: headers, body: json.encode(data));

    print(resp.body);
    print("LISTA DE DATOS AGREGADOS");
  }
}
