import 'package:flutter/material.dart';

class ScreenGroup extends StatelessWidget {
  const ScreenGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mi aplicación escolar',
          style: TextStyle(
            color: Colors.white, // Blanco
          ),
        ),
        backgroundColor: Colors.lightBlue[100], // Celeste
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.green[100], // Verde
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Bienvenido a nuestra',
                    style: TextStyle(
                      color: Colors.white, // Blanco
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'aplicación escolar',
                    style: TextStyle(
                      color: Colors.white, // Blanco
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Noticias',
                      style: TextStyle(
                        color: Colors.green, // Verde
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Horarios',
                      style: TextStyle(
                        color: Colors.green, // Verde
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Lógica del botón aquí
              },
              child: Text('Acceder al calendario'),
              style: ElevatedButton.styleFrom(
                primary: Colors.green, // Verde
              ),
            ),
          ],
        ),
      ),
    );
  }
}




// import 'package:flutter/material.dart';


// class ScreenGroup extends StatelessWidget {
//   const ScreenGroup({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
    
//   final Color colorBlancoCelesteVerde = Color.fromRGBO(0, 191, 255, 1.0);
//   final Color colorBlanco = Colors.white;
//   final Color colorCeleste = Colors.blue[300]!;
//   final Color colorVerde = Colors.green[600]!;
//     return MaterialApp(
//       title: 'Navigation Rail Example',
//       home: Scaffold(
//         appBar: AppBar(title: const Text('Mi Widget')),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Este es mi widget',
//               style: TextStyle(color: colorBlancoCelesteVerde),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 // Lógica del botón aquí
//               },
//               style: ElevatedButton.styleFrom(
//                 primary: colorBlancoCelesteVerde,
//               ),
//               child: Text(
//                 'Presioname',
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//             Container(
//               width: 100,
//               height: 100,
//               color: colorBlancoCelesteVerde,
//             ),
//             SizedBox(height: 16),
//             Text(
//               'Este es otro widget',
//               style: TextStyle(color: colorBlancoCelesteVerde),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 // Lógica del botón aquí
//               },
//               style: ElevatedButton.styleFrom(
//                 primary: colorBlancoCelesteVerde,
//               ),
//               child: Text(
//                 'Presioname',
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//             Container(
//               width: 100,
//               height: 100,
//               color: colorBlancoCelesteVerde,
//             ),

// // card 
// Card(
//       elevation: 4,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             height: 200,
//             width: double.infinity,
//             decoration: BoxDecoration(
//               color: Colors.lightBlue[100], // Celeste
//               image: DecorationImage(
//                 image: AssetImage('asset/horarios.png'),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Título de la tarjeta',
//                   style: TextStyle(
//                     color: Colors.white, // Blanco
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   'Descripción de la tarjeta',
//                   style: TextStyle(
//                     color: Colors.green, // Verde
//                     fontSize: 16,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Align(
//             alignment: Alignment.centerRight,
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: ElevatedButton(
//                 onPressed: () {
//                   // Lógica del botón aquí
//                 },
//                 child: Text('Mi botón'),
//                 style: ElevatedButton.styleFrom(
//                   primary: Colors.green, // Verde
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     )

//           ],
//         ),
//       ),
        
//         // body: Row(
//         //   children: <Widget>[
//         //     NavigationRail(
//         //       trailing: Container(height: 20, width:20, color: Colors.red),
//         //       extended: true,
//         //       destinations: [
//         //         NavigationRailDestination(
//         //           icon: Icon(Icons.favorite_border),
//         //           selectedIcon: Icon(Icons.favorite),
//         //           label: Text('First'),
//         //         ),
//         //         NavigationRailDestination(
//         //           icon: Icon(Icons.bookmark_border),
//         //           selectedIcon: Icon(Icons.book),
//         //           label: Text('Second'),
//         //         ),
//         //         NavigationRailDestination(
//         //           icon: Icon(Icons.star_border),
//         //           selectedIcon: Icon(Icons.star),
//         //           label: Text('Third'),
//         //         ),
//         //       ], selectedIndex: 0,
//         //     ),
//         //     VerticalDivider(thickness: 1, width: 1),
//         //     Expanded(
//         //       child: Center(
//         //         child: Text('Navigation Rail Example'),
//         //       ),
//         //     )
//         //   ],
//         // ),
//       ),
//     );
//   }
// }


// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import 'package:sistema_escolar_prepa/Services/generation_services.dart';
// // import 'package:sistema_escolar_prepa/Services/group_services.dart';
// // import 'package:sistema_escolar_prepa/models/group.dart';

// // import '../Services/semestre.dart';

// // class GroupScreen extends StatefulWidget {
// //   const GroupScreen({Key? key}) : super(key: key);

// //   @override
// //   State<GroupScreen> createState() => _GroupScreenState();
// // }

// // class _GroupScreenState extends State<GroupScreen> {
// //   @override
// //   Widget build(BuildContext context) {
// //     final generationServices = Provider.of<SemestreServices>(context);
// //     final groups = generationServices.groups;

// //     //     final data = generationServices.generation;
// //     //     final List<Group> groups = data['semestre'];

// //     // final groups = groupServices.groups;
// //     final size = MediaQuery.of(context).size;

// //     // creata  list group
// //     return Container(
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(8),
// //       ),
// //       child: Center(
// //         child: Column(children: [
// //           const SizedBox(
// //             height: 20,
// //           ),
// //           const Text(
// //             'Lista de los grupos',
// //             style: TextStyle(fontSize: 22, color: Colors.black),
// //           ),
// //           const SizedBox(
// //             height: 20,
// //           ),
// //           Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //             children: [
// //               Container(
// //                 color: Colors.red,
// //                 width: size.width * 0.15,
// //                 height: size.height * 0.8,
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.center,
// //                   mainAxisAlignment: MainAxisAlignment.center,
// //                   children: [
// //                     const SizedBox(
// //                       height: 10,
// //                     ),
// //                     MaterialButton(
// //                       color: Colors.blueAccent,
// //                       onPressed: () {
// //                         final generationServices =
// //                             Provider.of<GenerationServices>(context,
// //                                 listen: false);
// //                         generationServices.allGeneration();
// //                         openDialog(context, size);
// //                       },
// //                       child: const Text(
// //                         'SELECIONAR GENERACION',
// //                         style: TextStyle(fontSize: 12),
// //                       ),
// //                     ),
// //                     const SizedBox(
// //                       height: 10,
// //                     ),
// //                     MaterialButton(
// //                       color: Colors.blueAccent,
// //                       onPressed: () {},
// //                       child: const Text('AGERGAR GRUPO',
// //                           style: TextStyle(fontSize: 12)),
// //                     ),
// //                     const SizedBox(
// //                       height: 10,
// //                     ),
// //                     MaterialButton(
// //                       color: Colors.blueAccent,
// //                       onPressed: () {},
// //                       child: const Text('NOSE', style: TextStyle(fontSize: 12)),
// //                     )
// //                   ],
// //                 ),
// //               ),
// //               Container(
// //                   width: size.width * 0.5,
// //                   height: size.height * 0.8,
// //                   color: Colors.black,
// //                   child: Wrap(
// //                       children: List.generate(
// //                     groups.length,
// //                     (index) => GestureDetector(
// //                       onTap: () async {
// //                         final groupServices =
// //                             Provider.of<GroupServices>(context, listen: false);

// //                         await groupServices.getGroupForId(groups[index].id);

// //                         // pata mostrar el grupo de datos
// //                         openDataListGroup(context, size);
// //                       },
// //                       child: Container(
// //                         margin: const EdgeInsets.all(10),
// //                         width: 100,
// //                         height: 100,
// //                         decoration: BoxDecoration(
// //                           color: Colors.red,
// //                           borderRadius: BorderRadius.circular(10),
// //                         ),
// //                         child: Center(child: Text(groups[index].name)),
// //                       ),
// //                     ),
// //                   ))

// //                   // children:  group.map((e) => Chip(
// //                   //   avatar: CircleAvatar( child:Text(e), ),
// //                   //   label: Text(e))).toList(),
// //                   ),
// //             ],
// //           )
// //         ]),
// //       ),
// //     );
// //   }

// //   Future<String?> openDataListGroup(
// //     BuildContext context,
// //     Size size,
// //   ) {
// //     return showDialog<String>(
// //         // barrierColor: Colors.red[200], // color de fondo del dialong
// //         context: context,
// //         builder: (context) {
// //           List<StudentForSemestre> students = [];
// //           final groupServices = Provider.of<GroupServices>(context);
// //           final groups = groupServices.groupsForId;

// //           final List<dynamic> student = groups['students'];
// //           students = student.map((e) => StudentForSestre.fromMap(e)).toList();

// //           return SingleChildScrollView(
// //             child: AlertDialog(
// //               // contentPadding: const EdgeInsets.all(100),
// //               title: const Text("Agregar datos del alumno"),
// //               // content: const CreateDataStudent(),
// //               content: Container(
// //                 width: size.width * 0.7,
// //                 height: size.height * 0.7,

// //                 // color: Colors.white,
// //                 child: Center(
// //                   child: Container(
// //                     width: size.width * 0.6,
// //                     height: size.height * 0.6,
// //                     child: Column(
// //                       children: [
// //                         Text(groups['name']),
// //                          Row(
// //             children: [
// //               Container(
// //                 height: size.height * 0.7,
// //                 width: size.width * 0.24,
// //                 decoration: BoxDecoration(
// //                   // color: Colors.white,
// //                   borderRadius: BorderRadius.circular(10),
// //                 ),
// //                 child: ListView.builder(
// //                   controller: ScrollController(initialScrollOffset: 0),
// //                   // scrollDirection: Axis.vertical,
// //                   itemCount: students.length,
// //                   itemBuilder: (BuildContext context, int index) {
// //                     return ListTile(
// //                       leading: CircleAvatar(
// //                           child: Text(students[index].name.substring(0, 2))),
// //                       title: Text(students[index].name +
// //                           " " +
// //                           students[index].lastName +
// //                           " " +
// //                           students[index].secondName,  style: const TextStyle( fontSize: 13)),
// //                       subtitle: Text("NUMERO DE CONTROL: "+students[index].numberControl, style: const TextStyle( fontSize: 11)),
// //                       onTap: () {},
// //                     );
// //                   },
// //                 ),
// //               ),

// //               // segunda parte
// //               Container(
// //                 width: size.width * 0.3,
// //                 height: size.height * 0.7,
// //                 color: Colors.black12,
// //                 child: Padding(
// //                   padding: const EdgeInsets.all(8.0),
// //                   child: Column(

// //                       // mainAxisAlignment: MainAxisAlignment.center,
// //                       // crossAxisAlignment: CrossAxisAlignment.start,

// //                       children: [
// //                         Center(
// //                           child: CircleAvatar(
// //                             radius: 90.0,
// //                             backgroundColor: Colors.black,
// //                             child: Container(),
// //                           ),
// //                         ),

// //                         const SizedBox(
// //                           height: 20,
// //                         ),

// //                         Center(
// //                           child: Container(
// //                             decoration: BoxDecoration(
// //                               borderRadius: BorderRadius.circular(10),
// //                               // color: Colors.black,
// //                               color: Colors.transparent,
// //                             ),
// //                             child: Padding(
// //                               padding: const EdgeInsets.all(8.0),
// //                               child: Column(
// //                                   // crossAxisAlignment: CrossAxisAlignment.center,
// //                                   // mainAxisAlignment: MainAxisAlignment.center ,
// //                                   children: [
// //                                     const Text('Nombre : Roberto DIaz Bolanos'),
// //                                     Row(
// //                                       mainAxisAlignment:
// //                                           MainAxisAlignment.spaceBetween,
// //                                       children: const [
// //                                         Text('Sexo :Hombre'),
// //                                         Text('Fecha Nacimiento: 12/45/4003'),
// //                                       ],
// //                                     ),
// //                                     Row(
// //                                       mainAxisAlignment:
// //                                           MainAxisAlignment.spaceBetween,
// //                                       children: const [
// //                                         Text('tipo de Sangre : 0+'),
// //                                         Text('Crup: DDGDFGDFR54SFS'),
// //                                       ],
// //                                     ),
// //                                     Row(
// //                                       mainAxisAlignment:
// //                                           MainAxisAlignment.spaceBetween,
// //                                       children: const [
// //                                         Text('Edad : 89'),
// //                                         Text(
// //                                             'direccion: Cuarta poneitne sur 17'),
// //                                       ],
// //                                     ),
// //                                     Row(
// //                                       mainAxisAlignment:
// //                                           MainAxisAlignment.spaceBetween,
// //                                       children: const [
// //                                         Text('Telefono: 9293454565'),
// //                                         Text('N Comtrol '),
// //                                       ],
// //                                     ),
// //                                     Row(
// //                                       mainAxisAlignment:
// //                                           MainAxisAlignment.spaceBetween,
// //                                       children: const [
// //                                         Text('Tututor: Jaime Hernandez Yong'),
// //                                         Text('N Comtrol '),
// //                                       ],
// //                                     )
// //                                   ]),
// //                             ),
// //                           ),
// //                         ), //

// //                         const Spacer(),
// //                         MaterialButton(
// //                             color: Colors.blue,
// //                             child: const Text('Editar'),
// //                             onPressed: () {})
// //                       ]),
// //                 ),
// //               ),
// //             ],
// //           )
// //                       ],
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //               actions: [
// //                 MaterialButton(
// //                   shape: RoundedRectangleBorder(
// //                     borderRadius: BorderRadius.circular(5),
// //                   ),
// //                   child: const Text('GUARDAR'),
// //                   onPressed: () {
// //                     Navigator.pop(context);
// //                   },
// //                 )
// //               ],
// //             ),
// //           );
// //         });
// //   }

// //   Future<String?> openDialog(
// //     BuildContext context,
// //     Size size,
// //   ) =>
// //       showDialog<String>(
// //           // barrierColor: Colors.red[200], // color de fondo del dialong
// //           context: context,
// //           builder: (context) {
// //             final generationServices = Provider.of<GenerationServices>(context);
// //             final generations = generationServices.generations;

// //             return SingleChildScrollView(
// //               child: AlertDialog(
// //                 // contentPadding: const EdgeInsets.all(100),
// //                 title: const Text("Agregar datos del alumno"),
// //                 // content: const CreateDataStudent(),
// //                 content: Container(
// //                     width: size.width * 0.7,
// //                     height: size.height * 0.7,

// //                     // color: Colors.white,
// //                     child: Center(
// //                       child: Wrap(
// //                         children: List.generate(
// //                             generations.length,
// //                             (index) => GestureDetector(
// //                                   onTap: () {
// //                                     final generationServices =
// //                                         Provider.of<GenerationServices>(context,
// //                                             listen: false);
// //                                     generationServices
// //                                         .getGroupSemestreForGeneration(
// //                                             generations[index].uid);
// //                                     print('Generacion seleccionado');

// //                                     Navigator.pop(context);
// //                                     openListSemestre(context, size);
// //                                   },
// //                                   child: Container(
// //                                     margin: const EdgeInsets.all(10),
// //                                     width: 200,
// //                                     // height: 100,
// //                                     color: Colors.black12,
// //                                     child: Padding(
// //                                       padding: const EdgeInsets.all(8.0),
// //                                       child: Center(
// //                                         child: Text(generations[index]
// //                                                 .initialDate
// //                                                 .toString()
// //                                                 .substring(0, 10) +
// //                                             " - " +
// //                                             generations[index]
// //                                                 .finalDate
// //                                                 .toString()
// //                                                 .substring(0, 10)),
// //                                       ),
// //                                     ),
// //                                   ),
// //                                 )).toList(),
// //                       ),
// //                     )),
// //                 actions: [
// //                   MaterialButton(
// //                     shape: RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.circular(5),
// //                     ),
// //                     child: const Text('GUARDAR'),
// //                     onPressed: () {
// //                       Navigator.pop(context);
// //                     },
// //                   )
// //                 ],
// //               ),
// //             );
// //           });

// //   Future<String?> openListSemestre(
// //     BuildContext context,
// //     Size size,
// //   ) =>
// //       showDialog<String>(
// //           // barrierColor: Colors.red[200], // color de fondo del dialong
// //           context: context,
// //           builder: (context) {
// //             final generationServices = Provider.of<GenerationServices>(context);
// //             final semestres = generationServices.semestres;

// //             return SingleChildScrollView(
// //               child: AlertDialog(
// //                 // contentPadding: const EdgeInsets.all(100),
// //                 title: const Text("Agregar datos del alumno"),
// //                 // content: const CreateDataStudent(),
// //                 content: Container(
// //                     width: size.width * 0.7,
// //                     height: size.height * 0.7,

// //                     // color: Colors.white,
// //                     child: Center(
// //                       child: Wrap(
// //                         children: List.generate(
// //                             semestres.length,
// //                             (index) => GestureDetector(
// //                                   onTap: () {
// //                                     // final generationServices =
// //                                     //     Provider.of<GenerationServices>(context,
// //                                     //         listen: false);
// //                                     // generationServices
// //                                     //     .getGroupSemestreForGeneration(
// //                                     //         semestres[index].uid);
// //                                     // print('Generacion seleccionado');

// //                                     final semestreServices =
// //                                         Provider.of<SemestreServices>(context,
// //                                             listen: false);
// //                                     semestreServices
// //                                         .allsemsetreForId(semestres[index].uid);

// //                                     Navigator.pop(context);
// //                                   },
// //                                   child: Container(
// //                                     margin: const EdgeInsets.all(10),
// //                                     width: 200,
// //                                     // height: 100,
// //                                     color: Colors.black12,
// //                                     child: Padding(
// //                                       padding: const EdgeInsets.all(8.0),
// //                                       child: Center(
// //                                         child: Column(
// //                                           children: [
// //                                             Text(semestres[index].name),
// //                                             Text(semestres[index]
// //                                                     .initialDate
// //                                                     .toString()
// //                                                     .substring(0, 10) +
// //                                                 " - " +
// //                                                 semestres[index]
// //                                                     .endDate
// //                                                     .toString()
// //                                                     .substring(0, 10)),
// //                                           ],
// //                                         ),
// //                                       ),
// //                                     ),
// //                                   ),
// //                                 )).toList(),
// //                       ),
// //                     )),
// //                 actions: [
// //                   MaterialButton(
// //                     shape: RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.circular(5),
// //                     ),
// //                     child: const Text('GUARDAR'),
// //                     onPressed: () {
// //                       Navigator.pop(context);
// //                     },
// //                   )
// //                 ],
// //               ),
// //             );
// //           });
// // }
