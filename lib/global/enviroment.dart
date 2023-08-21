import 'dart:io';

class Enviroment {
  /// solo va a tener metodo estaticos

  /// para io y android responde de diferente mane en la cual de crar una  condicion par acada plataforma
  ///
  static String apiUrl = Platform.isAndroid
      ? 'http://192.168.1.75:3000'
      : 'http://192.168.1.75:3000';
   static String checkUrlSocket =
      Platform.isAndroid ? 'http://192.168.1.75:3000' : 'http://192.168.1.75:3000';
}
