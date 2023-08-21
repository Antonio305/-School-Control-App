import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_escolar_prepa/models/teacher.dart';

import '../Services/teacher_services.dart';

class InformationTeacherScreen extends StatelessWidget {
  const InformationTeacherScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // recivimos los datos por parmero

    Teachers teacher = ModalRoute.of(context)?.settings.arguments as Teachers;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0XFF1d2027),
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _image(size: size, teacher: teacher),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Stack(
                children: [
                  // Center(
                  //   child: Container(
                  //     width: 200,
                  //     height: 200,
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(10),
                  //       color: Colors.red
                  //     ),
                  //     child: Image.asset('asset/teacher_men.png'),
                  //   ),
                  // ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
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
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Text('SEXO :' + teacher.gender),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text('TITULO PROFESIONAL: ' +
                                    teacher.collegeDegree),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                    'TIPO DE CONTRATO:' + teacher.typeContract),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text('ESTADO: ' + teacher.status.toString()),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text('Rol:' + teacher.rol),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text('Matricula:' + teacher.tuition),
                                const SizedBox(
                                  height: 15,
                                ),
                                //  Text('Matricula:' + teacher.),
                              ]),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
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
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: Text('EDITAR INFORMACION'),
                  ),
                  onPressed: () {}),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
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
      height: 300,
      // width: 300,
      child: Column(
        children: [
          CircleAvatar(
            // backgroundImage: ,
            radius: 90.0,
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
            // '${teacher.name + "  " + teacher.lastName}',

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
