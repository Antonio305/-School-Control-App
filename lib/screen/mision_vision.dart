import 'package:blobs/blobs.dart';
import 'package:flutter/material.dart';

import 'dart:ui' as ui;

class SchoolMissionVisionScreen extends StatelessWidget {
  const SchoolMissionVisionScreen({Key? key}) : super(key: key);

  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ui.Color.fromARGB(255, 136, 76, 214),
        body: SafeArea(
          child: CustomScrollView(
            //  es una lita de widget
            slivers: [
              _sliverAppBar(),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    children: const [
                      Text('Prepa Bochil'),
                      SizedBox(
                        height: 60,
                      ),
                      Text(
                          'No se qeu mas hacer, ya no se me ocurre nada la vedad'),
                      SizedBox(
                        height: 30,
                      ),

                      Text( 
                          'No se qeu mas hacer, ya no se me ocurre nada la vedad, se que le tiempo ya paso pero trato de hacerlo mejor'),

                      // Container(
                      //   height: 100,
                      //   width: 300,
                      //   color: Colors.red,
                      // ),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      // Container(height: 100, width: 300, color: Color.fromARGB(255, 74, 47, 230)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  SliverAppBar _sliverAppBar() {
    return SliverAppBar(
      surfaceTintColor: Colors.red,
      // leading: IconButton(
      //     onPressed: () {
      //       // const MyDrawer();
      //     },
      //     icon: const Icon(Icons.menu)),
      // color del app bar

      backgroundColor: Color.fromARGB(255, 100, 28, 194),
      floating: true,
      pinned: true, // para dja visible el widget el title
      // title: const Text('Prepa Bochil'),
      expandedHeight: 350,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: const Text('Mision y Vision'),
        titlePadding: const EdgeInsets.all(0),
        background: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 137, 61, 236),
          ),
          child: Center(
            child: Blob.fromID(
              // id: ['10-5-1'],
              // debug: true,
              size: 250,
              id: ['12-10-1'],
              child: SizedBox(
                  // height: 200,
                  // width:200,
                  child: Image.asset(
                'asset/mision.png',
                fit: BoxFit.fill,
              )),
            ),
          ),
        ),
      ),
    );
  }
}
