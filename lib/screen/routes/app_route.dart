import 'package:flutter/material.dart';
import 'package:sistema_escolar_prepa/models/menu_option.dart';
import 'package:sistema_escolar_prepa/screen/group.dart';
import '../screen.dart';

class AppRoute {
  // haremos una modiificacion ala rutas en la cual la definoremos como una lista de
  // toos los menu de opciones
  static final routes = <OptionMenu>[
    // OptionMenu(
    //     route: 'home',
    //     icon: Icons.home,
    //     name: 'Home Page',
    //     screen: const HomePage()),
    OptionMenu(
        route: 'Students',
        icon: Icons.security_update_warning_sharp,
        name: 'Alumnos',
        screen: const ScreenStudent()),
    OptionMenu(
        route: '',
        icon: Icons.theater_comedy_sharp,
        name: 'Profresores',
        screen: const ScreenTeacher()),
    OptionMenu(
        route: 'Horarios',
        icon: Icons.horizontal_distribute_outlined,
        name: 'Horarios',
        screen: const ScreenHorarios()),
    OptionMenu(
        route: 'Materia',
        icon: Icons.subject_outlined,
        name: 'Materia',
        screen: const SubjectsScreeen()),

    // Button para la opcion del os grupos
    OptionMenu(
        route: 'Group',
        icon: Icons.group,
        name: 'Grupos',
        screen: const ScreenGroup())
  ];

  static const initialRoute = 'home';

  static Map<String, Widget Function(BuildContext)> routes2 = {
    'login': (context) => const ScreenHome(),
  };
}
