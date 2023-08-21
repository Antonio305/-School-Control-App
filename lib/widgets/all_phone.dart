// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Center(
//           child: ElevatedButton(
//             onPressed: () async {
//               var url = "tel:+1234567890";
//               if (await canLaunch(url)) {
//                 await launch(url);
//               } else {
//                 throw "No se pudo llamar al número $url";
//               }
//             },
//             child: Text("Llamar al número +1234567890"),
//           ),
//         ),
//       ),
//     );
//   }
// }
