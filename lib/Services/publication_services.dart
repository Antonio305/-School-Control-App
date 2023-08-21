import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:sistema_escolar_prepa/models/host.dart';
import 'package:http/http.dart' as http;
import 'package:sistema_escolar_prepa/models/publication.dart';
import 'package:sistema_escolar_prepa/shared_preferences.dart/shared_preferences.dart';

import '../models/flutter_secure_storage.dart';

class PublicationServices extends ChangeNotifier {
  //  url
  String baseUrl = ConnectionHost.baseUrl;

  Map<String, String> headers = {'Content-Type': 'application/json'};

  List<Publication> publication = [];

  // instance storage
  final storage = SecureStorage.storage;

// metodos
  // all publication

  Future allPublication() async {
    // final url = Uri.http(baseUrl, '/api/publication');
    final url = ConnectionHost.myUrl('/api/publication', {});

    final resp = await http.get(url, headers: headers);

    final List<dynamic> respBody = json.decode(resp.body);

    final _publication = respBody.map((e) => Publication.fromMap(e)).toList();
    publication = [..._publication];
    notifyListeners();
    print(respBody);
  }

  // create publicatio
  Future<String> createPublication(String title, String description) async {
    // final url = Uri.http(baseUrl, '/api/publication');
    final url = ConnectionHost.myUrl('/api/publication', {});
    String? token = await storage.read(key: 'token');

    final resp = await http.post(url,
        headers: {'Content-Type': 'application/json', 'x-token': token!},
        body: json.encode({"title": title, "description": description}));

    final respBody = json.decode(resp.body);

    print(respBody);

    return respBody['_id'];
  }

  // update publication
  Future updateaPublication(Publication publication) async {
    // final url = Uri.http(baseUrl, '/api/publication/${publication.id}');
    final url = ConnectionHost.myUrl('/api/publication/${publication.id}', {});
    String? token = await storage.read(key: 'token');

    final resp = await http.put(url,
        headers: {'Content-Type': 'application/json', 'x-token': token!},
        body: publication.toJson());

    final respBody = json.decode(resp.body);
    print(respBody);
  }
}
