import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_escolar_prepa/Services/Services.dart';
import 'package:sistema_escolar_prepa/screen/homa_page.dart';

import '../Services/story_servies.dart';
import 'login.dart';

class CheckAuthScreen extends StatelessWidget {
  const CheckAuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // hacemos ka instnacia del login para la validacion
    // final loginServices = Provider.of<LoginServices>(context, listen: false);
    final loginServices = Provider.of<LoginServices>(context, listen: false);

    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: loginServices.readToken(),
          // future: checkLoginState(context),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            // shanpshot guarda el dato que retorna el el future

            if (!snapshot.hasData) return const Text('Espere');

            // // Future.Microtask es para esperar que se recostruya todo el widget que se  mostrara a continucacio
            if (snapshot.data == '') {
              Future.microtask(() {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => const Login(),
                    transitionDuration: const Duration(seconds: 0),
                  ),
                );
              });
            } else {
              Future.microtask(() async {
                final teacherServices =
                    Provider.of<TeachaerServices>(context, listen: false);
                final teacherS =
                    Provider.of<TeachaerServices>(context, listen: false);

                final groupServices =
                    Provider.of<GroupServices>(context, listen: false);
                final generationServices =
                    Provider.of<GenerationServices>(context, listen: false);
                final subjectServices =
                    Provider.of<SubjectServices>(context, listen: false);

                final semestreServices =
                    Provider.of<SemestreServices>(context, listen: false);
                final storyServices =
                    Provider.of<StoryServices>(context, listen: false);

                // await storyServices.getAllStoryByStatusTrue();
                final String token = await loginServices.readToken();

                await teacherS.getForId(token);

                await teacherServices.getTeachers();
                await groupServices.allGroup();
                await subjectServices.getSubjects();
                await generationServices.allGeneration();
                await semestreServices.allSemestre();

                Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => const ScreenHome(),
                        transitionDuration: const Duration(seconds: 0)));

                //  Navigator.of(context).pushReplacementNamed('home');
              });
            }

            // return Container();
            return const Center(child: Text('Espere...'));

            //  const Text('Espere');
          },
        ),
      ),
    );
  }

  // una funcion para devolder si tenemos una autentificacion
  Future checkLoginState(BuildContext context) async {
    final authService = Provider.of<LoginServices>(context, listen: false);
    bool? autentication = await authService.isLoggetIn();

    if (autentication! == false) {
      Future.microtask(() {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const Login(),
            transitionDuration: const Duration(seconds: 0),
          ),
        );
      });
    } else {
      Future.microtask(() async {
        final teacherServices =
            Provider.of<TeachaerServices>(context, listen: false);

        final groupServices =
            Provider.of<GroupServices>(context, listen: false);
        final generationServices =
            Provider.of<GenerationServices>(context, listen: false);
        final subjectServices =
            Provider.of<SubjectServices>(context, listen: false);

        final semestreServices =
            Provider.of<SemestreServices>(context, listen: false);

        await teacherServices.getTeachers();
        await groupServices.allGroup();
        await subjectServices.getSubjects();
        await generationServices.allGeneration();
        await semestreServices.allSemestre();

        Navigator.pushReplacement(
            context,
            PageRouteBuilder(
                pageBuilder: (_, __, ___) => const ScreenHome(),
                transitionDuration: const Duration(seconds: 0)));

        //  Navigator.of(context).pushReplacementNamed('home');
      });
    }
  }
}
