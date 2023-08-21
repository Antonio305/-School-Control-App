import 'package:blobs/blobs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_escolar_prepa/Services/publication_services.dart';

import 'dart:io';

class ScreenPublication extends StatelessWidget {
  const ScreenPublication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Color.fromARGB(555, 234, 240, 240),

        body: SafeArea(
      child: Platform.isAndroid || Platform.isIOS
          ? CustomScrollView(
              slivers: [
                _sliverAppBar(),
                SliverToBoxAdapter(
                  child: Column(
                    // vetical
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Platform.isAndroid || Platform.isIOS
                          ? Container()
                          : const Text('Publicaciones'),
                      const SizedBox(
                        height: 30,
                      ),
                       ElevatedButton(
                        autofocus: true,
                        style: ElevatedButton.styleFrom(
                          // foregroundColor: Colors.red, colors in the letras
                          elevation: 5,
                          // backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, 'create_story');
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 1, vertical: 55),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                  width: 55,
                                  height: 55,
                                  child:
                                      Image.asset('asset/create_public.png')),
                              const Text('SUBIR HISTORIA'),
                              const Icon(
                                Icons.add,
                                color: Colors.blue,
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        autofocus: true,
                        style: ElevatedButton.styleFrom(
                          // foregroundColor: Colors.red, colors in the letras
                          elevation: 5,
                          // backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, 'create_publication');
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 1, vertical: 55),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                  width: 55,
                                  height: 55,
                                  child:
                                      Image.asset('asset/create_public.png')),
                              const Text('CREAR PUBLICACION'),
                              const Icon(
                                Icons.add,
                                color: Colors.blue,
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        autofocus: true,
                        style: ElevatedButton.styleFrom(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          // acción para realizar cuando se presiona el botón
                          final publicationServices =
                              Provider.of<PublicationServices>(context,
                                  listen: false);

                          publicationServices.allPublication();
                          Navigator.pushNamed(context, 'list_publication');
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 1, vertical: 55),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                  width: 55,
                                  height: 55,
                                  child:
                                      Image.asset('asset/list_public.png')),
                              const Text('LISTA DE PUBLICACIONES'),
                              const Icon(Icons.list_outlined)
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        autofocus: true,
                        style: ElevatedButton.styleFrom(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          // acción para realizar cuando se presiona el botón
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 1, vertical: 55),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                  width: 55,
                                  height: 55,
                                  child:
                                      Image.asset('asset/active_public.png')),
                              const Text('PUBLICACIONES ACTIVAS'),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        autofocus: true,
                        style: ElevatedButton.styleFrom(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          // acción para realizar cuando se presiona el botón
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 1, vertical: 55),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                  height: 55,
                                  child: Image.asset('asset/news_n.png')),
                              const Text('PUBLICACIONES NO ACTIVAS'),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 55,
                      ),
                    ],
                  ),
                ),
              ],
            )
          : CustomScrollView(
              slivers: [
                _sliverAppBar(),
                SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Wrap(
                        runSpacing: 40,
                        spacing: 40,
                        alignment: WrapAlignment.start,

                        // vetical
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                        // crossAxisAlignment: CrossAxisAlignment.center,

                        children: [
                          ElevatedButton(
                            autofocus: true,
                            style: ElevatedButton.styleFrom(
                              // foregroundColor: Colors.red, colors in the letras
                              elevation: 5,
                              // backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, 'create_publication');
                            },
                            child: SizedBox(
                              width: 330,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 1, vertical: 55),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                        width: 55,
                                        height: 55,
                                        child: Image.asset(
                                            'asset/create_public.png')),
                                    const Text('CREAR PUBLICACION'),
                                    const Icon(
                                      Icons.add,
                                      color: Colors.blue,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            autofocus: true,
                            style: ElevatedButton.styleFrom(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              // acción para realizar cuando se presiona el botón
                              final publicationServices =
                                  Provider.of<PublicationServices>(context,
                                      listen: false);

                              publicationServices.allPublication();
                              Navigator.pushNamed(context, 'list_publication');
                            },
                            child: SizedBox(
                              width: 330,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 1, vertical: 55),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                        width: 55,
                                        height: 55,
                                        child: Image.asset(
                                            'asset/list_public.png')),
                                    const Text('LISTA DE PUBLICACIONES'),
                                    const Icon(Icons.list_outlined)
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            autofocus: true,
                            style: ElevatedButton.styleFrom(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              // acción para realizar cuando se presiona el botón
                            },
                            child: SizedBox(
                              width: 330,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 1, vertical: 55),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                        width: 55,
                                        height: 55,
                                        child: Image.asset(
                                            'asset/active_public.png')),
                                    const Text('PUBLICACIONES ACTIVAS'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            autofocus: true,
                            style: ElevatedButton.styleFrom(
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              // acción para realizar cuando se presiona el botón
                            },
                            child: SizedBox(
                              width: 330,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 1, vertical: 55),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                        height: 55,
                                        child: Image.asset('asset/news_n.png')),
                                    const Text('PUBLICACIONES NO ACTIVAS'),
                                  ],
                                ),
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
    ));
  }
}

class _sliverAppBar extends StatelessWidget {
  const _sliverAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      // surfaceTintColor: Colors.red,
      // color del app bar
      // backgroundColor: Color.fromARGB(555, 137, 61, 236),

      floating: true,
      pinned: true, // para dja visible el widget el title
      title: const Text('Publicaciones'),
      expandedHeight: 255,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        // title: const Text('Mision y Vision'),
        titlePadding: const EdgeInsets.all(0),
        background: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(30)),
            color: Color.fromARGB(555, 137, 61, 236),

            // me gusta mas ete colors
          ),
          child: Center(
              child: Image.asset(
            'asset/create_public.png',
            width: 155,
            height: 155,
          )),
        ),
      ),
    );
  }
}
