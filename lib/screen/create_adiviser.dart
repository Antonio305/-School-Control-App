import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_escolar_prepa/Services/adviser_services.dart';
import 'package:sistema_escolar_prepa/widgets/profesor_view.dart';

import '../Services/Services.dart';
import '../models/teacher.dart';

import 'dart:io';

class ScreenCreateAdviser extends StatefulWidget {
  const ScreenCreateAdviser({Key? key}) : super(key: key);

  @override
  State<ScreenCreateAdviser> createState() => _ScreenCreateAdviserState();
}

class _ScreenCreateAdviserState extends State<ScreenCreateAdviser> {
  String? idGroup;
  String? idSemestre;
  String? idGeneration;

  Teachers? idTeacherAdviser;
  Teachers? idTeacherTutor;

// Crear un método que muestre el cuadro de diálogo de alerta
  void showTeacherAviser(BuildContext context) {
    // Utilizar el widget AlertDialog para crear el cuadro de diálogo
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final teacherServices =
            Provider.of<TeachaerServices>(context, listen: false);
        final teachers = teacherServices.teachers;
        final size = MediaQuery.of(context).size;

        return AlertDialog(
          insetPadding: Platform.isWindows || Platform.isMacOS
              ? const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0)
              : const EdgeInsets.symmetric(horizontal: 10, vertical: 24.0),
          title: const Text("LISTA DE PROFESORES"),
          // Configurar el mensaje del cuadro de diálogo
          content: SizedBox(
            width: Platform.isWindows || Platform.isMacOS
                ? size.width / 0.5
                : size.width,
            height: Platform.isWindows || Platform.isMacOS
                ? size.height / 1.5
                : size.height * 0.9,
            child: SingleChildScrollView(
              child: Wrap(
                children: List.generate(
                    teachers.length,
                    (index) =>
                        //  ProfesorView(
                        //       nombre: 'Juan Pérez',
                        //       titulo: 'Licenciado en Educación',
                        //       puesto: 'Profesor de Matemáticas',
                        //       imageUrl:
                        //           'https://s2.glbimg.com/maiexaSFWrw7kya-Y7ISKicqgs0=/e.glbimg.com/og/ed/f/original/2015/11/23/albert_einstein_head.jpg',
                        //     )
                        Card(
                          child: MaterialButton(
                            onPressed: () {
                              setState(() {
                                idTeacherAdviser = teachers[index];
                              });
                              Navigator.pop(context);
                            },
                            child: SizedBox(
                              width: Platform.isWindows || Platform.isMacOS
                                  ? 200
                                  : size.width,
                              child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Column(children: [
                                  ListTile(
                                    title: Text(teachers[index].name +
                                        " " +
                                        teachers[index].lastName),
                                    subtitle:
                                        Text(teachers[index].collegeDegree),
                                    //  leading: Icon(Icons.email),
                                    leading: SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: Image.asset(
                                          'asset/teacher_women.png'),
                                    ),
                                    trailing: Icon(Icons.arrow_right),
                                  ),
                                  const SizedBox(height: 4),
                                  Container(
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 96, 58, 131),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        // ignore: prefer_const_constructors
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 2),
                                        child: Text(teachers[index].rol),
                                      )),
                                ]),
                              ),
                            ),
                          ),
                        )),
              ),
            ),
          ),
          // ),
          // Configurar los botones de acción del cuadro de diálogo
          actions: [
            // Botón "Cancelar"
            TextButton(
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Center(child: Text("Cancelar")),
              ),
              onPressed: () {
                // Cerrar el cuadro de diálogo
                Navigator.of(context).pop();
              },
            ),
            // Botón "Aceptar"
          ],
        );
      },
    );
  }

  void showTeacherTutor(BuildContext context) {
    // Utilizar el widget AlertDialog para crear el cuadro de diálogo
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final teacherServices =
            Provider.of<TeachaerServices>(context, listen: false);
        final teachers = teacherServices.teachers;
        final size = MediaQuery.of(context).size;
        return AlertDialog(
          insetPadding: Platform.isWindows || Platform.isMacOS
              ? const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0)
              : const EdgeInsets.symmetric(horizontal: 10, vertical: 24.0),

          title: Text("LISTA DE PROFESORES"),
          // Configurar el mensaje del cuadro de diálogo
          content: SizedBox(
            width: size.width / 0.5,
            height: size.height / 1.5,
            child: SingleChildScrollView(
              child: Wrap(
                children: List.generate(
                    teachers.length,
                    (index) => Card(
                          child: MaterialButton(
                            onPressed: () {
                              setState(() {
                                idTeacherTutor = teachers[index];
                              });
                              Navigator.pop(context);
                            },
                            child: SizedBox(
                              width: Platform.isWindows || Platform.isMacOS
                                  ? 300
                                  : size.width,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(children: [
                                  SizedBox(
                                    height: 50,
                                    width: 50,
                                    child:
                                        Image.asset('asset/teacher_women.png'),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(teachers[index].name),
                                  const SizedBox(height: 5),
                                  Text(teachers[index].collegeDegree),
                                  const SizedBox(height: 4),
                                  Container(
                                      decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 96, 58, 131),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        // ignore: prefer_const_constructors
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 2),
                                        child: Text(teachers[index].rol),
                                      )),
                                ]),
                              ),
                            ),
                          ),
                        )),
              ),
            ),
          ),
          // Configurar los botones de acción del cuadro de diálogo
          actions: [
            // Botón "Cancelar"
            TextButton(
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Text("Cancelar"),
              ),
              onPressed: () {
                // Cerrar el cuadro de diálogo
                Navigator.of(context).pop();
              },
            ),
            // Botón "Aceptar"
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final groupServices = Provider.of<GroupServices>(context, listen: false);
    final semestreServices =
        Provider.of<SemestreServices>(context, listen: false);
    final generationServices =
        Provider.of<GenerationServices>(context, listen: false);

    final semestre = semestreServices.semestres;
    final group = groupServices.group;

    final generation = generationServices.generations;
    final size = MediaQuery.of(context).size;

    final adviserServices =
        Provider.of<AdivserTutorServies>(context, listen: false);
    return Scaffold(
      appBar:
          AppBar(centerTitle: true, title: const Text('Crear Tutor y Asesor')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              if (constraints.maxWidth > 600) {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('PROFESORES'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              showTeacherAviser(context);
                            },
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(children: [
                                  SizedBox(
                                    height: 60,
                                    width: 60,
                                    child: Image.asset('asset/teacher.png'),
                                  ),
                                  const Text('SELECIONAR ASESOR')
                                ]),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                          GestureDetector(
                            onTap: () {
                              showTeacherTutor(context);
                            },
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(children: [
                                  SizedBox(
                                    height: 60,
                                    width: 60,
                                    child: Image.asset('asset/teacher.png'),
                                  ),
                                  const Text('SELECCIONA TUTOR')
                                ]),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  const Text('Grupo'),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  DropdownButton(
                                      // value: group.first.name,
                                      value: group.groups.first.name,
                                      // value: dropMenuProvider.dropdownMenuItemGroup,
                                      items: List.generate(group.groups.length,
                                          (index) {
                                        return DropdownMenuItem<String>(
                                            onTap: () {
                                              idGroup = group.groups[index].uid;
                                            },
                                            value: group.groups[index].name,
                                            child:
                                                Text(group.groups[index].name));
                                      }),
                                      onChanged: (String? value) {
                                        // dropMenuProvider.dropdownMenuItemGroup = value!;
                                      }),
                                ],
                              ),
                              const SizedBox(
                                width: 50,
                              ),
                              Row(
                                children: [
                                  const Text('Semestre'),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  DropdownButton<String>(
                                      value: semestre.first.name,
                                      // value: dropMenuProvider.dropdownMenuItemSemestre,
                                      items: List.generate(
                                          semestre.length,
                                          (index) => DropdownMenuItem<String>(
                                              onTap: () {
                                                idSemestre =
                                                    semestre[index].uid;

                                                // dropMenuProvider.dropdownMenuItemSemestre =
                                                //     semestre[index].uid;
                                                // student.semestre.add(semestre[index].uid);
                                              },
                                              value: semestre[index].name,
                                              child:
                                                  Text(semestre[index].name))),
                                      onChanged: (String? value) {
                                        // dropMenuProvider.dropdownMenuItemSemestre = value!;
                                      }),
                                ],
                              ),
                              const SizedBox(
                                width: 50,
                              ),
                              Row(
                                children: [
                                  const Text('Generacion'),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  DropdownButton<String>(
                                      value: generation.first.initialDate
                                          .toString(),

                                      // value: dropMenuProvider.dropDownMenuItemGeneracion,
                                      items: List.generate(
                                          generation.length,
                                          (index) => DropdownMenuItem(
                                              onTap: () {
                                                idGeneration =
                                                    generation[index].uid;
                                                // dropMenuProvider
                                                //         .dropDownMenuItemGeneracion =
                                                //     generation[index].uid;
                                                // student.generation = generation[index].uid;
                                              },
                                              value: generation[index]
                                                  .initialDate
                                                  .toString(),
                                              child: Text(
                                                  '${generation[index].initialDate.year} - ${generation[index].finalDate.year}'))),
                                      onChanged: (String? value) {
                                        // dropMenuProvider.dropDownMenuItemGeneracion =
                                        value!;
                                      }),
                                ],
                              )
                            ]),
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            if (idGroup == null ||
                                idSemestre == null ||
                                idGeneration == null ||
                                idTeacherAdviser == null ||
                                idTeacherTutor == null) {
                              // print(' Tienes que seleccionar primero pendejo ');

                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Asesor o Tutor"),
                                    content: const Text(
                                        "Verifica si seleccionaste: GRUPO, SEMESTRE, GENERACION"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          // Do something when the user presses the button
                                          Navigator.pop(context);
                                        },
                                        child: const Text("ACEPTAR"),
                                      ),
                                    ],
                                  );
                                },
                              );

                              return null;
                            } else {
                              // showDialog(
                              //   context: context,
                              //   builder: (BuildContext context) {
                              //     return AlertDialog(
                              //       title: const Text("Confirmar Datos"),
                              //       content: SizedBox(
                              //         height: size.height / 2,
                              //         child: Column(children: [
                              //           Text('sdfsdfsd'),
                              //           Text('sdfsdfsd'),
                              //           Text('sdfsdfsd'),
                              //         ]),
                              //       ),
                              //       actions: [
                              //         TextButton(
                              //             onPressed: () {
                              //               // Do something when the user presses the button
                              //               Navigator.pop(context);
                              //             },
                              //             child: adviserServices.status == false
                              //                 ? const Text("ACEPTAR")
                              //                 : const CircularProgressIndicator(
                              //                     semanticsLabel: "Creando",
                              //                   )),
                              //       ],
                              //     );
                              //   },
                              // );

                              final adviserTutorServices =
                                  Provider.of<AdivserTutorServies>(context,
                                      listen: false);
                              await adviserTutorServices.createAdviserTutor(
                                  idGroup!,
                                  idSemestre!,
                                  idGeneration!,
                                  idTeacherAdviser!.uid,
                                  idTeacherTutor!.uid);
                            }
                          },
                          child: const Text('CREAR TUTOR O ASESOR')),
                    ],
                  ),
                );
              }

              // para los moviles
              //
              else {
                return Center(
                  child: SingleChildScrollView(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              showTeacherAviser(context);
                            },
                            child: SizedBox(
                              // height: 100,
                              width: 350,
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(children: [
                                    SizedBox(
                                      height: 100,
                                      width: 100,
                                      child: Image.asset('asset/teacher.png'),
                                    ),
                                    const Text('SELECIONAR ASESOR')
                                  ]),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                          GestureDetector(
                            onTap: () {
                              showTeacherTutor(context);
                            },
                            child: SizedBox(
                              // width: 350,
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(children: [
                                    SizedBox(
                                      height: 100,
                                      width: 350,
                                      child: Image.asset('asset/teacher.png'),
                                    ),
                                    const Text('SELECCIONA TUTOR')
                                  ]),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Grupo'),
                              const SizedBox(
                                width: 50,
                              ),
                              DropdownButton(
                                  value: group.groups.first.name,
                                  // value: dropMenuProvider.dropdownMenuItemGroup,
                                  items: List.generate(group.groups.length,
                                      (index) {
                                    return DropdownMenuItem<String>(
                                        onTap: () {
                                          idGroup = group.groups[index].uid;
                                        },
                                        value: group.groups[index].name,
                                        child: Text(group.groups[index].name));
                                  }),
                                  onChanged: (String? value) {
                                    // dropMenuProvider.dropdownMenuItemGroup = value!;
                                  }),
                            ],
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Semestre'),
                              const SizedBox(
                                width: 20,
                              ),
                              DropdownButton<String>(
                                  value: semestre.first.name,
                                  // value: dropMenuProvider.dropdownMenuItemSemestre,
                                  items: List.generate(
                                      semestre.length,
                                      (index) => DropdownMenuItem<String>(
                                          onTap: () {
                                            idSemestre = semestre[index].uid;

                                            // dropMenuProvider.dropdownMenuItemSemestre =
                                            //     semestre[index].uid;
                                            // student.semestre.add(semestre[index].uid);
                                          },
                                          value: semestre[index].name,
                                          child: Text(semestre[index].name))),
                                  onChanged: (String? value) {
                                    // dropMenuProvider.dropdownMenuItemSemestre = value!;
                                  }),
                            ],
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Generacion'),
                              const SizedBox(
                                width: 20,
                              ),
                              DropdownButton<String>(
                                  value:
                                      generation.first.initialDate.toString(),

                                  // value: dropMenuProvider.dropDownMenuItemGeneracion,
                                  items: List.generate(
                                      generation.length,
                                      (index) => DropdownMenuItem(
                                          onTap: () {
                                            idGeneration =
                                                generation[index].uid;
                                            // dropMenuProvider
                                            //         .dropDownMenuItemGeneracion =
                                            //     generation[index].uid;
                                            // student.generation = generation[index].uid;
                                          },
                                          value: generation[index]
                                              .initialDate
                                              .toString(),
                                          child: Text(
                                              '${generation[index].initialDate.year} - ${generation[index].finalDate.year}'))),
                                  onChanged: (String? value) {
                                    // dropMenuProvider.dropDownMenuItemGeneracion =
                                    value!;
                                  }),
                            ],
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                if (idGroup == null ||
                                    idSemestre == null ||
                                    idGeneration == null ||
                                    idTeacherAdviser == null ||
                                    idTeacherTutor == null) {
                                  // print(' Tienes que seleccionar primero pendejo ');
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text("Asesor o Tutor"),
                                        content: const Text(
                                            "Verifica si seleccionaste: GRUPO, SEMESTRE, GENERACION"),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              // Do something when the user presses the button
                                              Navigator.pop(context);
                                            },
                                            child: const Text("ACEPTAR"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                  return null;
                                } else {
                                  // showDialog(
                                  //   context: context,
                                  //   builder: (BuildContext context) {
                                  //     return AlertDialog(
                                  //       title: const Text("Confirmar Datos"),
                                  //       content: SizedBox(
                                  //         height: size.height / 2,
                                  //         child: Column(children: [
                                  //           Text('sdfsdfsd'),
                                  //           Text('sdfsdfsd'),
                                  //           Text('sdfsdfsd'),
                                  //         ]),
                                  //       ),
                                  //       actions: [
                                  //         TextButton(
                                  //           onPressed: () {
                                  //             // Do something when the user presses the button
                                  //             Navigator.pop(context);
                                  //           },
                                  //           child: const Text("ACEPTAR"),
                                  //         ),
                                  //       ],
                                  //     );
                                  //   },
                                  // );

                                  final adviserTutorServices =
                                      Provider.of<AdivserTutorServies>(context,
                                          listen: false);
                                  adviserTutorServices.createAdviserTutor(
                                      idGroup!,
                                      idSemestre!,
                                      idGeneration!,
                                      idTeacherAdviser!.uid,
                                      idTeacherTutor!.uid);
                                }
                              },
                              child: const Text('CREAR TUTOR O ASESOR')),
                        ],
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
