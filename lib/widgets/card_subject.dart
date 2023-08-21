import 'package:blobs/blobs.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import '../models/subjects.dart';

class CardSubject extends StatelessWidget {
  final Size size;
  final List<Subjects> subjects;
  final int index;

  const CardSubject(
      {Key? key,
      required this.size,
      required this.subjects,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'information_subject');
      },
      child: Card(
        elevation: 4,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.grey
            //         .withOpacity(0.5), //color of shadow
            //     spreadRadius: 1, //spread radius
            //     blurRadius: 1, // blur radius
            //     offset: const Offset(
            //         0, 4), // changes position of shadow
            //     //first paramerter of offset is left-right
            //     //second parameter is top to down
            //   ),
            // ],
          ),
          width: Platform.isAndroid || Platform.isIOS ? size.width * 0.99 : 320,

          // width: 155,
          height: 160,
          child: Stack(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Positioned(
                right: 0,
                bottom: -100,
                child: Transform.rotate(
                  angle: 20,
                  child: Container(
                    height: 300,
                    width: 180,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 123, 90, 214)
                          .withOpacity(0.1)
                          .withOpacity(0.08),

                      // const Color.fromARGB(255, 59, 19, 170).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
              ),

              Blob.fromID(
                // id: ['10-5-1'],
                size: 120,
                // id: ['10-3-9'],
                id: ['10-4-9'],

                child: SizedBox(
                  height: 10,
                  width: 10,
                  child: Center(
                    child: Image.asset(
                      'asset/mision.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),

              // Container(
              //     decoration: BoxDecoration(
              //       borderRadius:
              //           BorderRadius.circular(20),
              //       // color: Colors.red,
              //     ),
              //     width: 100,
              //     height: 100,
              //     child: ClipRRect(
              //         borderRadius:
              //             BorderRadius.circular(90),
              //         child: Image.asset(
              //           'asset/subject2.png',
              //           fit: BoxFit.cover,
              //         ))),

              Positioned(
                top: 20,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 118, 76, 235),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              subjects[index].name,
                            ),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(subjects[index].semestre.name),
                      const SizedBox(
                        height: 5,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color:
                              Color.fromARGB(255, 59, 19, 170).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(subjects[index].teachers.name +
                              " " +
                              subjects[index].teachers.lastName +
                              " " +
                              subjects[index].teachers.secondName),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
