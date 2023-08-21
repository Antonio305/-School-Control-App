// ignore_for_file: prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:provider/provider.dart';
import 'package:sistema_escolar_prepa/Services/adviser_services.dart';

class ScreenAdviserTutor extends StatelessWidget {
  const ScreenAdviserTutor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Asesores y Tutores'),
        // esto es para center el
        centerTitle: true,
      ),
      body: Center(
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: SingleChildScrollView(
        child: Wrap(
            // dragStartBehavior: DragStartBehavior.start,
            // reverse: true,
            // scrollDirection: Platform.isAndroid || Platform.isIOS
            //     ? Axis.vertical
            //     : Axis.horizontal,
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Card(
                margin: const EdgeInsets.all(10),
                semanticContainer: true,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: Platform.isWindows || Platform.isMacOS ? 115 : 140,
                    width: Platform.isWindows || Platform.isMacOS ? 260 : 320,
                    // : size.width * 0.9,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: 180,
                              child: Text(
                                'Crear                  Asesores, Tutores',
                                style: TextStyle(fontSize: 20),
                              )),
                          SizedBox(height: 10),
                          Text('Asesor o tutor, son profesores',
                              style: TextStyle(fontSize: 10)),
                          Align(
                              alignment: Alignment.bottomRight,
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, 'create_adviser');
                                  },
                                  child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 15),
                                      child: Text('NUEVO')))),
                        ]),
                  ),
                ),
              ),
              Card(
                margin: const EdgeInsets.all(10),
                semanticContainer: true,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: Platform.isWindows || Platform.isMacOS ? 130 : 140,
                    width: Platform.isWindows || Platform.isMacOS ? 260 : 320,
                    // : size.width * 0.9,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: 180,
                              child: Text(
                                'Lista                  Asesores, Tutores',
                                style: TextStyle(fontSize: 20),
                              )),
                          SizedBox(height: 10),
                          Text('Lista     Tutores Asesores',
                              style: TextStyle(fontSize: 10)),
                          Align(
                              alignment: Alignment.bottomRight,
                              child: ElevatedButton(
                                  onPressed: () {
                                    // haremos una prube de la consula de los datos de lal ita de los asesores
                                    final adivserTutor =
                                        Provider.of<AdivserTutorServies>(context,
                                            listen: false);
                                    adivserTutor.getAdviserTutor();

                                    Navigator.pushNamed(context, 'list_adviser');
                                  },
                                  child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 15),
                                      child: Text('VER LISTA')))),
                        ]),
                  ),
                ),
              ),
              Card(
                margin: const EdgeInsets.all(10),
                semanticContainer: true,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height:
                        Platform.isWindows || Platform.isMacOS ? 115 : 135,
                    width:
                        Platform.isWindows || Platform.isMacOS ? 260 : 280,
                    // : size.width * 0.9,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: 180,
                              child: Text(
                                '  Asesores, Tutores Pasadas',
                                style: TextStyle(fontSize: 20),
                              )),
                          SizedBox(height: 10),
                          Text('Asesor o tutor, son profesores',
                              style: TextStyle(fontSize: 10)),
                          Align(
                              alignment: Alignment.bottomRight,
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, 'create_adviser');
                                  },
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Text('NUEVO')))),
                        ]),
                  ),
                ),
              ),
              Card(
                margin: const EdgeInsets.all(10),
                semanticContainer: true,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height:
                        Platform.isWindows || Platform.isMacOS ? 115 : 135,
                    width:
                        Platform.isWindows || Platform.isMacOS ? 260 : 280,
                    // : size.width * 0.9,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: 180,
                              child: Text(
                                'Buscar                  Asesores, Tutores',
                                style: TextStyle(fontSize: 20),
                              )),
                          SizedBox(height: 10),
                          Text('Asesor o tutor, son profesores',
                              style: TextStyle(fontSize: 10)),
                          Align(
                              alignment: Alignment.bottomRight,
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, 'create_adviser');
                                  },
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Text('NUEVO')))),
                        ]),
                  ),
                ),
              )
            ],
        ),
      ),
          )),
    );
  }
}
