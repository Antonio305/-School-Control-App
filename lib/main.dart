import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_escolar_prepa/Services/file_services.dart';
import 'package:sistema_escolar_prepa/Services/horario_services.dart';
import 'package:sistema_escolar_prepa/Services/publication_services.dart';
import 'package:sistema_escolar_prepa/Services/rating_sevices.dart';
import 'package:sistema_escolar_prepa/Services/story_servies.dart';
import 'package:sistema_escolar_prepa/Services/tuition_services.dart';
import 'package:sistema_escolar_prepa/providers/form_provider.dart';
import 'package:sistema_escolar_prepa/providers/menu_option_provider.dart';
import 'package:sistema_escolar_prepa/providers/thme_provider.dart';

import 'package:sistema_escolar_prepa/screen/check_auth_screen.dart';
import 'package:sistema_escolar_prepa/screen/create_adiviser.dart';
import 'package:sistema_escolar_prepa/screen/create_story.dart';
import 'package:sistema_escolar_prepa/screen/edit_students.dart';
import 'package:sistema_escolar_prepa/screen/information_subject.dart';
import 'package:sistema_escolar_prepa/screen/list_adviserTutors.dart';
import 'package:sistema_escolar_prepa/screen/list_storys.dart';
import 'package:sistema_escolar_prepa/screen/list_studentByGrade.dart';
import 'package:sistema_escolar_prepa/screen/list_teacher_screen.dart';
import 'package:sistema_escolar_prepa/screen/login.dart';
import 'package:sistema_escolar_prepa/screen/mision_vision.dart';
import 'package:sistema_escolar_prepa/screen/publication.dart';
import 'package:sistema_escolar_prepa/screen/publication_create.dart';
import 'package:sistema_escolar_prepa/screen/publication_list.dart';
import 'package:sistema_escolar_prepa/screen/publication_update.dart';
import 'package:sistema_escolar_prepa/screen/screen.dart';
import 'package:sistema_escolar_prepa/screen/screen_resgister_teacher.dart';
import 'package:sistema_escolar_prepa/screen/subject_create.dart';
import 'package:sistema_escolar_prepa/screen/tuition.dart';
import 'package:sistema_escolar_prepa/shared_preferences.dart/shared_preferences.dart';
import 'package:sistema_escolar_prepa/widgets/view_image.dart';
import 'package:sistema_escolar_prepa/widgets/view_pdf.dart';

// lista de todos los servicios
import 'Services/Services.dart';
import 'Services/adviser_services.dart';
import 'Services/chat/socket_servives.dart';
import 'providers/form_teacher.dart';
import 'screen/information_teacher.dart';
import 'screen/screen_adviser.dart';

void main() async {
  // aca vamos a inicalizar el shared PREFERENCES

  WidgetsFlutterBinding.ensureInitialized();
  final preferences = Preferences();
  await preferences.initPreferences();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => MenuOptionProvider()),
    ChangeNotifierProvider(create: (_) => LoginFormProvider()),
    ChangeNotifierProvider(create: (_) => LoginServices()),
    ChangeNotifierProvider(
        create: (_) => ThemeProvier(isDarkMode: preferences.getIsDarkMode)),
    ChangeNotifierProvider(create: (_) => SemestreServices()),
    ChangeNotifierProvider(create: (_) => GroupServices()),
    ChangeNotifierProvider(create: (_) => GenerationServices()),
//
    // subjects ( materia)
    ChangeNotifierProvider(create: (_) => SubjectServices()),
    // materias
    ChangeNotifierProvider(create: (_) => TeachaerServices()),
    ChangeNotifierProvider(create: (_) => TeacherFormProvider()),
    ChangeNotifierProvider(create: (_) => StudentsServices()),

    // provider para mostara los horarios
    ChangeNotifierProvider(create: (_) => HorarioServices()),

    /// Tuition o matriculaF
    ChangeNotifierProvider(create: (_) => TuitionServices()),

    // publication
    ChangeNotifierProvider(create: (_) => PublicationServices()),

    ChangeNotifierProvider(create: (_) => FilesServices()),

//  for register adviser or tutor
    ChangeNotifierProvider(create: (_) => AdivserTutorServies()),

    // provider services para subir las historias
    ChangeNotifierProvider(create: (_) => StoryServices()),

    // calificioens
    ChangeNotifierProvider(create: (_) => RatingServices()),

// para el chat
    ChangeNotifierProvider(create: (_) => SocketService())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
//  final themeProvier = Provider.of<ThemeProvier>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: Provider.of<ThemeProvier>(context).currentTheme == ThemeData.dark()
          ? ThemeData.dark(
              useMaterial3: true,
            )
          : ThemeData.light(
              useMaterial3: true,
            ),

      // theme: ThemeData.light(useMaterial3: true),
//
// themeMode: Theme.of(context).brightness,
      // initialRoute: AppRoute.initialRoute,
      // routesmain: AppRoute.routes,

      initialRoute: 'check_auth_screen',
      // initialRoute: 'home',
      routes: {
        'home': (_) => const ScreenHome(),
        'check_auth_screen': (_) => const CheckAuthScreen(),
        'login': (_) => const Login(),

// vistas principales para el menu
        'student': (_) => const ScreenStudent(),
        'teachers': (_) => const ScreenTeacher(),
        'horarios': (_) => const ScreenHorarios(),
        // for subject
        'subjects': (_) => const SubjectsScreeen(),
        'subject_create': (_) => const ScreenSubjectCreate(),
        'groups': (_) => const ScreenGroup(),
        'publicaciones': (_) => const ScreenPublication(),
        'view_image': (_) => const ViewImage(),
        'show_pdf': (_) => const PdfPage(),

        'screen_list_student': (_) => const ListStudent(),
        // for teacher
        'screen_register_teacher': (_) => const ScreenRegisterTeacher(),
        'list_teacher': (_) => const ListTeacherScreen(),
        'show_teacher_information': (_) => const InformationTeacherScreen(),

        // solo para andoird he ios
        'content_data_student': (_) => const ContentDataStudent(),
        // creatae studnet
        'create_student': (_) => const ScreenCreateStudent(),
        'screen_edit_student': (_) => const ScreenEditStudent(),
        // adviser tutor
        'adviser_tutor': (_) => const ScreenAdviserTutor(),
        'create_adviser': (_) => const ScreenCreateAdviser(),
        'list_adviser': (_) => const ScreenListAdviser(),
        // for publicaciones
        'update_publication': (_) => const ScreenUpdatePublcation(),
        'create_publication': (_) => const ScreenCreatePublication(),
        'list_publication': (_) => const ScreenListPublication(),

        // mision and vision
        'show_mision_vision': (_) => const SchoolMissionVisionScreen(),
        'information_subject': (_) => const InformationSubjectScreen(),

        // story
        'create_story': (_) => const ScreenCreateStory(),
        'list_story': (_) => const ScreenListStory(),

        // lista de estudianes por calificacion
        'list_studentByGrades': (_) => const ScreenListStudentByGrades(),
        // para agregar todos los matricual 0o numero de control
        'tuition': (_)=> const ScreenTuition()
      },
    );
  }
}
