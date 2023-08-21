import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_escolar_prepa/Services/Services.dart';
import 'package:sistema_escolar_prepa/models/student_by_grades.dart';
import 'package:sistema_escolar_prepa/models/student_tutor.dart';

// property dart
import 'dart:io';

import '../models/students.dart';
import '../providers/menu_option_provider.dart';

class ListStudent extends StatefulWidget {
  const ListStudent({Key? key}) : super(key: key);

  @override
  State<ListStudent> createState() => _ContentState();
}

class _ContentState extends State<ListStudent> {
// intance class studnt
  Students student = Students(
      studentTutor: StudentTutors(
          nameTutor: '',
          lastNameTutor: '',
          secondNameTutor: '',
          kinship: '',
          numberPhoneTutor: 00000),
      name: '',
      lastName: '',
      secondName: '',
      gender: '',
      dateOfBirth: DateTime.now(),
      bloodGrade: '',
      curp: '',
      age: 0,
      town: '',
      numberPhone: 00000000,
      tuition: '',
      password: '',
      status: false,
      rol: '',
      group: Group(id: '', name: '', adviser: '', tutor: '', v: 0),
      semestre: [],
      subjects: [],
      generation: Generations(
          id: '', initialDate: DateTime.now(), finalDate: DateTime.now(), v: 0),
      uid: '');

  @override
  Widget build(BuildContext context) {
    final groupServices = Provider.of<GroupServices>(context, listen: true);
    final semestreServices =
        Provider.of<SemestreServices>(context, listen: true);
    final generationServices =
        Provider.of<GenerationServices>(context, listen: true);

    final semestre = semestreServices.semestres;
    final group = groupServices.group;
    final generation = generationServices.generations;

    // Creamos una lista de areas.
    final List<String> areas = [
      'Fisicos Matemeeticos',
      'Quimicos Biologos',
      'Ciencias Sociales',
      'Economicos Administrativos',
      'Tronco Comun'
    ];

    final size = MediaQuery.of(context).size;

    final studentServies = Provider.of<StudentsServices>(context);
    final List<Students> students = studentServies.students;
    final dropMenuProvider = Provider.of<MenuOptionProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de estudiantes'),
      ),
      body: Padding(
        padding: Platform.isWindows || Platform.isMacOS
            // ignore: prefer_const_constructors
            ? EdgeInsets.symmetric(horizontal: 20)
            : const EdgeInsets.symmetric(vertical: 8),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // _Search(
              // size: size,
              // ),
              Card(
                elevation: 10,
                child: SizedBox(
                  // color: Colors.red,
                  width: size.width * 0.75,
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 300,
                          child: Row(
                            children: [
                              const Text('Area'),
                              const SizedBox(
                                width: 10,
                              ),
                              DropdownButton(
                                  // value: dropMenuProvider.dropdownMenuItemGroup,
                                  value: areas.first,
                                  items: List.generate(
                                      areas.length,
                                      (index) => DropdownMenuItem<String>(
                                          onTap: () {
                                            // student.group = group[index].uid;

                                            // groupSelect = areas[index];
                                            student.specialtyArea =
                                                areas[index];
                                          },
                                          value: areas[index],
                                          child: Text(areas[index]))),
                                  onChanged: (String? value) {
                                    // dropMenuProvider.dropdownMenuItemGroup = value!;
                                  }),
                            ],
                          ),
                        ),

                        //cresremos a cada uno de los drop down
                        Row(
                          children: [
                            const Text('Grupo'),
                            const SizedBox(
                              width: 10,
                            ),
                            DropdownButton(
                                value: dropMenuProvider.dropdownMenuItemGroup,
                                items: group.groups
                                    .map<DropdownMenuItem<String>>((value) {
                                  return DropdownMenuItem<String>(
                                      onTap: () {
                                        dropMenuProvider.dropdownMenuItemGroup =
                                            value.uid;
                                      },
                                      value: value.name,
                                      child: Text(value.name));
                                }).toList(),
                                onChanged: (String? value) {
                                  dropMenuProvider.dropdownMenuItemGroup =
                                      value!;
                                }),
                          ],
                        ),

                        // lsita de los semestre
                        DropdownButton<String>(
                            value: dropMenuProvider.dropdownMenuItemSemestre,
                            items: List.generate(
                                semestre.length,
                                (index) => DropdownMenuItem<String>(
                                    onTap: () {
                                      // dropMenuProvider.dropdownMenuItemSemestre =
                                      //     semestre[index].uid;
                                      // student.semestre.add(semestre[index].uid);
                                    },
                                    value: semestre[index].name,
                                    child: Text(semestre[index].name))),
                            onChanged: (String? value) {
                              dropMenuProvider.dropdownMenuItemSemestre =
                                  value!;
                            }),

                        // lista de las generaciones

                        DropdownButton<String>(
                            // value: generation.first.initialDate.toString(),

                            value: dropMenuProvider.dropDownMenuItemGeneracion,
                            items: List.generate(
                                generation.length,
                                (index) => DropdownMenuItem(
                                    onTap: () {
                                      // dropMenuProvider.dropDownMenuItemGeneracion =
                                      //     generation[index].uid;
                                      // student.generation = generation[index].uid;
                                    },
                                    value: generation[index]
                                        .initialDate
                                        .toString(),
                                    child: Text(
                                        '${generation[index].initialDate.year} - ${generation[index].finalDate.year}'))),
                            onChanged: (String? value) {
                              dropMenuProvider.dropDownMenuItemGeneracion =
                                  value!;
                            }),

                        MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
                          color: Colors.blueAccent.withOpacity(0.8),
                          onPressed: () {},
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Text('BUSCAR'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              Platform.isWindows || Platform.isMacOS
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ListStudent(size, students),

                        // segunda parte
                        ContentDataStudent(size, student),
                      ],
                    )
                  : ListStudent(size, students),
            ],
          ),
        ),
      ),
    );
  }

  Container ListStudent(Size size, List<Students> students) {
    return Container(
      width: Platform.isWindows || Platform.isMacOS
          ? size.width * 0.3
          : size.width * 0.9,
      height: size.height * 0.75,
      decoration: BoxDecoration(
        // color: Colors.white,
        // color: Colors.blue,
        border: Border.all(color: Colors.black26, width: 0.5),

        borderRadius: BorderRadius.circular(10),
      ),
      child: students.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 150,
                      width: 150,
                      child:
                          Image.asset('asset/loading.png', fit: BoxFit.fill)),
                  const SizedBox(
                    height: 20,
                  ),
                  const CircularProgressIndicator(
                    semanticsLabel: "100 %",
                  ),
                ],
              ),
            )
          : ListView.builder(
              controller: ScrollController(initialScrollOffset: 0),
              // scrollDirection: Axis.vertical,
              itemCount: students.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: CircleAvatar(
                      child: Text(students[index].name.substring(0, 2))
                      ),
                  title: Text(
                      students[index].name +
                          " " +
                          students[index].lastName +
                          " " +
                          students[index].secondName,
                      style: const TextStyle(fontSize: 13)),
                  subtitle: Text(
                      "NUMERO DE CONTROL: " + students[index].tuition,
                      style: const TextStyle(fontSize: 11)),
                  onTap: () {
                    if (Platform.isWindows || Platform.isMacOS) {
                      student = students[index];
                      setState(() {});
                    } else if (Platform.isAndroid || Platform.isIOS) {
                      Navigator.pushNamed(context, 'content_data_student',
                          arguments: students[index]);
                    }
                  },
                  onLongPress: () {
                    print('Boton mas larga');
                    openDialogSelectTypeBaja(context, size);
                  },
                );
              },
            ),
    );
  }

  Future<String?> openDialogSelectTypeBaja(BuildContext context, Size size) =>
      showDialog<String>(
        // barrierColor: Colors.red[200],
        context: context,
        builder: (context) => AlertDialog(
          scrollable: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          icon: Align(
              alignment: Alignment.center,
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.sim_card_alert_rounded,
                    size: 10,
                  ))),
          title: const Text("Selecciona el tipo de baja"),
          content: Center(
            child: SizedBox(
                height: Platform.isWindows || Platform.isMacOS
                    ? size.height / 3
                    : size.height / 2,
                width: Platform.isWindows || Platform.isMacOS
                    ? size.width / 3
                    : size.width / 2,
                child: SingleChildScrollView(
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    runSpacing: 10,
                    spacing: 10,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 1, vertical: 25),
                          child: Text('Baja Temporal'),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text('Baja Definitiva'),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancelar'))
            // Container(),
            // CupertinoButton(child: const Text('Aceptar'), onPressed: () {}),
            // CupertinoButton(child: const Text('Cancelar'), onPressed: () {})
          ],
        ),
      );

  Container ContentDataStudent(Size size, Students student) {
    return Container(
      width: size.width * 0.6,
      height: size.height * 0.78,
      decoration: BoxDecoration(
          // color: Colors.black12,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black26, width: 0.5)),
      child: SingleChildScrollView(
        child: Column(children: [
          _profile(size, student),

          const SizedBox(
            height: 20,
          ),
          const Text('Datos del estudiante'),
          const SizedBox(
            height: 10,
          ),

          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black26),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  runSpacing: 10,
                  spacing: 40,
                  children: [
                    Text('Sexo :${student.gender}'),
                    Text('Fecha Nacimiento: ${student.dateOfBirth}'),
                    Text('tipo de Sangre : ${student.bloodGrade}'),
                    Text('Crup: ${student.curp}'),
                    Text('Edad : ${student.age}'),
                    Text('direccion: ${student.town}'),
                    Text('Telefono: ${student.numberPhone}'),
                    Text('Matricula ${student.tuition}'),
                  ]),
            ),
          ), //
          const SizedBox(height: 20),
          Text('Datos del tutor'),
          const SizedBox(height: 20),

// de chat  pgt
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black26),
                borderRadius: BorderRadius.circular(10),
              ),
              width: size.width,
              // color: Colors.blue,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  runSpacing: 10,
                  spacing: 40,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.account_circle, size: 22.0),
                        const SizedBox(width: 8.0),
                        Text(
                            'Nombre: ${student.studentTutor.nameTutor + "  " + student.studentTutor.lastNameTutor + "  " + student.studentTutor.secondNameTutor}'),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.phone, size: 22.0),
                        const SizedBox(width: 8.0),
                        Text(
                            'Numero de telefono: ${student.studentTutor.numberPhoneTutor}'),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.family_restroom, size: 22.0),
                        const SizedBox(width: 8.0),
                        Text('Parentesco : ${student.studentTutor.kinship}'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ), //

          const SizedBox(height: 50),

          // const Spacer(),
          MaterialButton(
              color: Colors.blue,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: Text('Editar'),
              ),
              onPressed: () {
                Navigator.pushNamed(context, 'screen_edit_student',
                    arguments: student);
              })
        ]),
      ),
    );
  }

  Container _profile(Size size, Students student) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
        // border: Border.all(color: Colors.black26, width: 0.5),
        color: Color(0xFF1D2027),
      ),

      width: size.width,
      height: 250,
      // width: 300,
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          CircleAvatar(
            // backgroundImage: ,
            radius: 50.0,
            backgroundColor: Colors.blueAccent,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(90),
              child: Image.network(
                'https://img.apmcdn.org/2e2ceb4fdbd8ac017b85b242fe098cb3b466cf5a/square/44315c-20161208-katherine-johnson.jpg',
                fit: BoxFit.fill,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '${student.name + "  " + student.lastName + "  " + student.secondName}',
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          const Text('eldioseltreno@gmail.com',
              style: TextStyle(color: Colors.white60)),
        ],
      ),
    );
  }
}

class _Search extends StatelessWidget {
  const _Search({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      width: Platform.isWindows || Platform.isMacOS
          ? size.width / 2
          : size.width * 0.9,
      height: 50,
      decoration: BoxDecoration(
        // color: Colors.red,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.red,
          width: .5,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
              width: size.width / 3,
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              )),
          MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 0,
            color: Colors.blue,
            onPressed: () {},
            child: const Text('BUSCAR'),
          ),
        ],
      ),
    );
  }
}
