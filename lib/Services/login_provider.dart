import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:sistema_escolar_prepa/models/login_response.dart';

import '../models/flutter_secure_storage.dart';
import '../models/host.dart';
import '../models/login.dart';
import '../models/teacher.dart';

late LoginUser userLogin;

class LoginServices extends ChangeNotifier {
  Teachers teacher = Teachers(
      name: '',
      lastName: '',
      secondName: '',
      gender: '',
      collegeDegree: '',
      typeContract: '',
      status: false,
      rol: '',
      numberPhone: '',
      email: '',
      tuition: '',
      uid: '');

  bool isLoading = false;

  // aca vamos guardar el token
  // final storage = const FlutterSecureStorage();
  final storage = SecureStorage.storage;

  // String baseUrl = 'http://192.168.1.70:8080/api/userLogin';

  // String baseUrl = 'http://localhost:8080/api/userLogin';
// contructor
  // LoginServices();
  // final String baseUrl = "localhost:8080";
  final String baseUrl = ConnectionHost.baseUrl;

  // metood para el login

  Future<String?> loginUser(LoginUser login) async {
    isLoading = true;
    notifyListeners();

    final url = ConnectionHost.myUrl('/api/userLogin/DIRECTOR', {});

    final headers = {'Content-Type': 'application/json'};

    print(url);
    final resp = await http.post(url, headers: headers, body: login.toJson());

    // validcion del estado
    final decodeResp = json.decode(resp.body);
    if (resp.statusCode == 200) {
      //  final loginResponse = usersResponseFromJson(resp.body);
      final loginResponse = loginResponseFromJson(resp.body);

      teacher = loginResponse.teacher;
      notifyListeners();
      // add toen is storage
      await storage.write(key: 'token', value: loginResponse.token);

      // return true;
      return null;
    } else {
      // return false;
      return decodeResp['msg'];
    }

    // final Map<String, dynamic> decodeResp = json.decode(resp.body);

    // final decodeResp = json.decode(resp.body);
    // print(decodeResp);

    // if (decodeResp.containsKey('token')) {
    //   // TODO: GUARDAR TOKEN EN UN LUGAR SEGURO

    //   await storage.write(key: 'token', value: decodeResp['token']);

    //   print(decodeResp['token']);
    //   return null; // no retornamos nada si pasa bien
    // } else {
    //   // caso contrario mostramos el mensaje de error
    //   return decodeResp['msg'];
    // }
  }

  // TODO: PARA BUSCAR UN PROCEDOR Y REGRESARLO DATOS,.

  Future getForId(String? token) async {
    // String? token = await storage.read(key: 'token');
    // final url = Uri.http(baseUrl, 'api/teacher/$idTeacher');
    final url =
        ConnectionHost.myUrl('/api/teacher/searchTeachersByToken/DIRECTOR', {});
    print('url para la el  director');
    print(url);
    final headers = {'content-Type': 'application/json', 'x-token': token!};

    final resp = await http.get(url, headers: headers);

    // final Map<String, dynamic> respBody = json.decode(resp.body);
    // print(respBody);

    final loginResponse = loginResponseFromJson(resp.body);

    teacher = loginResponse.teacher;
    notifyListeners();
    // teacherForID = Teachers.fromJson(respBody);
    notifyListeners();
  }

// metod para elimitar lo que esta guardado del storage

  // para la validacion si uno no esta loggeado hacer de nuevo el inicio de sesio

  Future<bool?> isLoggetIn() async {
    String? token = await storage.read(key: 'token');
    // final url = Uri.http(baseUrl, '/api/login/renew');
    final url = ConnectionHost.myUrl('api/userLogin/renew/DIRECTOR', {});

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'x-token': token!
    };

    final resp = await http.get(url, headers: headers);
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      teacher = loginResponse.teacher;
      await _saveToken(loginResponse.token);
      return true;
    } else {
      // Eliminamos le token
      logout();
      return true;
    }
  }

  Future logout() async {
    await storage.delete(key: 'token');
    return;
    // esot no es necesario
  }

// esto nos va a retornar si existe el token
  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }

  static Future<String?> getToken() async {
    const _storage = FlutterSecureStorage();

    String? _token = await _storage.read(key: 'token');

    return _token!;
  }

  Future _saveToken(String token) async {
    return await storage.write(key: 'token', value: token);
  }

  // rfuncio para validadr el token si aun no etra vencido
  Future<bool> validateToken() async {
    // objeccto par el token
    String? token = await storage.read(key: 'token');
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'x-token': token!
    };

    final url = ConnectionHost.myUrl('/api/userLogin/validateToken', {});
    final resp = await http.get(url, headers: headers);

    final respBody = json.decode(resp.body);
    print(respBody);

    if (respBody['valido'] == false) {
      logout();
    }
    return respBody['valido'];
  }
}
