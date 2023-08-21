// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sistema_escolar_prepa/Services/Services.dart';
// import 'package:sistema_escolar_prepa/Services/group_services.dart';
// import 'package:sistema_escolar_prepa/providers/menu_option_provider.dart';

// import '../Services/horario_services.dart';
// import '../Services/student_services.dart';
// import '../Services/teacher_services.dart';
// import '../screen/group.dart';
// import '../screen/screen.dart';
// // 
// class Content extends StatelessWidget {
//   const Content({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
// //  intancia del provider

//     final menuProvider = Provider.of<MenuOptionProvider>(context);

//     final size = MediaQuery.of(context).size;
//     return Container(
//       margin: const EdgeInsets.all(10),
//       width: size.width * 0.73,

//       height: size.height * 52,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10), //border corner radius
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.2), //color of shadow
//             spreadRadius: 3, //spread radius
//             blurRadius: 4, // blur radius
//             offset: const Offset(0, 2), // changes position of shadow
//             //first paramerter of offset is left-right
//             //second parameter is top to down
//           ),
//         ],
//       ),
//       // child:
//       child: const Menus(),
//     );
//   }
// }

// class Menus extends StatelessWidget {
//   const Menus({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final menuProvider = Provider.of<MenuOptionProvider>(context);
//     final teacher = Provider.of<TeachaerServices>(context, listen: false);
//     final studentServies = Provider.of<StudentsServices>(context);
//     final groupServices = Provider.of<GroupServices>(context);

// // gel all mateira
//     final subjectServices = Provider.of<SubjectServices>(context);

//     switch (menuProvider.itemMenuGet) {
//       case 0:
//         return const ScreenHome();
//       case 1:
//         studentServies.getStudents();
//         return const ScreenStudent();

//       case 2:
//         // teacher.getTeachers();
//         return const ScreenTeacher();
//         break;
//       case 3:
//         // instance class HoraioServices
//         final horarioServices = Provider.of<HorarioServices>(context);
//         // horarioServices.allHorarios();

//         return const ScreenHorarios();
//       case 4:
//         // subjectServices.getSubjects();
//         return const SubjectsScreeen();
//       case 5:
//         // groupServices.allGroup();
//         return const ScreenGroup();

//       default:
//         return const ScreenHome();
//     }
//   }
// }
