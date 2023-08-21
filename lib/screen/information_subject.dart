import 'package:blobs/blobs.dart';
import 'package:flutter/material.dart';

import 'dart:ui' as ui;

class InformationSubjectScreen extends StatelessWidget {
  const InformationSubjectScreen({Key? key}) : super(key: key);

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
                    children: [
                      ClipPath(
                        clipper: CurveClipper(),
                        child: Container(
                          height: MediaQuery.of(context).size.height / 2,
                          decoration: BoxDecoration(
                            border: Border.all(width: 5.0, color: Colors.black),
                            color: Colors.red,

                            //   gradient: LinearGradient(
                            //     begin: Alignment.topCenter,
                            //     end: Alignment.bottomCenter,
                            //     colors: [Colors.red, Colors.blue],
                            //   ),
                          ),
                        ),
                      )
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

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
 debugPrint(size.width.toString());
    // dibuja una linea
    path.lineTo(0, 150);

    // inicio
    var firstStart = Offset(size.width / 5, size.height);   


    var firstEnd = Offset(size.width / 2.25, size.height - 50);
    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);

    var secondStart =
        Offset(size.width - (size.width / 3.24), size.height - 105);
    var secondEnd = Offset(size.width, size.height - 10);
    path.quadraticBezierTo(
        secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);
        
    path.lineTo(size.width, 0);
    // path.lineTo(0, size.height  );

    // Offset(x, y )

    // var firstControlPoint = Offset(size.width /2, size.height /2
    //     // 0
    //     );
    // // Offset(x, y )

    // var firstEndPoint = Offset(size.width, size.height);

    // path.quadraticBezierTo(
    //   firstControlPoint.dx,
    //   firstControlPoint.dy,
    //   firstEndPoint.dx -100,
    //   firstEndPoint.dy   + 100,
    // );

    // var secondControlPoint =
    //     Offset(size.width - (size.width/2), size.height/2);
    // var secondEndPoint = Offset(size.width/2, size.height/2);

    // path.quadraticBezierTo(
    //   secondControlPoint.dx,
    //    secondControlPoint.dy,
    //   //en de donde termia
    //     secondEndPoint.dx + 200,
    //     secondEndPoint.dy - 200);

    // // path.lineTo(size.width / 10, size.height );
    // // path.lineTo(size.width, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// ...
