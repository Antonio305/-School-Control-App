import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_escolar_prepa/Services/Services.dart';
import 'package:sistema_escolar_prepa/models/subjects.dart';
import 'package:sistema_escolar_prepa/models/teacher.dart';
import 'package:sistema_escolar_prepa/providers/menu_option_provider.dart';

import 'package:blobs/blobs.dart';

import '../models/semestre.dart';

import 'dart:io';

import '../widgets/card_subject.dart';

class SubjectsScreeen extends StatefulWidget {
  const SubjectsScreeen({Key? key}) : super(key: key);

  @override
  State<SubjectsScreeen> createState() => _SubjectsState();
}

class _SubjectsState extends State<SubjectsScreeen> {
  final controllerName = TextEditingController();

// controller for dialong for craete or register subject
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameSubjectController = TextEditingController();

  String nameSubjects = '';
  @override
  void initState() {
    super.initState();
    nameSubjects = nameSubjectController.text;
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   nameSubjectController.dispose();
  // }

  String nameTeacher = '';
  String teacherSelected = '';
  String semestreSelected = '';

  @override
  Widget build(BuildContext context) {
    final dropOption = Provider.of<MenuOptionProvider>(context);

    // MOSTARMOS UNA LISTA DE PROFESORES EN LA CUAL ES  UN DATO  FICTIVIO

    final size = MediaQuery.of(context).size;

    final subjectServices = Provider.of<SubjectServices>(context);
    final subjects = subjectServices.subjects;

    return Scaffold(
      appBar: AppBar(title: const Text('Materias')),
      floatingActionButton:
          // Platform.isAndroid || Platform.isIOS
          // ?
          FloatingActionButton.extended(
        onPressed: () async {
          Platform.isAndroid || Platform.isIOS
              ? Navigator.pushNamed(context, 'subject_create')
              : openDialog(
                  context,
                  size,
                  nameTeacher,
                  teacherSelected,
                  semestreSelected,
                  'Registrar Materia',
                  _formKey,
                  nameSubjects,
                  dropOption);
        },
        label: const Text('REGISTRAR MATERIA'),
      ),
      // : Container(),
      body: Padding(
        padding: Platform.isAndroid || Platform.isIOS
            ? const EdgeInsets.all(0.0)
            : const EdgeInsets.symmetric(horizontal: 0.0),
        child: Column(
          children: [
            Platform.isAndroid || Platform.isIOS
                ? Container()
                : const Text(
                    'Lista de materias',
                    style: TextStyle(fontSize: 30),
                  ),
            SizedBox(
              // color: Colors.blue,

              width: Platform.isAndroid || Platform.isIOS
                  ? size.width * 0.95
                  : size.width,
              // height: double.infinity,
              height: Platform.isAndroid || Platform.isIOS
                  ? size.height * 0.88
                  : size.height * 0.8,

              // height: size.height * 0.5,
              // decoration: BoxDecoration(
              //     color: Colors.white,
              //     border: Border.all(
              //         color: Colors.black87,
              //         width: .1,
              //         style: BorderStyle.solid)),

              child: SingleChildScrollView(
                child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: List.generate(subjects.length, (index) {
                      final semestres = subjects[index].semestre;
                      return CardSubject(
                          size: size, subjects: subjects, index: index);
                    })),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String?> openDialog(
          BuildContext context,
          Size size,
          String nameTeacher,
          String teacherSelected,
          semestreSelected,
          String textTitle,
          GlobalKey<FormState> _formKey,
          String nameSubjects,
          MenuOptionProvider dropOption) =>
      showDialog<String>(
          // barrierColor: Colors.red[200], // color de fondo del dialong
          context: context,
          builder: (context) {
            // function all teacher  and semstre
            final semestreServices =
                Provider.of<SemestreServices>(context, listen: false);
            late List<Semestre> semestres = semestreServices.semestres;

            final teacherServices =
                Provider.of<TeachaerServices>(context, listen: false);

            late List<Teachers> teachers = teacherServices.teachers;

            int indexSemestre = 0;
            int indexTeacher = 0;

            return Center(
              child: AlertDialog(
                // scrollable: true,
                // contentPadding: const EdgeInsets.all(100),
                title: Text(textTitle),
                // content: const CreateTeacher(),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 80,
                      ),
                      Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                height: 50,
                                // width: size.width * 0.2,
                                width: 200,

                                // height: size.height * 0.5,
                                child: SizedBox(
                                  // width: size.width * 0.19,
                                  width: 250,

                                  height: 45,
                                  child: DropdownButton<String>(
                                    value: dropOption.getSemestre,
                                    items: List.generate(
                                      semestres.length,
                                      (index) {
                                        return DropdownMenuItem<String>(
                                            onTap: () {
                                              indexSemestre = index;
                                            },
                                            value: semestres[index].name,
                                            child: Text(semestres[index].name));
                                      },
                                    ),
                                    onChanged: (value) {
                                      dropOption.setSemestre = value!;
                                      semestreSelected =
                                          semestres[indexSemestre].uid;
                                      print('id semestre' + semestreSelected);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Platform.isAndroid || Platform.isIOS
                              ? Column(
                                  children: [
                                    const Text('Seleciona Profesor'),
                                    const SizedBox(width: 20),
                                    DropdownButton<String>(
                                        value: dropOption.getTeacher,
                                        items: List.generate(
                                          teachers.length,
                                          (index) {
                                            return DropdownMenuItem<String>(
                                                onTap: () {
                                                  indexTeacher = index;
                                                },
                                                value: teachers[index].name,
                                                child:
                                                    Text(teachers[index].name));
                                          },
                                        ),
                                        onChanged: (value) {
                                          dropOption.setTeacher = value!;
                                          teacherSelected =
                                              teachers[indexTeacher].uid;
                                          setState(() {});
                                        }),
                                  ],
                                )
                              : Row(
                                  children: [
                                    const Text('Seleciona Profesor'),
                                    const SizedBox(width: 20),
                                    DropdownButton<String>(
                                        value: dropOption.getTeacher,
                                        items: List.generate(
                                          teachers.length,
                                          (index) {
                                            return DropdownMenuItem<String>(
                                                onTap: () {
                                                  indexTeacher = index;
                                                },
                                                value: teachers[index].name,
                                                child:
                                                    Text(teachers[index].name));
                                          },
                                        ),
                                        onChanged: (value) {
                                          dropOption.setTeacher = value!;
                                          teacherSelected =
                                              teachers[indexTeacher].uid;
                                          setState(() {});
                                        }),
                                  ],
                                ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Form(
                        key: _formKey,
                        // autovalidateMode: AutovalidateMode.always,
                        child: TextFormField(
                          // controller: controller,
                          // initialValue: dropOption.getMateria,
                          onChanged: (String value) {
                            nameTeacher = value;
                            // dropOption.setMateria = value;
                          },
                          validator: (value) {
                            if (value == null || value.length <= 1) {
                              return 'Ingresa en nombre de la materia';
                            }
                          },
                          // autocorrect: true,
                          decoration:
                              const InputDecoration(labelText: 'Nombre'),
                        ),
                      ),
                    ],
                  ),
                ),

                actions: [
                  Row(
                    children: [
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Text('GUARDAR'),
                        onPressed: () async {
                          final subjectSservices = Provider.of<SubjectServices>(
                              context,
                              listen: false);
                          // if (_formKey.currentState?.validate() ?? false)  return;
                          await subjectSservices.createSubject(
                              nameTeacher, teacherSelected, semestreSelected);

                          Navigator.of(context).pop();
                          subjectSservices.getSubjects();
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
                      ),
                    ],
                  )
                ],
              ),
            );
          });

  Future<String?> showSubject(
          BuildContext context, Size size, List<String> teachers) =>
      showDialog<String>(
        // barrierColor: Colors.red[200], // color de fondo del dialong
        context: context,
        builder: (context) => SingleChildScrollView(
          child: Center(
            child: AlertDialog(
              // contentPadding: const EdgeInsets.all(100),
              title: const Text("Agregar datos los profesores"),
              // content: const CreateTeacher(),
              content: Container(
                width: size.width * 0.55,
                height: size.height * 0.5,
                child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 80,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  // height: 50,
                                  width: size.width * 0.2,
                                  child: TextFormField(
                                    // autocorrect: true,
                                    decoration: const InputDecoration(
                                        labelText: 'Nombre'),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text('Seleciona Profesor'),
                                const SizedBox(width: 20),
                                DropdownButton<String>(
                                    value: teachers.first,
                                    items: teachers
                                        .map((e) => DropdownMenuItem<String>(
                                            value: e, child: Text(e)))
                                        .toList(),
                                    onChanged: (value) {}),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                      ],
                    )),
              ),

              actions: [
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Text('GUARDAR'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          ),
        ),
      );
}
