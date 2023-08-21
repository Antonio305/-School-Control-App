import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_escolar_prepa/models/host.dart';
import 'package:sistema_escolar_prepa/models/story.dart';
import 'dart:io';
import '../Services/story_servies.dart';

class ScreenListStory extends StatefulWidget {
  const ScreenListStory({Key? key}) : super(key: key);

  @override
  State<ScreenListStory> createState() => _ScreenListStoryState();
}

class _ScreenListStoryState extends State<ScreenListStory> {
  // create list type Sotry
  List<Storys> storys = [];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final storyServices = Provider.of<StoryServices>(context);

    // storys = ModalRoute.of(context)?.settings.arguments as List<Storys>;
    String valueArgument = ModalRoute.of(context)?.settings.arguments as String;
    if (valueArgument == 'allStorys') {
      storys = storyServices.storys;
    } else {
      storys = storyServices.storysByStatusTrue;
    }
    //  if (valueArgument == 'allStorysByStatus')

    return Scaffold(
      appBar: AppBar(
        title: const Text('HISTORIAS'),
      ),
      body: Padding(
        padding: Platform.isAndroid || Platform.isIOS
            ? const EdgeInsets.all(5.0)
            : const EdgeInsets.all(50.0),
        child: GridView.builder(
          itemCount: storys.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: Platform.isAndroid || Platform.isIOS ? 2 : 6,
          ),
          itemBuilder: (context, index) {
            return SizedBox(
              child: Stack(
                children: [
                  Card(
                    child: SizedBox(
                      // width: size.width / 2.5,
                      width: 300,
                      height: size.height * 0.38,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: storys[index].archivos == null
                            ? Column(
                              children: [
                                const Text('No Image'),
                                Text(storys[index].data!
                                ),
                              ],
                            )
                            : Image.network(
                                // 'https://prepabochil.fly.dev/api/uploadFile/${storys[index].id}/story',

                                // 'http://192.168.1.78:3000/api/uploadFile/${storys[index].id}/story',
                                'https://www.staffcreativa.pe/blog/wp-content/uploads/facebook-cineplanet.jpg',
                                fit: BoxFit.fill,
                              ),
                      ),
                    ),
                  ),
                  Positioned(
                      top: 10,
                      right: 10,
                      child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.amber,
                          child: IconButton(
                              onPressed: () async {
                                await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('ADVERTENCIA!'),
                                      content: const Text(
                                          'Deseas Eliminar la historia'),
                                      actions: [
                                        TextButton(
                                          onPressed: () async {
                                            // FUNCION DELTE SOTRY
                                            final storyServices =
                                                Provider.of<StoryServices>(
                                                    context,
                                                    listen: false);
                                            await storyServices
                                                .deleteStoryBySId(
                                                    storys[index].id);

                                            storys.remove(storys[index]);
                                            setState(() {});

                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('ACEPTAR'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('CANCELAR'),
                                        ),
                                      ],
                                    );
                                  },
                                );

                                Timer? timer = Timer(
                                    const Duration(milliseconds: 1000), () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                });

                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) {
                                      return const AlertDialog(
                                        title: Text('Título'),
                                        content: Text('Contenido'),
                                      );
                                    }).then((value) {
                                  timer?.cancel();
                                  timer = null;
                                });
                              },
                              icon: const Icon(Icons.edit, size: 15)))),
                ],
              ),
            );
          },
        ),
      ),
      //  ListView.builder(
      //     scrollDirection: Axis.vertical,
      //     itemCount: storys.length,
      //     itemBuilder: (BuildContext context, index) {
      //       return Card(
      //         child: SizedBox(
      //           // width: size.width / 2.5,
      //           width: 300,
      //           height: size.height * 0.38,
      //           child: ClipRRect(
      //             borderRadius: BorderRadius.circular(15),
      //             child: storys[index].archivos == null
      //                 ? const Text('No Image')
      //                 : Image.network(
      //                     'http://localhost:8080/api/uploadFile/${storys[index].id}/story',
      //                     fit: BoxFit.fill,
      //                   ),
      //           ),
      //         ),
      //       );
      //     }),
    );
  }
}
