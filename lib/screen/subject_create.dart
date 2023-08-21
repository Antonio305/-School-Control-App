import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Services/Services.dart';
import '../models/semestre.dart';
import '../models/teacher.dart';
import '../providers/menu_option_provider.dart';

class ScreenSubjectCreate extends StatefulWidget {
  const ScreenSubjectCreate({Key? key}) : super(key: key);

  @override
  State<ScreenSubjectCreate> createState() => _MyAppState();
}

class _MyAppState extends State<ScreenSubjectCreate> {
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

  String? semestreSelected;
  String? teacherSelected;
  String? nameTeacher;
  @override
  Widget build(BuildContext context) {
    final dropOption = Provider.of<MenuOptionProvider>(context);

    final semestreServices =
        Provider.of<SemestreServices>(context, listen: false);
    late List<Semestre> semestres = semestreServices.semestres;

    final teacherServices =
        Provider.of<TeachaerServices>(context, listen: false);

    late List<Teachers> teachers = teacherServices.teachers;

    int indexSemestre = 0;
    int indexTeacher = 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text(' Registar materia'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 80,
              ),
              SizedBox(
                // width: size.width * 0.19,
                width: 200,

                // height: 45,
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
                    semestreSelected = semestres[indexSemestre].uid;
                    print('id semestre' + semestreSelected!);
                  },
                ),
              ),
              const SizedBox(
                height: 80,
              ),
              Platform.isAndroid || Platform.isIOS
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                    child: Text(teachers[index].name));
                              },
                            ),
                            onChanged: (value) {
                              dropOption.setTeacher = value!;
                              teacherSelected = teachers[indexTeacher].uid;
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
                                    child: Text(teachers[index].name));
                              },
                            ),
                            onChanged: (value) {
                              dropOption.setTeacher = value!;
                              teacherSelected = teachers[indexTeacher].uid;
                              setState(() {});
                            }),
                      ],
                    ),
              const SizedBox(
                height: 56,
              ),
              Form(
                key: _formKey,
                // autovalidateMode: AutovalidateMode.always,
                child: SizedBox(
                  height: 56,
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
                    style: const TextStyle(fontSize: 16),
                    // autocorrect: true,
                    decoration: InputDecoration(
                        labelText: 'Nombre de la materia',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(width: 1),
                        )),
                  ),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  autofocus: true,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(5),
                  // ),
                  child: const Text('REGISTRAR'),
                  onPressed: () async {
                    final subjectSservices =
                        Provider.of<SubjectServices>(context, listen: false);

                    if (nameTeacher == null ||
                        semestreSelected == null ||
                        teacherSelected == null) {
                      return showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text("Error"),
                          content:
                              const Text("Por favor, seleccione una opción."),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Aceptar'),
                            )
                          ],
                        ),
                      );
                    }

                    if (_formKey.currentState?.validate() ?? false) return null;
                    
                    await subjectSservices.createSubject(
                        nameTeacher!, teacherSelected!, semestreSelected!);
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
