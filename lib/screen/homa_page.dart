import 'dart:io';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:blobs/blobs.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:provider/provider.dart';
import 'package:sistema_escolar_prepa/Services/Services.dart';
import 'package:sistema_escolar_prepa/Services/chat/socket_servives.dart';
import 'package:sistema_escolar_prepa/Services/story_servies.dart';
import '../models/story.dart';
import '../providers/show_dialog_by_grades.dart';
import '../widgets/drawer.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);

//
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      // appBar: _appBar(),
      // drawer: const MyDrawer(),
      body: Platform.isMacOS || Platform.isWindows
          ? Row(
              // botones de lavegacio del  lado izquirdo
              children: [
                  // Menu(),
                  const MyDrawer(),
                  BuildHome(size: size)
                  // este cambia segun  las opcioens
                  // const Content(),
                ])
          : SafeArea(child: BuildHome(size: size)),
    );
  }

  AppBar _appBar() {
    return AppBar(
      // flexibleSpace: Container(
      //   decoration: BoxDecoration(wel
      //     color: Color.fromRGBO(62, 66, 107, 0.9),
      //     // color:Colors.transparent,
      //     borderRadius: BorderRadius.circular(20),
      //     gradient:  const LinearGradient(
      //         begin: Alignment.topLeft,
      //       end: Alignment.bottomRight,
      //       colors: [
      //      Color.fromRGBO(62, 66, 107, 0.9),
      //        ui.Color.fromARGB(255, 178, 175, 206)],
      //     ),
      //   ),
      // ),

      // backgroundColor: Colors.blue, // color que tenia definido

      // backgroundColor: ui.Color.fromARGB(255, 98, 107, 211),

      // backgroundColor: ui.Color.fromARGB(255, 48, 58, 173),  // este me gusa

      // backgroundColor: Color(0xFF1A237E),
      title: const Text('Prepa Bochil'),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
    );
  }
}

class BuildHome extends StatefulWidget {
  const BuildHome({
    Key? key,
    required this.size,
  }) : super(key: key);

  final ui.Size size;

  @override
  State<BuildHome> createState() => _BuildHomeState();
}

class _BuildHomeState extends State<BuildHome> {
//  funcin par cargar las historias

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onLoading();
  }

  @override
  Widget build(BuildContext context) {
    //  instancia de la clase

    final userTeacher = Provider.of<TeachaerServices>(context);
    final teacher = userTeacher.teacherForID;
    final size = MediaQuery.of(context).size;

    final storyServices = Provider.of<StoryServices>(context);
    final socketS = Provider.of<SocketService>(context, listen: false);
    socketS.connect();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        width: Platform.isMacOS || Platform.isWindows
            ? size.width * .74
            : size.width,
        child: SingleChildScrollView(
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 30),

              Platform.isAndroid || Platform.isIOS
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Buenos dias:',
                            style: TextStyle(fontSize: 22)),
                        Text(
                            teacher.name +
                                " " +
                                teacher.secondName +
                                " " +
                                teacher.lastName,
                            style: const TextStyle(fontSize: 18)),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Buenos dias:',
                                style: TextStyle(fontSize: 22)),
                            Text(
                                teacher.name +
                                    " " +
                                    teacher.secondName +
                                    " " +
                                    teacher.lastName,
                                style: const TextStyle(fontSize: 18)),
                          ],
                        ),
                        // Switch.adaptive(value: false, onChanged: (status) {}),

                        Row(
                          children: [
                            Container(
                              // color: Colors.red,

                              margin: const EdgeInsets.only(right: 15),
                              // falta co cofigurcion si tenemos coneccion o no
                              child: socketS.serverStatus == ServerStatus.Online
                                  ? const Icon(Icons.check_circle,
                                      color: Colors.black)
                                  : const Icon(Icons.offline_bolt,
                                      color: Colors.white),
                            ),
                            SizedBox(
                              width: 200,
                              child: SwitchListTile(
                                  title: Text('Tema Oscuro'),
                                  value: false,
                                  onChanged: (value) {}),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 0),
                              child: MaterialButton(
                                // color: CupertinoDynamicColor.withBrightness(color: Colors.blue, darkColor: Colors.red),
                                elevation: 5,
                                onPressed: () {
                                  // par aconectar con el socket

                                  socketS.connect();

                                  print('conectando el socket con el button ');

                                  // showDialog(
                                  //   context: context,
                                  //   builder: (BuildContext context) {
                                  //     return AlertDialog(
                                  //       title: Text('Cerrar sesión'),
                                  //       content: Text(
                                  //           '¿Estás seguro de que quieres cerrar sesión?'),
                                  //       actions: <Widget>[
                                  //         TextButton(
                                  //           child: Text('Cancelar'),
                                  //           onPressed: () {
                                  //             Navigator.of(context).pop();
                                  //           },
                                  //         ),
                                  //         TextButton(
                                  //           child: Text('Aceptar'),
                                  //           onPressed: () {
                                  //             // Código para cerrar sesión
                                  //             Navigator.of(context).pop();
                                  //           },
                                  //         ),
                                  //       ],
                                  //     );
                                  //   },
                                  // );
                                },
                                child: const Text('Cerrar Sesion'),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
              const SizedBox(height: 30),
              Platform.isAndroid || Platform.isIOS
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _Story(size: size),
                        const SizedBox(height: 20),
                        Card(
                          // color: Colors.blue.withOpacity(0.5),
                          child: SizedBox(
                            // width: double.infinity,
                            width: size.width * 0.97,
                            height: 300,
                            // color: Colors.red,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment:
                                    CrossAxisAlignment.stretch, // horizontal
                                children: [
                                  Center(child: Text('Historias:')),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, 'create_story');
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        width: size.width * 0.97,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          // crossAxisAlignment:
                                          //     CrossAxisAlignment.baseline,
                                          children: const [
                                            CircleAvatar(
                                              child: Icon(Icons.abc),
                                            ),
                                            Center(
                                                child: Text('Crear Historias')),
                                            Icon(
                                              Icons.arrow_right_outlined,
                                              size: 35,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      // Navigator.pushNamed(context, 'create_story');
                                      storyServices.getAllStory();
                                      final storys = storyServices.storys;
                                      String story = "allStorys";
                                      Navigator.pushNamed(context, 'list_story',
                                          arguments: story);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: const [
                                          CircleAvatar(
                                            child: Icon(Icons.abc),
                                          ),
                                          Center(
                                              child: Text('Todas Historias')),
                                          Icon(
                                            Icons.arrow_right_outlined,
                                            size: 35,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      storyServices.getAllStoryByStatusTrue();

                                      String story = "allStorysByStatus";

                                      Navigator.pushNamed(context, 'list_story',
                                          arguments: story);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: const [
                                          CircleAvatar(
                                            child: Icon(Icons.abc),
                                          ),
                                          Center(
                                              child: Text('Historias Activas')),
                                          Icon(
                                            Icons.arrow_right_outlined,
                                            size: 35,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _Story(size: size),
                        Card(
                          // color: Colors.blue.withOpacity(0.5),
                          child: SizedBox(
                            width: 300,
                            height: 340,
                            // color: Colors.red,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment:
                                    CrossAxisAlignment.stretch, // horizontal
                                children: [
                                  Center(child: Text('Historias:')),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, 'create_story');
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: const [
                                          CircleAvatar(
                                            child: Icon(Icons.abc),
                                          ),
                                          Center(
                                              child: Text('Crear Historias')),
                                          Icon(
                                            Icons.arrow_right_outlined,
                                            size: 35,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      // Navigator.pushNamed(context, 'create_story');
                                      storyServices.getAllStory();
                                      final storys = storyServices.storys;
                                      String story = "allStorys";
                                      Navigator.pushNamed(context, 'list_story',
                                          arguments: story);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: const [
                                          CircleAvatar(
                                            child: Icon(Icons.abc),
                                          ),
                                          Center(
                                              child: Text('Todas Historias')),
                                          Icon(
                                            Icons.arrow_right_outlined,
                                            size: 35,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      storyServices.getAllStoryByStatusTrue();

                                      String story = "allStorysByStatus";

                                      Navigator.pushNamed(context, 'list_story',
                                          arguments: story);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: const [
                                          CircleAvatar(
                                            child: Icon(Icons.abc),
                                          ),
                                          Center(
                                              child:
                                                  Text('Historias Historias')),
                                          Icon(
                                            Icons.arrow_right_outlined,
                                            size: 35,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
              const SizedBox(height: 10),
              const Text('Alumnos con calificaciones'),
              const SizedBox(height: 10),

              // opcion para los estudiantes

              const _optionStudent(),

              const SizedBox(height: 15),

              const Text('Total de alumnos'),
              const SizedBox(height: 15),

// Mostrar algunas graficas

              SizedBox(
                  height: 180,
                  width: size.width,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Card(
                        elevation: 10,
                        child: SizedBox(
                            height: 180,
                            width: Platform.isMacOS || Platform.isWindows
                                ? 360
                                : 320,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Column(
                                children: [
                                  const Text('Ultimas tres generaciones'),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Card(
                                        color: Colors.blue.withOpacity(0.5),
                                        elevation: 8,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          child: Column(
                                            children: [
                                              Text('2020 - 2023'),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text('403'),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Card(
                                        elevation: 8,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          child: Column(
                                            children: [
                                              Text('2020 - 2023'),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text('896'),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Card(
                                        elevation: 8,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          child: Column(
                                            children: [
                                              Text('2020 - 2023'),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text('200'),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )),
                      ),
                      Container(
                        height: 180,
                        width: 200,
                        // color: Colors.red,
                      ),
                    ],
                  )),

              const Text('Actividad de profesores.'),

              // _noseanunm()
            ],
          ),
        ),
      ),
    );
  }

  void onLoading() async {
    final storyServices = Provider.of<StoryServices>(context, listen: false);

    await storyServices.getAllStoryByStatusTrue();

    // final groupServices = Provider.of<GroupServices>(context, listen: false);
    // final generationServices =
    //     Provider.of<GenerationServices>(context, listen: false);
    // final subjectServices =
    //     Provider.of<SubjectServices>(context, listen: false);

    // // FIRST GET INFIRMATION TEACHER
    // final teachaerServices =
    //     Provider.of<TeachaerServices>(context, listen: false);

    // final semestreServices =
    //     Provider.of<SemestreServices>(context, listen: false);

    // await subjectServices.getSubjectsForTeacher();

    // // print(subject);
    // await generationServices.allGeneration();
    // await semestreServices.allSemestre();

    // await groupServices.getGroupForId();
    // await teachaerServices.getForId();
  }
}

class _noseanunm extends StatelessWidget {
  const _noseanunm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Image.network(
            'https://via.placeholder.com/150',
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 10),
          const Text(
            'Actividad de Profesores',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Descripción de la actividad de profesores',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Icon(Icons.calendar_today),
              const Text('Fecha: 01/04/2023'),
              const Icon(Icons.access_time),
              const Text('Hora: 9:00 AM'),
            ],
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Registrarse'),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class _optionStudent extends StatelessWidget {
  const _optionStudent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    const linearGradient = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          // Colors.white,
          ui.Color.fromARGB(255, 160, 147, 235),
          ui.Color.fromARGB(255, 113, 97, 202),

          ui.Color.fromARGB(255, 112, 97, 196),
        ],
        stops: [
          0.2,
          0.6,
          0.3
        ]);
    const boxDecoration = BoxDecoration(
      color: ui.Color.fromARGB(255, 112, 97, 196),

      // color: ui.Color.fromARGB(255, 71, 45, 219),
      gradient: linearGradient,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          topRight: Radius.circular(5),
          bottomRight: Radius.circular(5)),
    );
    const textStyle = TextStyle(
        // fontWeight: FontWeight.bold,
        // fontStyle: FontStyle.normal,
        fontSize: 15);
    return SizedBox(
      height: 150,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                ListDialogByStudent.selectedParcial(context, size, 1);
              },
              child: Card(
                elevation: 5,
                child: SizedBox(
                  width: 220,
                  height: 150,
                  // decoration: boxDecoration,
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                          width: 70,
                          height: 70,
                          child: Image.asset('asset/rating_student.png')),
                      const Text('Mejores Caliicaciones', style: textStyle),
                    ],
                  )),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                ListDialogByStudent.selectedParcial(context, size, 2);
              },
              child: Card(
                child: SizedBox(
                  width: 200,
                  height: 200,
                  // decoration: const BoxDecoration(
                  //   gradient: linearGradient,
                  //   color: Colors.blue,
                  //   borderRadius: BorderRadius.only(
                  //     topLeft: Radius.circular(5),
                  //     bottomLeft: Radius.circular(5),
                  //     topRight: Radius.circular(5),
                  //     bottomRight: Radius.circular(5),
                  //   ),
                  // ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                            width: 70,
                            height: 70,
                            child: Image.asset('asset/rating_student.png')),
                        const Text(
                          'Calificaciones regulares',
                          style: textStyle,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                ListDialogByStudent.selectedParcial(context, size, 3);
              },
              child: Card(
                child: SizedBox(
                  width: 200,
                  height: 200,
                  // decoration: const BoxDecoration(
                  //   gradient: linearGradient,
                  //   // color: Colors.blue,
                  //   borderRadius: BorderRadius.only(
                  //     topLeft: Radius.circular(5),
                  //     bottomLeft: Radius.circular(5),
                  //     topRight: Radius.circular(20),
                  //     bottomRight: Radius.circular(20),
                  //   ),
                  // ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                            width: 70,
                            height: 70,
                            child: Image.asset('asset/rating_student.png')),
                        const Text('Caliicaciones Bajas', style: textStyle),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// ignore: camel_case_types
class _Story extends StatefulWidget {
  const _Story({
    Key? key,
    required this.size,
  }) : super(key: key);

  final ui.Size size;

  @override
  State<_Story> createState() => _StoryState();
}

class _StoryState extends State<_Story> {
  // create list types Storys
  List<Storys> storys = [];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    final storyServices = Provider.of<StoryServices>(context);
    storys = storyServices.storysByStatusTrue;

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border:
              Border.all(width: 0.5, color: Colors.white70.withOpacity(0.1))),
      width: Platform.isAndroid || Platform.isIOS
          ? widget.size.width * 0.96
          : widget.size.width / 2.2,
      height: Platform.isAndroid || Platform.isIOS
          ? widget.size.height * 0.3
          : widget.size.height * 0.5,
      child: storys.isEmpty
          ? Center(child: const Text('No hay hostoarias que mostrar'))
          : CardSwiper(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              // threshold: 20,
              // maxAngle: 10,
              numberOfCardsDisplayed: 1,
              // isHorizontalSwipingEnabled: true,
              direction: CardSwiperDirection.left,
              cardsCount: storys.length,
              cardBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                          width: 0.5, color: Colors.white70.withOpacity(0.1))),
                  width: widget.size.width / 2.2,
                  height: widget.size.height * 0.5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: storys[index].archivos == null
                        ? Center(
                            child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('No Image'),
                                Text(
                                  storys[index].data!,
                                  style: const TextStyle(fontSize: 20),
                                )
                              ],
                            ),
                          ))
                        : Image.network(
                            // 'https://prepabochil.fly.dev/api/uploadFile/${storys[index].id}/story',

                            // 'http://192.168.1.78:3000/api/uploadFile/${storys[index].id}/story',ç
                            'https://www.staffcreativa.pe/blog/wp-content/uploads/facebook-cineplanet.jpg',
                            fit: BoxFit.fill,
                          ),

                    //  Image.network(
                    //     'http://192.168.1.71:8080/api/uploadFile/${storys[index].id}/story',
                    //     fit: BoxFit.fill,
                    //   ),
                  ),
                );
              }),
    );
  }
}

class BlobPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final path = Path()
      ..moveTo(size.width / 2, size.height / 2)
      ..quadraticBezierTo(
          size.width * 0.75, size.height * 0.25, size.width, size.height / 2)
      ..quadraticBezierTo(
          size.width * 0.75, size.height * 0.75, size.width / 2, size.height)
      ..quadraticBezierTo(
          size.width * 0.25, size.height * 0.75, 0, size.height / 2)
      ..quadraticBezierTo(size.width * 0.25, size.height * 0.25, size.width / 2,
          size.height / 4)
      ..close();

    canvas.drawPath(path, paint);
    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), size.width / 2, borderPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

// par la animacin pero quita mucha memoria ram
class PainertCircle extends StatefulWidget {
  const PainertCircle({
    Key? key,
  }) : super(key: key);

  final bool reverse = true;
  @override
  State<PainertCircle> createState() => _PainertCircleState();
}

class _PainertCircleState extends State<PainertCircle>
    with TickerProviderStateMixin {
// imagen
  ui.Image? image;

// creamos el controlador de las animacinoes
  AnimationController? controller1;
  AnimationController? controller2;

// animation
  Animation<double>? animation1;
  Animation<double>? animation2;

  @override
  void initState() {
    super.initState();
    initAnimations();
    // final imagen = Image.asset('asset/control.gif');
    _loadImage('asset/control.gif');
    // _loadImage(imagen);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller1!.dispose();
    controller2!.dispose();
    super.dispose();
  }

  // metodo para iniciar las  animationes
  void initAnimations() {
    // inicializacion del controlador de las animaciones
    controller1 =
        AnimationController(duration: const Duration(seconds: 4), vsync: this);
    controller2 =
        AnimationController(duration: const Duration(seconds: 4), vsync: this);

    // inicializacio nde las animaciones

    animation1 = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: controller1!,
        curve: const Interval(0.0, 1.0, curve: Curves.linear)));

    final secondAnimation = Tween<double>(begin: -1.0, end: 0.0).animate(
        CurvedAnimation(
            parent: controller2!,
            curve: const Interval(0.0, 1.0, curve: Curves.linear)));

    widget.reverse
        ? animation2 = ReverseAnimation(secondAnimation)
        : animation2 = secondAnimation;

    // repetimos las animaciones
    controller2!.repeat();
    controller1!.repeat();
  }

  // cargamos la iamgen con un fucture
  // String imagePath = Image.asset('asset/control.gif') as String;

  Future _loadImage(String imagePath) async {
    final ByteData data = await rootBundle.load(imagePath);
    final bytes = data.buffer.asUint8List();

    // final codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),

    // obteneomso la imgen
    final image = await decodeImageFromList(bytes);
    setState(() {
      this.image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _fistArc(),
        _secondArc(),
        Container(
          width: 330,
          height: 330,
          child: Center(
              child: Image.asset(
            'asset/prepa.gif',
            width: 220,
            height: 220,
          )),
        ),
      ],
    );
  }

  Center _secondArc() {
    return Center(
      // color: Colors.blue,

      child: image == null
          ? const CircularProgressIndicator.adaptive()
          : RotationTransition(
              turns: animation1!,
              child: CustomPaint(
                painter: CirclePainter(
                    color: Colors.black, iconsSize: 5, image: image!),
                //toma el valor del hijo
                child: Container(
                  width: 330,
                  height: 330,
                ),
              ),
            ),
    );
  }

  Center _fistArc() {
    return Center(
      // color: Colors.blue,
      child: image == null
          ? const CircularProgressIndicator.adaptive()
          : RotationTransition(
              turns: animation2!,
              child: CustomPaint(
                painter: CirclePainter(
                    color: Colors.black, iconsSize: 5, image: image!),
                //toma el valor del hijo
                child: Container(
                  width: 370,
                  height: 370,
                ),
              ),
            ),
    );
  }
}

// clase para el CustomPainer

class CirclePainter extends CustomPainter {
  // controladoe para las  animacinoes

  // defiimos Propiedade com
  final Color color;
  final double iconsSize;

  final ui.Image image;

  CirclePainter({required this.color, this.iconsSize = 3, required this.image});

  @override
  void paint(Canvas canvas, Size size) {
    // dibujamos el lapiz

    Paint paint = Paint()
      ..color = color // color de la linea
      ..strokeWidth = 1 // ancho de la linea
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke; // tipo de lapizs

    // dibujamos
    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    // canvas.drawArc(rect, 0, 2 * pi, false, paint);
    canvas.drawArc(rect, 0.15, 0.9 * pi, false, paint);
    canvas.drawArc(rect, 1.05 * pi, 0.9 * pi, false, paint);
    // canvas.drawArc(rect, 1.46 * pi, 0.47 * pi, false, paint);

    // draw the cross
    final centerY = size.width / 2;
    canvas.drawLine(Offset(-3, centerY - 3), Offset(3, centerY + 3), paint);
    canvas.drawLine(Offset(3, centerY - 3), Offset(-3, centerY + 3), paint);

    canvas.drawCircle(Offset(size.width, size.width / 2), 3, paint);

    // canvas.drawImage(image, Offset(size.width, size.width / 3), paint);
    // canvas.drawImage(image , Offset(3, centerY - 3), paint);
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) => false;

//   @override
//   bool shouldRebuildSemantics(namePainter oldDelegate) => false;
}

class Actividades extends StatelessWidget {
  const Actividades({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: size.width * 0.133,
        height: size.height * 0.14,
        decoration: BoxDecoration(
          // color: Colors.black12,

          borderRadius: BorderRadius.circular(10),
          color: const Color.fromARGB(255, 62, 29, 212),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: const [
              Text('Numero de alumnos'),
              SizedBox(
                height: 20,
              ),
              Text('45.00'),
            ],
          ),
        ),
      ),
    );
  }
}
