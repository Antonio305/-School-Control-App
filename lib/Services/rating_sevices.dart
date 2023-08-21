import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:sistema_escolar_prepa/models/host.dart';

import '../models/flutter_secure_storage.dart';
import '../models/rating.dart';
import '../models/student_by_grades.dart';

class RatingServices extends ChangeNotifier {
  // creaer un varialba de tipo bool para verficar el estaso de la consulta
  bool status = false;

// intancia de la url

//  para obtener todas las califcaciones
  List<Ratings> ratings = [];

  List<StudentByGrades> studentByRating = [];

// instancia de la clase
  Ratings rating = Ratings(
      id: '',
      group: '',
      student: '',
      semestre: '',
      subject: '',
      parcial1: 0.0,
      parcial2: 0.0,
      parcial3: 0.0,
      semesterGrade: 0.0,
      v: 0);
// CRUD

  // INSTANCIA DEL STORAGE PARA OBBTENER ELE TOKEN GUARDADO EN LA BASE DE DATOS
  final storage = SecureStorage.storage;

//Todas las calificaciones
  Future getRatings() async {
    // create url

    // final url = Uri.http(baseUrl, '/api/rating');
    final url = ConnectionHost.myUrl('/api/rating', {});

    final resp = await http.get(url);

    // dcodificacion del string
    final List<dynamic> respBody = json.decode(resp.body);

    // studentByRating = respBody.map((e) => StudentByGrades.fromJson(e)).toList();
    // print(respBody);
  }

// calificacion por materia
  Future<Map<String, dynamic>> getRatingsForSubject(
      String idStudent, String idSubject) async {
/**
 * paramtros : ID STUDENT- ID SUBJECT
 */

    // final url = Uri.http(baseUrl, '/api/rating/$idStudent/$idSubject/rating');
    final url =
        ConnectionHost.myUrl('/api/rating/$idStudent/$idSubject/rating', {});

    print(url);
    final resp = await http.get(url);

    // dcodificacion del string
    final Map<String, dynamic> respBody = json.decode(resp.body);

    //  print(respBody.containsKey('msg' )); indica un true

    // if (respBody.containsKey('msg')) {

    //   print('NO HAY calificaciones ');
    //   // podemos ejecutar una funcio para mostar de que no hay datos como con un dialog
    //   return null;
    // }
    // print(respBody);
    // rating = Ratings.fromMap(respBody);

    return respBody;
  }

  // metodo para ingredaingres5ar las calificaciones
  Future postRating(Ratings rating) async {
    // paramtros
    // group,
    // subject,
    // student,
    // calificacio puede ser opcionales
    // calificaciones - parcial1, parcial2, parcial3
    final Map<String, String> headers = {'Content-Type': 'application/json'};
    // final url = Uri.http(baseUrl, '/api/rating');
    final url = ConnectionHost.myUrl('/api/rating', {});

    final resp = await http.post(url,
        headers: headers, body: json.encode(rating.toMap()));

    final respBOdy = json.decode(resp.body);
    print(respBOdy);
  }

// upadate rating
  Future updateRating(String idRating, Ratings rating) async {
    final Map<String, String> headers = {'Content-Type': 'application/json'};
    // final url = Uri.http(baseUrl, '/api/rating/teacher/idRating/rating');
    final url = ConnectionHost.myUrl('/api/rating/teacher/idRating/rating', {});

    final resp = await http.put(url,
        headers: headers, body: json.encode(rating.toMap()));

    print(resp.body);
  }

  // CREATET FUNCTION FOR GET STUDENT BY RATINGS
  // GET STUDENT BY RATINGS

// MEJROES CALIFICACIONES
  void getStudentByBetterGrades(String idGroup, String idSubject,
      String partial, List<String> generations) async {
    String? token = await storage.read(key: 'token');
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      "x-token": token!
    };

    /// add status
    status = true;
    notifyListeners();

    // final url = Uri.http(baseUrl,
    //     '/api/rating/teacher/$idGroup/$idSubject/$partial/betterGrades');
    final url = ConnectionHost.myUrl(
        '/api/rating/teacher/$idGroup/$idSubject/$partial/$generations/betterGrades',
        {});

    final resp = await http.get(url, headers: headers);

    final List<dynamic> respBody = json.decode(resp.body);
    print(respBody);
    final studentRating =
        respBody.map((e) => StudentByGrades.fromJson(e)).toList();

    studentByRating = [...studentRating];

    status = false;
    notifyListeners();
  }

// CALIFICACIONES  REGULARES
  void getStudentByAverageGrades(
      String idGroup, String idSubject, String partial, List<String> generations) async {
    String? token = await storage.read(key: 'token');
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      "x-token": token!
    };

    // final url = Uri.http(baseUrl,
    //     '/api/rating/teacher/$idGroup/$idSubject/$partial/averageGrades');
    final url = ConnectionHost.myUrl(
        '/api/rating/teacher/$idGroup/$idSubject/$partial/$generations/averageGrades', {});

    final resp = await http.get(url, headers: headers);
    // creamos un lista para mostar los datos
    // la cuales es una lsita de los alumnos

    // final respBody = json.decode(resp.body);
    final List<dynamic> respBody = json.decode(resp.body);
    final studentRating =
        respBody.map((e) => StudentByGrades.fromJson(e)).toList();

    studentByRating = [...studentRating];
    notifyListeners();
    print(respBody);
  }

  //V CALIFICACIONES REPROBATORIOS
  void getStudentByFailingGrades(
      String idGroup, String idSubject, String partial , List<String> generations) async {
    String? token = await storage.read(key: 'token');
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      "x-token": token!
    };

    // final url = Uri.http(baseUrl,
    //     '/api/rating/teacher/$idGroup/$idSubject/$partial/failingGrades');
    final url = ConnectionHost.myUrl(
        '/api/rating/teacher/$idGroup/$idSubject/$partial/$generations/failingGrades', {});

    final resp = await http.get(url, headers: headers);

    final List<dynamic> respBody = json.decode(resp.body);
    final studentRating =
        respBody.map((e) => StudentByGrades.fromJson(e)).toList();

    studentByRating = [...studentRating];
    notifyListeners();
    print(respBody);
  }
}
