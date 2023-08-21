// import 'dart:io';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../Services/chat/chat_services.dart';
// import '../../Services/chat/socket_servives.dart';
// import '../../Services/chat/user_services.dart';
// import '../../Services/login_provider.dart';
// import 'chat_message.dart';

// class ChatPage extends StatefulWidget {
//   const ChatPage({Key? key}) : super(key: key);


//   @override
//   State<ChatPage> createState() => _ChatPageState();
// }

// class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
//   // para sabert si esta escribiendo
//   bool writing = false;

//   final TextEditingController _textController = TextEditingController();

//   // controlador para el focus nods
//   final _focusNode = new FocusNode();

//   // creo  una lista de chat Message
//   List<ChatMessage> _messages = [];

//   // solo se declara ya se inicializa en el init State
//   ChatServices? chatService;
//   // socker
//   late SocketService socketService;
// // de quie se le envia el mensale

// // TODO PARA LISTA DE USUARIOS
// //todo: control escolar no puede 
//   // UserServices? userService;
//   // hace la instnacia del token
//   LoginServices? authService;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     // aca no podemos redibujar nada, solo si estamos en un callback
//     chatService = Provider.of<ChatServices>(context, listen: false);
//     socketService = Provider.of<SocketService>(context, listen: false);
//     authService = Provider.of<LoginServices>(context, listen: false);

//     // PARA ESCUHAR EL MENAJE DEL EVENTO mensaje-personal

//     socketService.socket.on("mensaje-personal", _escucharMensaje);
//     // socketService.socket.on(
//     //     'mensaje-personal', (data) => print('tengo mensaje de : ${data}'));
//   }

//   // craer un function
//   void _escucharMensaje(dynamic payload) {
//     print('tengo mensaje de : ${payload}');
//     ChatMessage message = ChatMessage(
//       text: payload['message'],
//       uid: payload['de'],
//       animationController: AnimationController(
//           vsync: this, duration: const Duration(milliseconds: 800)),
//     );

//     // Actualizacion de la lista
//     setState(() {
//       _messages.insert(0, message);
//     });

//     // faltaba la animacion jaja
//     message.animationController.forward();
//   }

//   @override
//   Widget build(BuildContext context) {
//     //  = Provider.of<ChatServices>(context);

//     return Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           title: Column(children: [
//             CircleAvatar(
//               backgroundColor: Colors.lightBlueAccent,
//               child: Text(
//                 chatService!.userPara!.name.substring(0, 2),
//                 style: const TextStyle(fontSize: 12),
//               ),
//             ),
//             Text(chatService!.userPara!.name)
//           ]),
//           elevation: 1,
//           leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: const Icon(Icons.exit_to_app),
//           ),
//           // esto cambiar dependido si tnemos coneccion o no
//           actions: [
//             Container(
//               margin: const EdgeInsets.only(right: 10),
//               // falta co cofigurcion si tenemos coneccion o no
//               child: Icon(Icons.check_circle, color: Colors.blue[500]),
//               // Icon(Icons.offline_bolt, color: Colors.red),
//             )
//           ],
//         ),
//         body: Container(
//           child: Column(children: [
//             Flexible(
//               child: ListView.builder(
//                 reverse: true,
//                 physics: const BouncingScrollPhysics(),
//                 itemCount: _messages.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return _messages[index];
//                 },
//               ),
//             ),

//             /// caja de texto
//             Divider(
//               height: 1,
//             ),
//             Container(
//               // color: Colors.red,
//               child: Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 8),
//                 child: Padding(
//                   padding: const EdgeInsets.all(5.0),
//                   child: Row(children: [
//                     // caja de texto
//                     Flexible(
//                       child: TextField(
//                         focusNode: _focusNode,
//                         decoration: const InputDecoration.collapsed(
//                             hintText: 'Enviar mensjae'),
//                         controller: _textController,
//                         // solo agrego la referencia
//                         // onSubmitted: _haldleSubmit,
//                         // TODO: hay que saber cuando esta escribiendo, cuando hay un valor
//                         onChanged: (value) {
//                           setState(() {
//                             if (value.trim().length > 1) {
//                               writing = true;
//                             } else {
//                               writing = false;
//                             }
//                           });
//                         },
//                       ),
//                     ),
//                     // button

//                     Container(
//                       child: Platform.isIOS
//                           ? CupertinoButton(
//                               child: const Text('Send'),
//                               onPressed: writing
//                                   ? () => _haldleSubmit(_textController.text)
//                                   : null,
//                             )
//                           : IconButton(
//                               onPressed: writing
//                                   ? () => _haldleSubmit(_textController.text)
//                                   : null,

//                               icon: const Icon(Icons.send),
//                               // DELETE ANIMATIN OCOLOR
//                               splashColor: Colors.transparent,
//                               highlightColor: Colors.transparent,
//                             ),
//                     ),
//                     // IconButton(onPressed: (){}, icon: )
//                   ]),
//                 ),
//               ),
//             )
//           ]),
//         ));
//   }

//   AppBar _appBar() {
//     return AppBar(
//       centerTitle: true,
//       title: Column(children: const [
//         CircleAvatar(
//           child: Text(
//             'hols',
//             style: TextStyle(fontSize: 12),
//           ),
//           backgroundColor: Colors.lightBlueAccent,
//         ),
//         Text('Dalila')
//       ]),
//       elevation: 1,
//       leading: IconButton(
//         onPressed: () {},
//         icon: const Icon(Icons.exit_to_app),
//       ),
//       // esto cambiar dependido si tnemos coneccion o no
//       actions: [
//         Container(
//           margin: const EdgeInsets.only(right: 10),
//           // falta co cofigurcion si tenemos coneccion o no
//           child: Icon(Icons.check_circle, color: Colors.blue[500]),
//           // Icon(Icons.offline_bolt, color: Colors.red),
//         )
//       ],
//     );
//   }

// // // para escuchar lo quehemos puesto
// //   _haldleSubmit(String text) async {
// //     if (text.trim().isEmpty) return;
// //     print(text);

// //     // este es para ios
// //     // solicitar el foco cuando se enviar los  mensjaes
// //     // en android n oes necesario
// //     _textController.clear();
// //     _focusNode.requestFocus();

// //     final newMessage = ChatMessage(
// //       text: text,
// //       uid: '123',
// //       animationController: AnimationController(
// //           vsync: this, duration: const Duration(milliseconds: 800)),
// //     );
// //     _messages.insert(0, newMessage);

// //     // una vex agergado en la lista inicar la animacin
// //     newMessage.animationController
// //         .forward(); // foward indica que es solo una vez
// //     setState(() {
// //       writing = false;
// //     });

// // // enviamos el mensaje
// //     // nombre del evento mensaje-personal
// //     socketService.emit('mensaje-personal', {
// //       'de': authService!.user.uid,
// //       'para': chatService!.userPara!.uid,
// //       'message': text
// //     });
// //   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     //TODO: OFF DEL SOCKET

//     // LIMIAR LAS INSTANCIA DEL ARREGLO DE ChatMessage
//     //  teminamos las animaciones que se han creado
//     for (ChatMessage message in _messages) {
//       message.animationController.dispose();

//     }
//     socketService.socket.off('mensaje-personal');
//     super.dispose();
//   }
// }
