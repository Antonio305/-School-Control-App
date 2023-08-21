import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {

// controlador par alas animaciones
  
final AnimationController animationController;


// hay que savbe saber diferencia cual es el mio Y la de la otra persona

  final String text; // el  texto que se envia

// si el id es  igual al mio yo envie en  menaje caso contrari ode la otra persona
  final String uid;

  const ChatMessage({Key? key, required this.animationController, required this.text, required this.uid}) : super(key: key);

  // const ChatMessage({super.key, required this.text, required this.uid, required this.animationController});

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        // curved es como queremos que sa, rapido al inicio, rapido al final etc
        // este me gusto bounceInOut
        sizeFactor: CurvedAnimation(parent: animationController, curve: Curves.bounceOut),
        child: Container(
            // color: Colors.red,
            // width: double.infinity,
            child: uid == '123' ? _myMesage() : notMyMessage()),
      ),
    );
  }

// DLE MADO DRECHO
  Widget _myMesage() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.all(8.0),
        decoration: const BoxDecoration(
            color: Color(0xff4d9ef6),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(10),
                topRight: Radius.circular(2),
                topLeft: Radius.circular(10))),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: const TextStyle(fontSize: 15, color: Colors.white60),
          ),
        ),
      ),
    );
  }

  Widget notMyMessage() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: const BoxDecoration(
            color: Color(0xffe4e5e8),
            borderRadius: BorderRadius.only(
              
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(10),
                topRight: Radius.circular(20),
                topLeft: Radius.circular(2))),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Text(text,
              style: const TextStyle(fontSize: 15, color: Colors.black54)),
        ),
      ),
    );
  }
}
