class ConnectionHost {
// para las coneccion de la ip
  static String baseUrl = '192.168.1.66:3000';
  // static String baseUrl = '192.168.1.67:3000';
  // static String  baseUrl= 'localhost:3000';
  // }GHSIOT

  // Cuando sea local se hace el retorno de tipo de dato Uri

  //
  static Uri myUrl(String path, Map<String, dynamic>? query) {
    Uri url = Uri.http(baseUrl, path);
    // final url = Uri.https('prepabochil.fly.dev', path);

    return url;
  }
}
