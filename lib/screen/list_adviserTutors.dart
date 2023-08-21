import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_escolar_prepa/Services/generation_services.dart';

import '../Services/adviser_services.dart';
import '../models/adviser_tutor.dart';
import 'package:url_launcher/url_launcher.dart';

import 'dart:io';

class ScreenListAdviser extends StatefulWidget {
  const ScreenListAdviser({Key? key}) : super(key: key);

  @override
  State<ScreenListAdviser> createState() => _ScreenListAdviserState();
}

class _ScreenListAdviserState extends State<ScreenListAdviser> {
  bool _isExpanded = false;

  // Lista para los turos y asesores

  List<AdviserTutor> adviseTutors = [];

  @override
  Widget build(BuildContext context) {
    final adivserTutor =
        Provider.of<AdivserTutorServies>(context, listen: true);
    adviseTutors = adivserTutor.adviserTutors;

// para mosrar la lista de los generacioens
    final generationServices =
        Provider.of<GenerationServices>(context, listen: true);
    final generations = generationServices.generations;
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('BUSCAR POR:!'),
                    content: SizedBox(
                        width: 250,
                        height: 300,
                        child: Center(
                          child: ListView(
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();

                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text('BUSCAR POR:!'),
                                          content: SizedBox(
                                            child: Wrap(
                                              children: List.generate(
                                                  generations.length, (index) {
                                                return TextButton(
                                                    onPressed: () async {
                                                      Navigator.of(context)
                                                          .pop();
                                                      final adivserTutorServies =
                                                          Provider.of<
                                                                  AdivserTutorServies>(
                                                              context,
                                                              listen: false);

                                                      await adivserTutorServies
                                                          .getAdviserTutorsByGeneration(
                                                              generations[index]
                                                                  .uid);
                                                    },
                                                    child: Text(generations[
                                                                index]
                                                            .initialDate
                                                            .toString()
                                                            .substring(0, 10) +
                                                        " - " +
                                                        generations[index]
                                                            .initialDate
                                                            .toString()
                                                            .substring(0, 10)));
                                              }),
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('OK'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: const Text('Generation')),
                              ElevatedButton(
                                  onPressed: () {},
                                  child: const Text('Semestre'))
                            ],
                          ),
                        )),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  );
                },
              );
            },
            label: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text('BUSCAR POR'),
            )),
        appBar: AppBar(
            elevation: 0,
            // backgroundColor: Colors.amber.withOpacity(0.9),
            // backgroundColor: Color.fromRGBO(62, 66, 107, 0.7),
            shadowColor: Colors.red, //color d ela sombre
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            title: const Text('Asesores Y Tutorres')),
        body: Center(
            child: ListView.custom(
          // shrinkWrap: true,
          semanticChildCount: 2,
          childrenDelegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return InformacionCard(
                adviserTutor: adviseTutors[index],
                // tutor: adviseTutors[index].adviser.name,
                // asesor: adviseTutors[index].tutor.name,
                // grupo: adviseTutors[index].group.name,
                // generacion:
                //     adviseTutors[index].generation.finalDate.toString(),
                // semestre: adviseTutors[index].semestre.name
              );
            },
            childCount: adviseTutors.length,
          ),
        )));
  }
}

class InformacionCard extends StatefulWidget {
  final AdviserTutor adviserTutor;
  const InformacionCard({Key? key, required this.adviserTutor})
      : super(key: key);

  @override
  State<InformacionCard> createState() => _InformacionCardState();
}

class _InformacionCardState extends State<InformacionCard> {
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width:
          Platform.isMacOS || Platform.isWindows ? size.width / 3 : size.width,
      child: Card(
        child: Column(
          children: [
            // Datos del asesor
            ListTile(
              title: Text(widget.adviserTutor.tutor.name +
                  "  " +
                  widget.adviserTutor.tutor.lastName),
              subtitle: Text(
                  'Generación: ${widget.adviserTutor.generation.initialDate.toString().substring(0, 10)} |  ${widget.adviserTutor.semestre.name}'),
              leading: const CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage('url_de_la_imagen_del_asesor'),
              ),
            ),
            // Datos del tutor
            ListTile(
              title: Text(widget.adviserTutor.adviser.name +
                  " " +
                  widget.adviserTutor.adviser.lastName),
              subtitle: Text('Grupo: ${widget.adviserTutor.group.name}'),
              leading: const CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage('url_de_la_imagen_del_tutor'),
              ),
            ),
            // Información adicional
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    onTap: () async {
                      if (widget.adviserTutor.tutor.numberPhone == null) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Error!'),
                              content: const Text(
                                  'No noy numero de telefono del profesor'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        // var url = "1234567890";

                        await _makePhoneCall(
                            widget.adviserTutor.tutor.numberPhone!);
                      }
                    },
                    title: const Text('Teléfono del asesor'),
                    subtitle: widget.adviserTutor.tutor.numberPhone == null
                        ? const Text('No esta agregado')
                        : Text(widget.adviserTutor.tutor.numberPhone!),
                    leading: const Icon(Icons.phone),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: Text('Correo del asesor'),
                    subtitle: Text('juan.perez@example.com'),
                    leading: Icon(Icons.email),
                  ),
                ),
              ],
            ),
            // ListTile(
            //   title: Text('Horario del tutor'),
            //   subtitle: Text('Lunes a viernes, de 9:00 a.m. a 1:00 p.m.'),
            //   leading: Icon(Icons.schedule),
            // ),
            // Botones de acción
            // ButtonBar(
            //   children: [
            //     ElevatedButton(
            //       onPressed: () {},
            //       child: Text('Enviar mensaje'),
            //     ),
            //     ElevatedButton(
            //       onPressed: () {},
            //       child: Text('Agendar cita'),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
