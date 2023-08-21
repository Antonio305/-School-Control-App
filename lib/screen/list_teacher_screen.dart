import 'dart:io';

import 'package:blobs/blobs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_escolar_prepa/Services/Services.dart';
import 'package:sistema_escolar_prepa/models/teacher.dart';
import 'package:sistema_escolar_prepa/widgets/card_information_teacher.dart';

import 'dart:ui';

class ListTeacherScreen extends StatefulWidget {
  const ListTeacherScreen({Key? key}) : super(key: key);

  @override
  State<ListTeacherScreen> createState() => _ListTeacherScreenState();
}

class _ListTeacherScreenState extends State<ListTeacherScreen> {
  // instncia DE LA CLASE DEP ROFESORES
  // final teacher =  Teachers(name: '', lastName: '', secondName: ', gender:' ', collegeDegree: '', typeContract: '', status: false, rol: '', tuition: '', uid: '')

  Teachers teacher = Teachers(
      name: "",
      lastName: "",
      secondName: "",
      gender: "",
      collegeDegree: '',
      typeContract: '',
      status: false,
      rol: '',
       numberPhone: '',
      email: '',
      tuition: '',
      uid: ' ');

  @override
  Widget build(BuildContext context) {
    final teachersServices = Provider.of<TeachaerServices>(context);
    final teachers = teachersServices.teachers;

    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(title: const Text('Docentes')),
        body: SafeArea(
            child: Platform.isWindows || Platform.isMacOS
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      children: [
                        SizedBox(
                          width: size.width * 0.25,
                          child: ListView.builder(
                            itemCount: teachers.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                onTap: () {
                                  teacher = teachers[index];
                                  setState(() {});
                                },
                                mouseCursor: MouseCursor.uncontrolled,
                                leading: CircleAvatar(
                                  child: Text(
                                      teachers[index].name.substring(0, 2)),
                                ),
                                trailing:
                                    const Icon(Icons.navigate_next_rounded),
                                dense: true,
                                title: Text(teachers[index].name),
                                subtitle: Text(teachers[index].collegeDegree),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              );
                            },
                          ),
                        ),
                        InformationSubjectScreenByDesktop(teacher: teacher),
                      ],
                    ),
                  )
                : Center(
                    child: teachers.isEmpty
                        ? Column(
                            children: [
                              Image.asset('asset/loading.png'),
                              const CircularProgressIndicator()
                            ],
                          )
                        : ListView.builder(
                            itemCount: teachers.length,
                            itemBuilder: (BuildContext context, int index) {
                              return CardInformationTeacher(
                                  teacher: teachers, index: index);
                            },
                          ),
                  )));
  }
}

class InformationSubjectScreenByDesktop extends StatelessWidget {
  final Teachers teacher;

  const InformationSubjectScreenByDesktop({Key? key, required this.teacher})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: SizedBox(
        width: size.width * 0.65,
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _image(size: size, teacher: teacher),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color.fromARGB(255, 73, 70, 238)
                                      .withOpacity(0.2),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('DATOS DEL DOCENTE'),
                                ))),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          width: size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color.fromARGB(255, 73, 70, 238)
                                .withOpacity(0.2),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Wrap(runSpacing: 50, spacing: 20,
                                // mainAxisAlignment: MainAxisAlignment.start,
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text('SEXO : ' + teacher.gender),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text('TITULO PROFESIONAL   : ' +
                                      teacher.collegeDegree),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text('TIPO DE CONTRATO  :' +
                                      teacher.typeContract),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text('ESTADO   : ' + teacher.status.toString()),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text('Rol  :' + teacher.rol),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text('Matricula  :' + teacher.tuition),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                ]),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: ElevatedButton(
                    // color: Colors.blue,
                    autofocus: true,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color(0xFF5c63FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      child: Text('EDITAR INFORMACION'),
                    ),
                    onPressed: () {}),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _image extends StatelessWidget {
  const _image({
    Key? key,
    required this.size,
    required this.teacher,
  }) : super(key: key);

  final Size size;
  final Teachers teacher;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
        // border: Border.all(color: Colors.black26, width: 0.5),
        color: Color(0xFF1D2027),
      ),

      width: size.width,
      height: 250,
      // width: 300,
      child: Column(
        children: [
          CircleAvatar(
            // backgroundImage: ,
            radius: 60.0,
            backgroundColor: Colors.blueAccent,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(90),
              child: Image.network(
                'https://img.apmcdn.org/2e2ceb4fdbd8ac017b85b242fe098cb3b466cf5a/square/44315c-20161208-katherine-johnson.jpg',
                fit: BoxFit.fill,
              ),
            ),
          ),
          const SizedBox(height: 30),

          // name teacher
          Text(
            '${teacher.name + "  " + teacher.lastName + "  " + teacher.secondName}',
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          const Text('eldioseltreno@gmail.com',
              style: TextStyle(color: Colors.white60)),
        ],
      ),
    );
  }
}
