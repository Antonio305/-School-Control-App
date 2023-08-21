import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_escolar_prepa/Services/generation_services.dart';
import 'package:sistema_escolar_prepa/Services/group_services.dart';
import 'package:sistema_escolar_prepa/Services/semestre.dart';
import 'package:sistema_escolar_prepa/models/tuition.dart';

import '../Services/student_services.dart';
import '../Services/tuition_services.dart';
import '../providers/form_provider.dart';
import '../providers/menu_option_provider.dart';
import '../widgets/buttto_option_student.dart';
import '../widgets/text_fileds.dart';

class ScreenStudent extends StatefulWidget {
  const ScreenStudent({Key? key}) : super(key: key);

  @override
  State<ScreenStudent> createState() => _ScreenStudentState();
}

class _ScreenStudentState extends State<ScreenStudent> {
  DateTime selectedDate = DateTime.now();

// controlador para el formulario
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
// controlador del campo de texto
  TextEditingController controller = TextEditingController();
  String tuition = '';
  String message = 'matricula: ';

  Tuitions tuitions = Tuitions(tuition: '', id: '', status: false, user: User(name: '', lastName: '', secondName: '', uid:''));

  Map<String, dynamic> respBody = {};

  bool status = false;

  @override
  void initState() {
    tuition = controller.text;
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final tuitionServices = Provider.of<TuitionServices>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Estudiantes')),
      body: Center(
        child: Platform.isWindows || Platform.isMacOS
            ? Wrap(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                        const ButtonOptionStudent(
                    pathImage: 'asset/active_public.png',
                    textButton: 'REGISTRAR MATRICULA',
                    icon: Icons.add,
                    route: 'tuition',
                  ),

                  MaterialButton(
                    onPressed: () async {
                      final studentServices =
                          Provider.of<StudentsServices>(context, listen: false);
                      studentServices.getStudents();
                      Navigator.pushNamed(context, 'screen_list_student');
                    },
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).brightness == Brightness.dark
                                ? Colors.white30
                                : Colors.black12,
                            Theme.of(context).brightness == Brightness.dark
                                ? Colors.black12
                                : Colors.white30
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: SizedBox(
                        width: 300,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: Image.asset('asset/student2.png')),
                              const Text('LISTA DE ALUMNOS'),
                              const Icon(Icons.list_alt),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  //  const ButtonOptionStudent(
                  //       pathImage: 'asset/active_public.png',
                  //       textButton: 'LISTA DE',
                  //       icon: Icons.list_alt,
                  //       route: 'create_student',
                  //     ),

                  const ButtonOptionStudent(
                    pathImage: 'asset/active_public.png',
                    textButton: 'REGISTRAR ALUMNO',
                    icon: Icons.add,
                    route: 'create_student',
                  ),

                  Card(
                    elevation: 5,
                    child: MaterialButton(
                      onPressed: () {
                        openDialogSelectTypeBaja(context, size);
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(50.0),
                        child: Text('ALUMNOS EN BAJA'),
                      ),
                    ),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    onPressed: () async {
                      final studentServices =
                          Provider.of<StudentsServices>(context, listen: false);
                      studentServices.getStudents();
                      Navigator.pushNamed(context, 'screen_list_student');
                    },
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).brightness == Brightness.dark
                                ? Colors.white30
                                : Colors.black12,
                            Theme.of(context).brightness == Brightness.dark
                                ? Colors.black12
                                : Colors.white30
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                                width: 50,
                                height: 50,
                                child: Image.asset('asset/student2.png')),
                            const Text('LISTA DE ALUMNOS'),
                            const Icon(Icons.list_alt),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const ButtonOptionStudent(
                    pathImage: 'asset/active_public.png',
                    textButton: 'REGISTRAR ALUMNO',
                    icon: Icons.add,
                    route: 'create_student',
                  ),
                  const ButtonOptionStudent(
                    pathImage: 'asset/active_public.png',
                    textButton: 'BUSCAR POR AREA',
                    icon: Icons.phone,
                    route: 'create_student',
                  ),
                  Card(
                    elevation: 5,
                    child: MaterialButton(
                      onPressed: () {
                        openDialogSelectTypeBaja(context, size);
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(50.0),
                        child: Text('ALUMNOS EN BAJA'),
                      ),
                    ),
                  ),
                ],
              ),
        // ),
      ),
    );
  }

  Future<String?> openDialogAnimatino(BuildContext context, Size size) =>
      showDialog<String>(
        // barrierColor: Colors.red[200],
        context: context,
        builder: (context) => AlertDialog(
          scrollable: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Text("Selecciona el tipo de baja"),
          content: const SizedBox(
            width: 300,
            height: 300,
            child: CircularProgressIndicator(
                value: 100, backgroundColor: Colors.red, color: Colors.white),
          ),
          actions: [Container()],
        ),
      );
      

  Future<String?> openDialogSelectTypeBaja(BuildContext context, Size size) =>
      showDialog<String>(
        // barrierColor: Colors.red[200],
        context: context,
        builder: (context) => AlertDialog(
          scrollable: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          icon: Align(
              alignment: Alignment.center,
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.sim_card_alert_rounded,
                    size: 20,
                  ))),
          title: const Text("Selecciona el tipo de baja"),
          content: Center(
            child: SizedBox(
                height: Platform.isWindows || Platform.isMacOS
                    ? size.height / 3
                    : size.height / 2,
                width: Platform.isWindows || Platform.isMacOS
                    ? size.width / 3
                    : size.width / 2,
                child: SingleChildScrollView(
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    runSpacing: 10,
                    spacing: 10,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 1, vertical: 25),
                          child: Text('Baja Temporal'),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text('Baja Definitiva'),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text('Baja No Se Mas'),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text('Otras opc.'),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancelar'))
            // Container(),
            // CupertinoButton(child: const Text('Aceptar'), onPressed: () {}),
            // CupertinoButton(child: const Text('Cancelar'), onPressed: () {})
          ],
        ),
      );

  Future<String?> openDialogSeacherMatricula(
          BuildContext context, Size size, TuitionServices tuitionServices) =>
      showDialog<String>(
          // barrierColor: Colors.red[200],
          context: context,
          builder: (context) {
            final tuitionServicess = Provider.of<TuitionServices>(context);

            return AlertDialog(
              scrollable: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              icon: Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                      onPressed: () {
                        // Tuitions(tuition: '');
                        tuitionServicess.status = false;
                        Navigator.pop(context);
                        controller.clear();
                      },
                      icon: const Icon(
                        Icons.highlight_remove_sharp,
                        size: 20,
                      ))),
              title: const Text("BUSCAR MATRICULA"),
              content: SizedBox(
                height: size.height / 2,
                child: Form(
                  key: _formKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        /**
                        * TODO: solo para los estudianes en la cual esto puede pasar directo
                        */
                        tuitionServices.status == false
                            ? SizedBox(
                                width: 300,
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'llenar el campo';
                                    }
                                  },
                                  controller: controller,
                                  // obscureText: true,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 20),
                                  onChanged: (value) {
                                    tuition = value;
                                  },
                                ),
                              )
                            : Container(),
                        Text(tuitionServicess.tuition.tuition),

                        const SizedBox(
                          height: 20,
                        ),

                        tuitionServices.status == true
                            ? MaterialButton(
                                enableFeedback: false,
                                color: Colors.red,
                                child: const Text('Registar'),
                                onPressed: () {
                                  Navigator.pushNamed(context, 'create_student',
                                      arguments:
                                          tuitionServices.tuition.tuition);
                                })
                            : Container(),

                        // MaterialButton(
                        //   enableFeedback: false,
                        //   color: Colors.red,
                        //   child: const Text('Registar'),
                        //   onPressed: () {}

                        //   ),

                        const SizedBox(
                          height: 20,
                        ),
                      ]),
                ),
              ),
              actions: [
                tuitionServices.status == false
                    ? Center(
                        child: MaterialButton(
                            color: Colors.black87,
                            onPressed: () async {
                              final tuitionServices =
                                  Provider.of<TuitionServices>(context,
                                      listen: false);

                              // final Map<String, dynamic>
                              if (_formKey.currentState!.validate()) {
                                tuitionServices.getTuitionName(tuition);

                                //   if (respBody.containsKey('msg')) {sssssssssss
                                //     setState(() {sssssssssssssssssss
                                //       tuitions.tuition = respBody['msg'];
                                //     });
                                //     print(tuition);
                                //     // return null;
                                //   } else {
                                //     setState(() {
                                //       tuitions.tuition = respBody['tuition'];
                                //     });

                                //     print(respBody);
                                //   }
                              }
                            },
                            child: const Text('Buscar')),
                      )
                    : Container(),
              ],
            );
          });
}
