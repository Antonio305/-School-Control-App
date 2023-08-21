import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_escolar_prepa/Services/horario_services.dart';

import '../Services/login_provider.dart';
import '../Services/subject_services.dart';
import '../providers/thme_provider.dart';
import '../shared_preferences.dart/shared_preferences.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final preferences = Preferences();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Drawer(
      // elevation: 1,
      semanticLabel: 'Chales',
      width: Platform.isWindows || Platform.isMacOS
          ? size.width * 0.2
          : size.width * 0.7,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Container(
          // height: size.height * 0.7,
          decoration: BoxDecoration(
              // color: Colors.red,
              borderRadius: BorderRadius.circular(15)),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const Text('Preparatoria'),
                const Text('Rafael Pascacion Gamboa'),

                const SizedBox(
                  height: 15,
                ),

                // logo de la prepa
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    // color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.asset('asset/prepa_logo.png')
                ),

                const SizedBox(
                  height: 10,
                ),
                Container(
                    color: Colors.black38, height: 1, width: size.width * 0.7),
                const SizedBox(
                  height: 15,
                ),

                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: ListTile(
                    hoverColor: Colors.blue,
                    minVerticalPadding: 2,
                    shape: RoundedRectangleBorder(
                        side:
                            const BorderSide(width: 0.5, color: Colors.black12),
                        borderRadius: BorderRadius.circular(15)),
                    leading: SizedBox(
                        width: 35,
                        height: 35,
                        child: Image.asset('asset/student.png')),

                    // const Icon(
                    //   Icons.home_max_outlined,
                    //   size: 20,
                    // ),
                    title: const Text(
                      'Alumnos',
                      style: TextStyle(fontSize: 14),
                    ),
                    autofocus: true,
                    onTap: () {
                      Navigator.pushNamed(context, 'student');
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                        side:
                            const BorderSide(width: 0.5, color: Colors.black12),
                        borderRadius: BorderRadius.circular(15)),
                    leading: SizedBox(
                        width: 35,
                        height: 35,
                        child: Image.asset('asset/teacher.png')),

                    // const Icon(
                    //   Icons.home_max_outlined,
                    //   size: 20,
                    // ),
                    title: const Text('Profesores',
                        style: TextStyle(fontSize: 14)),
                    autofocus: true,
                    onTap: () {
                      Navigator.pushNamed(context, 'teachers');
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                        side:
                            const BorderSide(width: 0.5, color: Colors.black12),
                        borderRadius: BorderRadius.circular(15)),
                    leading: SizedBox(
                        width: 35,
                        height: 35,
                        child: Image.asset('asset/horarios.png')),

                    //  const Icon(
                    //   Icons.home_max_outlined,
                    //   size: 20,
                    // ),
                    title:
                        const Text('Horarios', style: TextStyle(fontSize: 14)),
                    autofocus: true,
                    onTap: () {
                      final horarioServices =
                          Provider.of<HorarioServices>(context, listen: false);
                      horarioServices.allHorarios();
                      Navigator.pushNamed(context, 'horarios');
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                        side:
                            const BorderSide(width: 0.5, color: Colors.black12),
                        borderRadius: BorderRadius.circular(15)),
                    leading: SizedBox(
                        width: 35,
                        height: 35,
                        child: Image.asset('asset/subject.png')),

                    // const Icon(
                    //   Icons.home_max_outlined,
                    //   size: 20,
                    // ),
                    title:
                        const Text('Materia', style: TextStyle(fontSize: 14)),
                    autofocus: true,
                    onTap: () {
                      // hacemos la instancia  para cargar la materia
                      final subjectServices =
                          Provider.of<SubjectServices>(context, listen: false);
                      subjectServices.getSubjects();
                      Navigator.pushNamed(context, 'subjects');
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                        side:
                            const BorderSide(width: 0.5, color: Colors.black12),
                        borderRadius: BorderRadius.circular(15)),
                    leading: const Icon(
                      Icons.group,
                      size: 20,
                    ),
                    title: const Text('Grupos', style: TextStyle(fontSize: 14)),
                    autofocus: true,
                    onTap: () {
                      Navigator.pushNamed(context, 'groups');
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                        side:
                            const BorderSide(width: 0.5, color: Colors.black12),
                        borderRadius: BorderRadius.circular(15)),
                    leading: SizedBox(
                        width: 35,
                        height: 35,
                        child: Image.asset('asset/news.png')),

                    //  const Icon(
                    //   Icons.home_max_outlined,
                    //   size: 20,
                    // ),
                    title: const Text('Publicaciones',
                        style: TextStyle(fontSize: 14)),
                    autofocus: true,
                    onTap: () {
                      Navigator.pushNamed(context, 'publicaciones');
                    },
                  ),
                ),

                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'adviser_tutor');
                    },
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Text('Tutores'),
                    )),

                const SizedBox(
                  height: 20,
                ),

                // Platform.isAndroid || Platform.isIOS
                //     ? SizedBox(
                //         child: Column(children: [
                          Container(
                              color: Colors.black38,
                              height: 1,
                              width: size.width * 0.7),
                          const SizedBox(
                            height: 10,
                          ),
                          SwitchListTile.adaptive(
                              title: const Text('Tema'),
                              value: preferences.getIsDarkMode,
                              // value: isDarkMode,
                              onChanged: (bool? value) {
                                preferences.setIsDarkMode = value!;
                                final themeProvider = Provider.of<ThemeProvier>(
                                    context,
                                    listen: false);
                                // isDarkMode = value;
                                value
                                    ? themeProvider.setDarkMode()
                                    : themeProvider.setLightMode();

                                setState(() {});
                              }),
                          const SizedBox(height: 35),
                          Center(
                            child: MaterialButton(
                              onPressed: () async {
                                final loginServices =
                                    Provider.of<LoginServices>(context,
                                        listen: false);
                                await loginServices.logout();
                                // despues iremos  al login para el nuevo inicio de sesion

                                Navigator.pushReplacementNamed(
                                    context, 'login');
                              },
                              color: Colors.blueAccent,
                              child: const Text('CERRAR SESION'),
                            ),
                          )
                    //     ]),
                    //   )
                    // : Container(),

                // botor para salir del programa
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BuldListTile extends StatelessWidget {
  final Function onTaps;
  final IconData iconData;
  final String text;

  const BuldListTile(
      {Key? key,
      required this.onTaps,
      required this.iconData,
      required this.text})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: ListTile(
        shape: RoundedRectangleBorder(
            side: const BorderSide(width: 0.5, color: Colors.black12),
            borderRadius: BorderRadius.circular(15)),
        leading: CircleAvatar(
          backgroundColor: Colors.black38,
          child: Icon(iconData),
        ),
        title: const Text('Alumnos'),
        autofocus: true,
        onTap: onTaps(),
      ),
    );
  }
}
