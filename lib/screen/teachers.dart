import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_escolar_prepa/Services/Services.dart';
import 'package:sistema_escolar_prepa/providers/form_teacher.dart';
import 'package:sistema_escolar_prepa/providers/menu_option_provider.dart';

import 'dart:io';

import '../widgets/card_teacherr.dart';

class ScreenTeacher extends StatefulWidget {
  const ScreenTeacher({Key? key}) : super(key: key);

  @override
  State<ScreenTeacher> createState() => _ScreenTeacherState();
}

class _ScreenTeacherState extends State<ScreenTeacher> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final List<String> rol = [
      'DIRECTOR',
      'PROFESOR',
      'CONTROL ESCOLAR',
      'SUB DIRECTOR',
      'STUDENT'
    ];
    final List<String> gender = ['MASCULINO', 'FEMENINO'];

    final List<String> typeContract = ['BASE', 'INTERINADO'];

    return Scaffold(
      appBar: AppBar(title: const Text('Docentes')),
      body: Container(
        // color: Colors.red,
        // height: size.height * 0.8,
        // width: size.width * 0.13,

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Platform.isAndroid || Platform.isIOS
                ? Column(
                    // centro  horizontal
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // centro vetical
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CardTeachers(
                        onPressedOption: () {
                          Navigator.pushNamed(
                              context, 'screen_register_teacher');
                        },
                        titleAction: 'REGISTRAR DOCENTE',
                      ),
                      CardTeachers(
                        onPressedOption: () async {
                          // final teachersServices =
                          //     Provider.of<TeachaerServices>(context, listen: false);
                          //  teachersServices.getTeachers();

                          Navigator.pushNamed(context, 'list_teacher');
                        },
                        titleAction: 'LISTA DE PROFESORES',
                      ),
                      CardTeachers(
                        onPressedOption: () {},
                        titleAction: 'Porfesores de Base',
                      ),
                      CardTeachers(
                        onPressedOption: () {},
                        titleAction: 'Profesores Interinos',
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 5,
                            shadowColor: Colors.black,
                            // shadowOffset: const Offset(0, -10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(40.0),
                            child: Text('PROFESORES EN BASE'),
                          ),
                          onPressed: () {}),
                    ],
                  )
                : SingleChildScrollView(
                    child: Wrap(
                      runAlignment: WrapAlignment.center,
                      spacing: 40,
                      runSpacing: 40,
                      // centro  horizontal
                      // mainAxisAlignment: MainAxisAlignment.center,
                      // centro vetical
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CardTeachers(
                          onPressedOption: () {
                            Navigator.pushNamed(
                                context, 'screen_register_teacher');
                          },
                          titleAction: 'REGISTRAR DOCENTE',
                        ),
                        CardTeachers(
                          onPressedOption: () {
                            Navigator.pushNamed(context, 'list_teacher');
                          },
                          titleAction: 'LISTA DE PROFESORES',
                        ),
                        CardTeachers(
                          onPressedOption: () {},
                          titleAction: 'Porfesores de Base',
                        ),
                        CardTeachers(
                          onPressedOption: () {},
                          titleAction: 'Profesores Interinos',
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 5,
                              shadowColor: Colors.black,
                              // shadowOffset: const Offset(0, -10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(40.0),
                              child: Text('PROFESORES EN BASE'),
                            ),
                            onPressed: () {}),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

class InformationTeachrScreen extends StatelessWidget {
  const InformationTeachrScreen({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    final dataTeacherServices = Provider.of<TeachaerServices>(context);
    final teacher = dataTeacherServices.teachers;

    final teacherInf = dataTeacherServices.teacherForID;

    return ChangeNotifierProvider(
      create: (_) => TeacherFormProvider(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          // color: Colors.blue,
          width: size.width * 0.56,
          child: Column(children: [
            _Search(size: size),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                  // list teacher
                  SizedBox(
                    height: size.height * 0.63,
                    width: size.width * 0.24,
                    child: ListView.builder(
                      itemCount: teacher.length,
                      controller: ScrollController(initialScrollOffset: 0),
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: CircleAvatar(
                            child: Text(teacher[index].name.substring(0, 2)),
                          ),
                          title: Text(teacher[index].name),
                          subtitle: Text(teacher[index].collegeDegree),
                          onTap: () {
                            // lanzamos la peticion de los datos
                            // tenmosl alista de los datos solo lo p0aso como parametro
                            final dataTeacherServices =
                                Provider.of<TeachaerServices>(context,
                                    listen: false);

                            // dataTeacherServices.getForId(teacher[index].uid);
                          },
                        );
                      },
                    ),
                  ),
                  // const Spacer(),//

                  // para motar la informacion de los profresores
                  Container(
                    color: Colors.black12,
                    height: size.height * 0.63,
                    width: size.width * 0.3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Center(
                            child: CircleAvatar(
                              radius: 90.0,
                              backgroundColor: Colors.black,
                              child: Container(),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                // color: Colors.black,
                                color: Colors.transparent,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                    // mainAxisAlignment: MainAxisAlignment.center ,
                                    children: [
                                      Text('Nombre :' + teacherInf.name),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Sexo ' + teacherInf.gender),
                                          Text('Titulo: ' +
                                              teacherInf.collegeDegree),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Tipo de contrato:' +
                                              teacherInf.typeContract),
                                          Text('Estado: ' +
                                              teacherInf.status.toString()),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Rol:' + teacherInf.rol),
                                          Text('Matricula:' +
                                              teacherInf.tuition),
                                        ],
                                      ),
                                    ]),
                              ),
                            ),
                          ),
                          const Spacer(),
                          MaterialButton(
                              color: Colors.blue,
                              child: const Text('Editar'),
                              onPressed: () {})
                        ],
                      ),
                    ), //
                  )
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class _Menu extends StatefulWidget {
  final Size size;
  final List<String> gender;
  final List<String> typeContract;
  final List<String> rol;

  _Menu(
      {Key? key,
      required this.size,
      required this.gender,
      required this.typeContract,
      required this.rol})
      : super(key: key);

  @override
  State<_Menu> createState() => _MenuState();
}

class _MenuState extends State<_Menu> {
  // controlador para los campos de texto para los datos
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final teacherFormProvider = Provider.of<TeacherFormProvider>(context);

    return Container(
      margin: const EdgeInsets.only(top: 30, bottom: 30),
      width: widget.size.width * 0.13,
      color: const Color(0xff6138FF),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MaterialButton(
                color: Colors.blue,
                child: const Text('Registrar Docente'),
                onPressed: () {
                  Navigator.pushNamed(context, 'screen_register_teacher');
                }),
            const SizedBox(
              height: 20,
            ),
            MaterialButton(
                color: Colors.blue,
                child: const Text('Profesores En baja'),
                onPressed: () {}),
          ]),
    );
  }
}

class _Search extends StatelessWidget {
  const _Search({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          // color: Colors.red,
          color: Colors.black12),
      width: size.width * 0.5,
      height: 50,
    );
  }
}
