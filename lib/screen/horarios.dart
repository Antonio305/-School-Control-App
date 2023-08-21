import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_escolar_prepa/Services/Services.dart';
import 'package:sistema_escolar_prepa/Services/horario_services.dart';
import 'package:sistema_escolar_prepa/models/generations.dart';
import 'package:sistema_escolar_prepa/models/semestre.dart';
import 'package:sistema_escolar_prepa/models/subjects.dart';

import '../models/group.dart';
import '../models/horario.dart';
import '../providers/menu_option_provider.dart';

class ScreenHorarios extends StatefulWidget {
  const ScreenHorarios({Key? key}) : super(key: key);

  @override
  State<ScreenHorarios> createState() => _HorariosState();
}

class _HorariosState extends State<ScreenHorarios> {
  List<String> dayMonday = [];
  List<String> dayTuesday = [];
  List<String> dayWednesday = [];
  List<String> dayThursday = [];
  List<String> dayFriday = [];

  List<String> hours = [
    "07:00 - 07:50",
    "07:50 - 08:40",
    "08:40 - 09:30",
    "09:30 - 10:00",
    "10:00 - 10:50",
    "10:50 - 11:40",
    "11:40 - 12:30",
    "12:30 - 13:20",
    "13:20 - 14:10"
  ];

  String? generationSelect;
  String? semestreSelect;
  String? groupSelect;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // instance class HoraioServices
    final horarioServices = Provider.of<HorarioServices>(context);
    final horarios = horarioServices.horarios;

    final dropMemu = Provider.of<MenuOptionProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Horarios')),
      body: Container(
        // color: Colors.black,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(4.0),
                child: Text(
                  'HORARIOS DE CLASE',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Container(
                // color: Colors.amber,
                height: size.height * 0.85,
                width: size.width * 0.95,
                // width: double.infinity,
                child: Column(
                  children: [
                    Container(
                      width: size.width * 0.95,
                      height: size.height * 0.68,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: horarios.length,
                        itemBuilder: (BuildContext context, int index) {
                          // parar el  index
                          final data = horarios[index];
                          return _ContentHorario(size: size, horarios: data);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        color: Colors.cyan,
                        height: 90,
                        // width: double.infinity,
                        width: size.width * 0.9,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MaterialButton(
                                onPressed: () async {
                                  // semestre
                                  final semestreServices =
                                      Provider.of<SemestreServices>(context,
                                          listen: false);
                                  await semestreServices.allSemestre();

                                  // grupos
                                  final groupServices =
                                      Provider.of<GroupServices>(context,
                                          listen: false);
                                  await groupServices.allGroup();

                                  final generationServices =
                                      Provider.of<GenerationServices>(context,
                                          listen: false);
                                  await generationServices.allGeneration();

                                  openDialogCreateHorario(
                                      context,
                                      size,
                                      hours,
                                      dayMonday,
                                      dayTuesday,
                                      dayWednesday,
                                      dayThursday,
                                      dayFriday);
                                },
                                // ignore: prefer_const_constructors
                                child: Text('CRAER HORARIO'),
                              ),
                              MaterialButton(
                                onPressed: () {},
                                child: const Text('VER  HORARIO'),
                              ),
                            ]),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// create horario
  Future<String?> openDialogCreateHorario(
    BuildContext context,
    Size size,
    hours,
    List<String> dayMonday,
    List<String> dayTuesday,
    List<String> dayWednesday,
    List<String> dayThursday,
    List<String> dayFriday,
  ) =>
      showDialog<String>(
          // barrierColor: Colors.red[150], // color de fondo del dialong
          context: context,
          builder: (context) {
            // creamos estas listas vacias para agregar le id de cada unos de los materia seleccionadas.

            // mostrar las mtaria por semestre

            final subjectServices = Provider.of<SubjectServices>(context);
            late List<Subjects> subjects = subjectServices.subjects;

            final dropMemu = Provider.of<MenuOptionProvider>(context);

            // generations
            final generationServices = Provider.of<GenerationServices>(context);
            late List<Generation> generations = generationServices.generations;

            // smestre
            final semestreServices =
                Provider.of<SemestreServices>(context, listen: false);

            late List<Semestre> semestres = semestreServices.semestres;
            // group

            final groupServices =
                Provider.of<GroupServices>(context, listen: false);
            late Groups groups = groupServices.group;

            // mostraremos las materia por generaciones.

            return SingleChildScrollView(
              child: AlertDialog(
                // contentPadding: const EdgeInsets.all(100),
                title: const Text("CREAR HORARIOS DE CLASE"),
                // content: const CreateDataStudent(),
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            // const Text('GENERACION'),
                            DropdownButton<String>(
                              // value: dropMemu.dropdownMenuItemGroup,
                              // value: dropMemu.getGeneration,
                              value: generations.first.finalDate.toString(),
                              items: List.generate(
                                generations.length,
                                (index) => DropdownMenuItem(
                                    value:
                                        generations[index].finalDate.toString(),
                                    child: Text(generations[index]
                                        .finalDate
                                        .toString()),
                                    onTap: () async {
                                      final subjectServicess =
                                          Provider.of<SubjectServices>(context,
                                              listen: false);

                                      generationSelect = generations[index].uid;

                                      // await subjectServicess
                                      //     .allSubjectForSemestre(
                                      //         generations[index].uid);
                                    }),
                              ),
                              onChanged: (value) async {
                                dropMemu.dropdownMenuItemGroup = value!;
                              },
                            )
                          ],
                        ),
                        Row(
                          children: [
                            const Text('semestre'),
                            const SizedBox(
                              width: 20,
                            ),
                            DropdownButton<String>(
                                // value: dropMemu.dropdownMenuItemGroup,
                                value: semestres.first.name,
                                items: List.generate(
                                  semestres.length,
                                  (index) => DropdownMenuItem(
                                      value: semestres[index].name.toString(),
                                      child: Text(semestres[index].name),
                                      onTap: () {
                                        print("Buscando materia por id ");

                                        final subjectServicess =
                                            Provider.of<SubjectServices>(
                                                context,
                                                listen: false);

                                        semestreSelect = semestres[index].uid;

                                        subjectServicess.allSubjectForSemestre(
                                            semestres[index].uid);
                                      }),
                                ),
                                onChanged: (String? value) {
                                  dropMemu.dropdownMenuItemGroup = value!;
                                  //   print('Buscando materias');
                                  //  subjectServices.allSubjectForSemestre();
                                })
                          ],
                        ),
                        Row(
                          children: [
                            Text('GRUPO'),
                            DropdownButton<String>(
                                // value: dropMemu.dropdownMenuItemGroup,
                                value: groups.groups.first.name,
                                items: List.generate(
                                    groups.groups.length,
                                    (index) => DropdownMenuItem<String>(
                                        onTap: () {
                                          groupSelect = groups.groups[index].uid;
                                        },
                                        value: groups.groups[index].name,
                                        child: Text(groups.groups[index].name))),
                                onChanged: (String? value) {
                                  dropMemu.dropdownMenuItemGroup = value!;
                                })
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: size.width * 0.9,
                      height: size.height * 0.47,
                      // color: Colors.red,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: size.width * 0.1,
                            height: size.height * 0.6,
                            child: Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(2.0),
                                  child: Text('HORA'),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: hours.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Chip(
                                        label: Text(hours[index]),
                                        labelStyle: const TextStyle(
                                            fontSize: 12, color: Colors.white),
                                        backgroundColor: Colors.black54,
                                        // deleteIcon: const Icon(
                                        //   Icons.cancel_outlined,
                                        //   color: Colors.white38,
                                        //   size: 18,
                                        // ),
                                        // onDeleted: () {
                                        //   print("deleted");

                                        //   // _deleteChip(index);
                                        //   // dropMemu.setList = "34:00- 44:54" ;
                                        //   //dropMemu.deleteList = index;
                                        // },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: size.width * 0.1,
                            height: size.height * 0.6,
                            child: Column(
                              children: [
                                MaterialButton(
                                    onPressed: () {
                                      dropMemu.setDay = "LUNES";
                                    },
                                    child: const Text('LUNES')),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: dropMemu.getDayMonday.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Chip(
                                        label:
                                            Text(dropMemu.getDayMonday[index]),
                                        labelStyle: const TextStyle(
                                            fontSize: 12, color: Colors.white),
                                        backgroundColor: Colors.lightBlue,
                                        deleteIcon: const Icon(
                                          Icons.cancel_outlined,
                                          color: Colors.white38,
                                          size: 18,
                                        ),
                                        onDeleted: () {
                                          print("deleted");

                                          // _deleteChip(index);
                                          // dropMemu.setList = "34:00- 44:54" ;
                                          //dropMemu.deleteList = index;
                                          dropMemu.deleteDayMonday = index;
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: size.width * 0.1,
                            height: size.height * 0.6,
                            child: Column(
                              children: [
                                MaterialButton(
                                  onPressed: () {
                                    dropMemu.setDay = "MARTES";
                                  },
                                  child: const Text('MARTES'),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: dropMemu.getDayTuesday.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Chip(
                                        label:
                                            Text(dropMemu.getDayTuesday[index]),
                                        labelStyle: const TextStyle(
                                            fontSize: 12, color: Colors.white),
                                        backgroundColor: Colors.black54,
                                        deleteIcon: const Icon(
                                          Icons.cancel_outlined,
                                          color: Colors.white38,
                                          size: 18,
                                        ),
                                        onDeleted: () {
                                          print("deleted");

                                          // _deleteChip(index);
                                          // dropMemu.setList = "34:00- 44:54" ;
                                          dropMemu.deleteDayTuesday = index;
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: size.width * 0.1,
                            height: size.height * 0.6,
                            child: Column(
                              children: [
                                MaterialButton(
                                  onPressed: () {
                                    dropMemu.setDay = "MIERCOLES";
                                  },
                                  child: const Text('MIERCOLES'),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: dropMemu.getDayWednesday.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Chip(
                                        label: Text(
                                            dropMemu.getDayWednesday[index]),
                                        labelStyle: const TextStyle(
                                            fontSize: 12, color: Colors.white),
                                        backgroundColor: Colors.black54,
                                        deleteIcon: const Icon(
                                          Icons.cancel_outlined,
                                          color: Colors.white38,
                                          size: 18,
                                        ),
                                        onDeleted: () {
                                          print("deleted");

                                          // _deleteChip(index);
                                          // dropMemu.setList = "34:00- 44:54" ;
                                          dropMemu.deleteDayWednesday = index;
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: size.width * 0.1,
                            height: size.height * 0.6,
                            child: Column(
                              children: [
                                MaterialButton(
                                  onPressed: () {
                                    dropMemu.setDay = "JUEVES";
                                  },
                                  child: const Text('JUEVES'),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: dropMemu.getDayThurday.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Chip(
                                        label:
                                            Text(dropMemu.getDayThurday[index]),
                                        labelStyle: const TextStyle(
                                            fontSize: 12, color: Colors.white),
                                        backgroundColor: Colors.black54,
                                        deleteIcon: const Icon(
                                          Icons.cancel_outlined,
                                          color: Colors.white38,
                                          size: 18,
                                        ),
                                        onDeleted: () {
                                          print("deleted");

                                          // _deleteChip(index);
                                          // dropMemu.setList = "34:00- 44:54" ;
                                          dropMemu.deleteDayThursday = index;
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: size.width * 0.1,
                            height: size.height * 0.6,
                            child: Column(
                              children: [
                                MaterialButton(
                                  onPressed: () {
                                    dropMemu.setDay = "VIERNES";
                                  },
                                  child: const Text('VIERNES'),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: dropMemu.getDayFriday.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Chip(
                                        label:
                                            Text(dropMemu.getDayFriday[index]),
                                        labelStyle: const TextStyle(
                                            fontSize: 12, color: Colors.white),
                                        backgroundColor: Colors.black54,
                                        deleteIcon: const Icon(
                                          Icons.cancel_outlined,
                                          color: Colors.white38,
                                          size: 18,
                                        ),
                                        onDeleted: () {
                                          print("deleted");

                                          // _deleteChip(index);
                                          // dropMemu.setList = "34:00- 44:54" ;
                                          dropMemu.deleteDayFriday = index;
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Lista de las materias
                    const SizedBox(
                      height: 10,
                    ),

                    const Text('LISTA DE MATERIAS POR SEMESTRE'),
                    const SizedBox(
                      height: 10,
                    ),

                    // lista de las materrias cuado se selecciona

                    Container(
                      color: Colors.red,
                      width: double.infinity,
                      height: 100,
                      child: Wrap(
                        children: List.generate(
                          subjects.length,
                          (index) => Chip(
                            label: Text(subjects[index].name),
                            labelStyle: const TextStyle(
                                fontSize: 12, color: Colors.white),
                            backgroundColor: Colors.black54,
                            deleteIcon: const Icon(
                              Icons.cancel_outlined,
                              color: Colors.white38,
                              size: 18,
                            ),
                            onDeleted: () {
                              final option = dropMemu.getDay;

                              // EN CADA UNA DE LAS OPCIONES INGRESAMOS LOS DATOS EN DIFERENTES LISTAS

                              switch (option) {
                                case "LUNES":
                                  dropMemu.setDayMonday = subjects[index].name;
                                  dayMonday.add(subjects[index].uid);
                                  print('Lunes');
                                  break;

                                case "MARTES":
                                  dropMemu.setDayTuesday = subjects[index].name;
                                  dayTuesday.add(subjects[index].uid);

                                  print('MARTES');
                                  break;
                                case "MIERCOLES":
                                  dropMemu.setDayWednesday =
                                      subjects[index].name;
                                  dayWednesday.add(subjects[index].uid);
                                  print('MIERCOLES');

                                  break;
                                case "JUEVES":
                                  dropMemu.setDayThursday =
                                      subjects[index].name;

                                  dayThursday.add(subjects[index].uid);
                                  print('JUEVES');

                                  break;
                                case "VIERNES":
                                  dropMemu.setDayFriday = subjects[index].name;
                                  dayFriday.add(subjects[index].uid);
                                  print('VIERNES');

                                  break;
                                default:
                              }

                              // print("deleted");
                              // dropMemu.setList = "Matematicas";
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                actions: [
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Text('GUARDAR'),
                    onPressed: () async {
                      final horarioServices =
                          Provider.of<HorarioServices>(context, listen: false);

                      // falta las validacioens en la cuales eso haremos

                      await horarioServices.createHorario(
                          generationSelect!,
                          semestreSelect!,
                          groupSelect!,
                          hours,
                          dayMonday,
                          dayTuesday,
                          dayWednesday,
                          dayThursday,
                          dayFriday);

                      // Limpiamos el valor de aloa array
                      dayMonday.clear();
                      dayTuesday.clear();
                      dayWednesday.clear();
                      dayThursday.clear();
                      dayFriday.clear();

                      dropMemu.clearList();

                      Navigator.of(context).pop();
                    },
                  ),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Text('CANCELAR'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            );
          });
}

class _ContentHorario extends StatefulWidget {
  final Size size;
  final Horario horarios;

  const _ContentHorario({Key? key, required this.size, required this.horarios})
      : super(key: key);
  @override
  State<_ContentHorario> createState() => _ContentHorarioState();
}

class _ContentHorarioState extends State<_ContentHorario> {
  @override
  Widget build(BuildContext context) {
//

    final List hours = [
      "07:00 - 07:50",
      "07:50 - 08:40",
      "08:40 - 09:30",
      "09:30 - 10:00",
      "10:00 - 10:50",
      "10:50 - 11:40",
      "11:40 - 12:30",
      "12:30 - 13:20",
      "13:20 - 14:10"
    ];

    final decorationCardDay = BoxDecoration(
      // color: Colors.white,
      borderRadius: BorderRadius.circular(5), //border corner radius
      // boxShadow: [
      //   BoxShadow(
      // color: Colors.grey.withOpacity(0.5), //color of shadow
      // spreadRadius: 4, //spread radius
      // blurRadius: 3, // blur radius
      // offset: const Offset(0, 4), // changes position of shadow
      //first paramerter of offset is left-right
      //second parameter is top to down
      // ),
      // ],
    );

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
          height: widget.size.height * 0.72,
          // color: Colors.grey,
          // width: size.width * 0.56,
          width: widget.size.width * 0.9,
          // width: double.infinity,
          decoration: BoxDecoration(
              // color: Colors.white,
              borderRadius: BorderRadius.circular(10), //border corner radius
              border: Border.all(width: 0.5, color: Colors.white30)
              // boxShadow: [
              //   BoxShadow(
              // // color: Colors.grey.withOpacity(0.5), //color of shadow
              // spreadRadius: 3, //spread radius
              // blurRadius: 5, // blur radius
              // offset: const Offset(0, 4), // changes position of shadow
              //first paramerter of offset is left-right
              //second parameter is top to down
              // ),
              // ],
              ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 10.0, top: 30.0, left: 10.0, right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('CICLO ESCOLAR: ' +
                        " " +
                        widget.horarios.schoolYear.initialDate.year.toString() +
                        " " +
                        widget.horarios.schoolYear.finalDate.year.toString()),
                    Text('SEMESTRE :  ' +
                        widget.horarios.semestre.name.toString()),
                    Text('GRUPO :  ' + widget.horarios.group.name),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 400,
                  width: widget.size.width * 0.95,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      // color: Colors.red,
                      border: Border.all(
                        color: Colors.white,
                        width: .1,
                      )),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      SizedBox(
                        // color: Colors.red,
                        // color: Colors.lightGreen,
                        // width: widget.size.width * 0.13,
                        width: 150,
                        // height: double.infinity,
                        height: widget.size.height * 0.55,
                        // decoration: decorationCardDay,

                        child: Column(children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('HORA / DIA '),
                          ),
                          Expanded(
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: widget.horarios.hours.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(width: 0.1)),
                                    height: 35,
                                    child: Center(
                                        child: Text(
                                            widget.horarios.hours[index])));
                              },
                            ),
                          ),
                        ]),
                      ),
                      Container(
                        // color: Colors.lightGreen,
                        // width: widget.size.width * 0.1,
                        width: 150,

                        height: widget.size.height * 0.55,
                        // decoration: decorationCardDay,
                        child: Column(children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('LUNES'),
                          ),
                          Expanded(
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: widget.horarios.monday.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(width: 0.1)),
                                    height: 35,
                                    child: Center(
                                        child: Text(widget
                                            .horarios.monday[index].name)));
                              },
                            ),
                          ),
                        ]),
                      ),
                      Container(
                        // color: Colors.lightGreen,
                        // width: widget.size.width * 0.1,
                        width: 150,

                        height: widget.size.height * 0.55,
                        // decoration: decorationCardDay,
                        child: Column(children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('MARTES'),
                          ),
                          Expanded(
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: widget.horarios.tuesday.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(width: 0.1)),
                                    height: 35,
                                    child: Center(
                                        child: Text(widget
                                            .horarios.tuesday[index].name)));
                              },
                            ),
                          ),
                        ]),
                      ),
                      Container(
                        // color: Colors.lightGreen,
                        // width: widget.size.width * 0.1,
                        width: 150,
                        height: widget.size.height * 0.55,
                        // decoration: decorationCardDay,
                        child: Column(children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('MIERCOLES'),
                          ),
                          Expanded(
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: widget.horarios.wednesday.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(width: 0.1)),
                                    height: 35,
                                    // color: Colors.red,
                                    child: Center(
                                        child: Text(widget
                                            .horarios.wednesday[index].name)));
                              },
                            ),
                          ),
                        ]),
                      ),
                      Container(
                        // color: Colors.lightGreen,
                        // width: widget.size.width * 0.1,
                        width: 150,

                        height: widget.size.height * 0.55,
                        // decoration: decorationCardDay,
                        child: Column(children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(child: Text('JUEVES')),
                          ),
                          Expanded(
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: widget.horarios.thursday.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(width: 0.1)),
                                    height: 35,
                                    // color: Colors.red,
                                    child: Center(
                                      child: Text(
                                        widget.horarios.thursday[index].name,
                                        // style:,
                                        // overflow: TextOverflow.ellipsis,
                                      ),
                                    ));
                              },
                            ),
                          ),
                        ]),
                      ),
                      Container(
                        // color: Colors.lightGreen,
                        // width: widget.size.width * 0.1,
                        width: 150,

                        height: widget.size.height * 0.55,
                        // decoration: decorationCardDay,
                        child: Column(children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('VIERNES'),
                          ),
                          Expanded(
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: widget.horarios.friday.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(width: 0.1)),
                                    height: 35,
                                    child: Center(
                                        child: Text(widget
                                            .horarios.friday[index].name)));
                              },
                            ),
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
