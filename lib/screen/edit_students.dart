import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_escolar_prepa/models/for_student_create.dart';
import 'package:sistema_escolar_prepa/models/generations.dart';
import 'package:sistema_escolar_prepa/models/semestre.dart';
import 'package:sistema_escolar_prepa/providers/form_provider.dart';
import 'package:sistema_escolar_prepa/providers/menu_option_provider.dart';
import 'package:sistema_escolar_prepa/widgets/text_fileds.dart';

import '../Services/generation_services.dart';
import '../Services/group_services.dart';
import '../Services/semestre.dart';
import '../Services/student_services.dart';

import '../models/group.dart';
import '../models/students.dart';

class ScreenEditStudent extends StatefulWidget {
  const ScreenEditStudent({Key? key}) : super(key: key);

  @override
  State<ScreenEditStudent> createState() => _CreateDataStudentState();
}

class _CreateDataStudentState extends State<ScreenEditStudent> {
  DateTime selectedDate = DateTime.now();

  Student student = Student(
      name: '',
      lastName: '',
      secondName: '',
      gender: '',
      dateOfBirth: DateTime.now(),
      bloodGrade: '',
      curp: '',
      age: 0,
      town: '',
      numberPhone: 0,
      email: "",
      tuition: '',
      password: '',
      status: true,
      rol: 'STUDENT',
      studentTutor: StudentTutor(
          nameTutor: '',
          lastNameTutor: '',
          secondNameTutor: '',
          kinship: '',
          numberPhoneTutor: 0),
      group: '',
      semestre: [],
      subjects: [],
      generation: '');

  final _formKey = GlobalKey<FormState>();

  // controlador para los campos de texto...
  final numberPhoneStudent = TextEditingController();

  final numberPhoneTutor = TextEditingController();

  String? genderSelect;
  String? bloodGradeSelect;
  String? curpSelect;
  int? ageSelect;
  String? groupSelect;
  String? semestreSelect;
  // List<String>? subjectsSelect;
  String? generationSelect;

  String? kinshipSelect;

  String? phoneStudent;
  String? phoneTutor;

  String _dropdownValue = '';

  final List<String> _options = [
    'Option 1',
    'Option 2',
    'Option 3',
    'Option 4'
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // phoneStudent = numberPhoneStudent.text;
    // phoneTutor = numberPhoneTutor.text;
  }

  @override
  Widget build(BuildContext context) {
// recivimos como argumentos la matricula
    Students students = ModalRoute.of(context)!.settings.arguments as Students;

    final formKey = Provider.of<LoginFormProvider>(context);

    // cremso una lsita de los seco
    var gender = <String>['FEMENINO', 'MASCULINO', 'OTRO'];

// VALOR POR DEFECTO
    // String dropButtonValue =  gender.first;
    // hacemos la instancia de provider
    final dropMenuProvider = Provider.of<MenuOptionProvider>(context);

    // datos iniciales de las fechas
    // // funcion now estre la fecha de hoy

    // una del os tipos de sangre
    final bloodType = <String>[
      'A+',
      'O+',
      'B+',
      'AB+',
      'A-',
      'O-',
      'B-',
      'AB-'
    ];

    var parentesco = <String>[
      'HERMANO',
      'HERMANA',
      'PADRE',
      'MADRE',
      'ABUELO',
      'ABUELA',
      'TIO',
      'TIA',
    ];

    // cresmo una lsita de las

    var ageStudent = <int>[14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25];

    final groupServices = Provider.of<GroupServices>(context, listen: true);

    final semestreServices =
        Provider.of<SemestreServices>(context, listen: true);

    final generationServices =
        Provider.of<GenerationServices>(context, listen: true);

    List<Semestre> semestres = semestreServices.semestres;
    final groups = groupServices.group;
    final generations = generationServices.generations;

    String blood_type_default = bloodType.first;

    // hacemos la instancia  de la clase para retorn la funcion

    Size size = MediaQuery.of(context).size;
    final double screenWidth = size.width;
    final double screenHeight = size.height;
    final studentServices =
        Provider.of<StudentsServices>(context, listen: false);

    // Creamos una lista de areas.
    final List<String> areas = [
      'Fisicos Matemeeticos',
      'Quimicos Biologos',
      'Ciencias Sociales',
      'Economicos Administrativos',
      'Tronco Comun'
    ];

    String numberPhone1 = students.numberPhone.toString();
    String numberPhone2 = students.studentTutor.numberPhoneTutor.toString();
    print('datos de los numeros de telefono ');
    print(numberPhone1);
    print(numberPhone2);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear datos del alumno'),
      ),
      body: Padding(
        padding: Platform.isWindows || Platform.isMacOS
            ? const EdgeInsets.all(50)
            : const EdgeInsets.all(8),
        child: Container(
          width: size.width,
          // height: ,
          // color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Text('Ancho de la pantalla ${screenWidth}'),
                // Text('Ancho de la altura  ${screenHeight}'),
                Form(
                  key: _formKey,
                  child: Platform.isWindows || Platform.isMacOS
                      ? ContentWindowsMac(
                          // tuition,
                          size,
                          dropMenuProvider,
                          gender,
                          context,
                          bloodType,
                          ageStudent,
                          parentesco,
                          groups,
                          semestres,
                          generations,
                          studentServices,
                          areas,
                          students,
                          numberPhone1, // for student
                          numberPhone2 // for tutor the student
                          )
                      : ContentAndroidIos(
                          size,
                          dropMenuProvider,
                          gender,
                          context,
                          bloodType,
                          ageStudent,
                          parentesco,
                          groups,
                          semestres,
                          generations,
                          studentServices),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column ContentAndroidIos(
      Size size,
      MenuOptionProvider dropMenuProvider,
      List<String> gender,
      BuildContext context,
      List<String> bloodType,
      List<int> ageStudent,
      List<String> parentesco,
      Groups group,
      List<Semestre> semestre,
      List<Generation> generation,
      StudentsServices studentServices) {
    return Column(
      children: [
        Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            // datos personales
            const Text(
              'Datos Personales',
              // style: TextStyle(
              //     fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              runSpacing: 30,
              spacing: 40,
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: size.height * 0.5,
                  // height: 60,
                  child: TextFormField(
                    onChanged: (String value) {
                      student.name = value;
                    },
                    decoration: InputDecorations.authDecoration(
                        hintText: '',
                        labelText: 'Nombre',
                        prefixIcon: Icons.near_me),
                  ),
                ),
                SizedBox(
                  width: size.height * 0.5,
                  // height: 60,
                  child: TextFormField(
                    onChanged: (value) => student.lastName = value,
                    decoration: InputDecorations.authDecoration(
                        hintText: '',
                        labelText: 'Apelllido Paterno',
                        prefixIcon: Icons.add_a_photo),
                  ),
                ),
                SizedBox(
                  width: size.height * 0.5,
                  // height: 60,
                  child: TextFormField(
                    onChanged: (value) => student.lastName = value,
                    decoration: InputDecorations.authDecoration(
                        hintText: '',
                        labelText: 'Apelllido Materno',
                        prefixIcon: Icons.add_a_photo),
                  ),
                ),
                SizedBox(
                  width: 250,
                  child: Row(
                    children: [
                      const Text('Sexo'),
                      const SizedBox(
                        width: 20,
                      ),
                      DropdownButton<String>(
                        value: dropMenuProvider.dropdownMenuItemSexoGet,
                        icon: const Icon(Icons.arrow_downward),
                        elevation: 5,
                        style: const TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          dropMenuProvider.dropdownMenuItemSexo = value!;
                          genderSelect = value;

                          print('Sexo' + "" + value);
                        },
                        items: gender
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),

                Row(
                  children: [
                    SizedBox(
                      width: 200,
                      child: Column(
                        children: [
                          const Text('Fecha de nacimiento'),
                          const SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                _selectDate(context);
                              },
                              child: const Text('Seleccion la fecha ')),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                              "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}"),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 130,
                      child: Row(
                        children: [
                          const Text('Edad'),
                          const SizedBox(
                            width: 15,
                          ),
                          DropdownButton<int>(
                              value: dropMenuProvider.ageStudent,
                              items: ageStudent
                                  .map((int value) => DropdownMenuItem<int>(
                                      value: value,
                                      child: Text(value.toString())))
                                  .toList(),
                              onChanged: (int? value) {
                                dropMenuProvider.ageStudent = value!;
                                // student.age = value;
                                // print('Datos e los estudiantes');
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 250,
                  child: Row(
                    children: [
                      const Text('Tipo de sangre'),
                      const SizedBox(width: 50),
                      DropdownButton(
                          elevation: 6,
                          value: dropMenuProvider.bloogGradStudent,
                          //  retorno d los tipos de sangre
                          items: bloodType
                              .map<DropdownMenuItem<String>>((String value) =>
                                  DropdownMenuItem<String>(
                                      value: value, child: Text(value)))
                              .toList(),
                          onChanged: (String? value) {
                            dropMenuProvider.bloogGradStudent = value!;
                            student.bloodGrade = value;
                          }),
                    ],
                  ),
                ),
                SizedBox(
                  // height: 60,
                  width: size.width,
                  child: TextFormField(
                    decoration: InputDecorations.authDecoration(
                      hintText: '',
                      labelText: 'Curp',
                      // prefixIcon: Icons.document_scanner_sharp
                    ),
                    onChanged: (value) => student.curp = value,
                  ),
                ),

                // FIEL FOR INSRT AGE O LA EDAD EN ESPALOL

                // para  crear  el usuario y la contraseña
                SizedBox(
                  width: size.width,
                  // height: 60,
                  child: TextFormField(
                    decoration: InputDecorations.authDecoration(
                      hintText: '',
                      labelText: 'Matricula',
                      // prefixIcon: Icons.document_scanner_sharp
                    ),
                    onChanged: (value) => student.tuition = value,
                  ),
                ),
                SizedBox(
                  width: size.width,
                  // height: 60,
                  child: TextFormField(
                    obscureText: true,
                    onChanged: (value) => student.password = value,
                    decoration: InputDecorations.authDecoration(
                      hintText: '',

                      labelText: 'Contraseña',
                      // prefixIcon: Icons.document_scanner_sharp
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 20,
            ),
          ],
        ),

        // TODO:  date tutor

        // datoTutor(parentesco, size),
        Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            const Text(
              'Datos del tutor',
              // style: TextStyle(
              //     fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
            ),
            Wrap(
              runSpacing: 10,
              spacing: 10,
              // mainAxisAlignment:
              //     MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: size.width,
                  // height: 60,
                  child: TextFormField(
                    onChanged: (value) =>
                        student.studentTutor.nameTutor = value,
                    decoration: InputDecorations.authDecoration(
                      hintText: '',
                      labelText: 'Nombre',
                      // prefixIcon: Icons.document_scanner_sharp
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.7,
                  // height: 60,
                  child: TextFormField(
                    onChanged: (value) =>
                        student.studentTutor.lastNameTutor = value,
                    decoration: InputDecorations.authDecoration(
                      hintText: '',
                      labelText: 'Apellido Paterno',
                      // prefixIcon: Icons.document_scanner_sharp
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.7,
                  // height: 60,
                  child: TextFormField(
                    onChanged: (value) =>
                        student.studentTutor.secondNameTutor = value,
                    decoration: InputDecorations.authDecoration(
                      hintText: '',
                      labelText: 'Apellido Materno',
                      // prefixIcon: Icons.document_scanner_sharp
                    ),
                  ),
                ),
                SizedBox(
                  // width: 150,
                  width: size.width * 0.7,
                  // height: 40,
                  child: TextFormField(
                    onChanged: (value) {
                      phoneStudent = value;
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecorations.authDecoration(
                      hintText: '',
                      labelText: 'Telefono',
                      // prefixIcon: Icons.document_scanner_sharp
                    ),
                  ),
                ),
                Row(
                  children: [
                    const Text('Parentesco'),
                    const SizedBox(
                      width: 20,
                    ),
                    DropdownButton<String>(
                        isExpanded: false,
                        value: dropMenuProvider.parectencoStudent,
                        items: List.generate(
                            parentesco.length,
                            (index) => DropdownMenuItem<String>(
                                value: parentesco[index],
                                child: Text(parentesco[index]))),
                        onChanged: (String? value) {
                          dropMenuProvider.parectencoStudent = value!;
                          student.studentTutor.kinship = value;
                        }),
                  ],
                ),
              ],
            ),
          ],
        ),

        // datos escolares

        // datos escolares
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Datos Escolares del alumno',
              // style: TextStyle(
              //     fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold
              //     ),
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //cresremos a cada uno de los drop down
                Row(
                  children: [
                    const Text('Grupo'),
                    const SizedBox(
                      width: 10,
                    ),
                    DropdownButton(
                        value: dropMenuProvider.dropdownMenuItemGroup,
                        items:
                            group.groups.map<DropdownMenuItem<String>>((value) {
                          return DropdownMenuItem<String>(
                              onTap: () {
                                dropMenuProvider.dropdownMenuItemGroup =
                                    value.uid;
                              },
                              value: value.name,
                              child: Text(value.name));
                        }).toList(),
                        onChanged: (String? value) {
                          dropMenuProvider.dropdownMenuItemGroup = value!;
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
                              dropMenuProvider.dropdownMenuItemSemestre =
                                  semestre[index].uid;
                              student.semestre.add(semestre[index].uid);
                            },
                            value: semestre[index].name,
                            child: Text(semestre[index].name))),
                    onChanged: (String? value) {
                      dropMenuProvider.dropdownMenuItemSemestre = value!;
                    }),

                // lista de las generaciones

                DropdownButton<String>(
                    // value: generation.first.initialDate.toString(),

                    value: dropMenuProvider.dropDownMenuItemGeneracion,
                    items: List.generate(
                        generation.length,
                        (index) => DropdownMenuItem(
                            onTap: () {
                              dropMenuProvider.dropDownMenuItemGeneracion =
                                  generation[index].uid;
                              student.generation = generation[index].uid;
                            },
                            value: generation[index].initialDate.toString(),
                            child: Text(
                                '${generation[index].initialDate.year} - ${generation[index].finalDate.year}'))),
                    onChanged: (String? value) {
                      dropMenuProvider.dropDownMenuItemGeneracion = value!;
                    })
              ],
            ),
          ],
        ),

        const SizedBox(
          height: 20,
        ),
        // datoEscolar(dropMenuProvider, group, semestre, generacion)

        MaterialButton(
          onPressed: () async {
            if (ageSelect == null ||
                genderSelect == null ||
                bloodGradeSelect == null ||
                kinshipSelect == null ||
                groupSelect == null ||
                semestreSelect == null ||
                generationSelect == null) {
              print('No se ha seleccionado da de los DropDown');

              // Mostrar un mensaje de error si no se ha seleccionado una opción
              return showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text("Error"),
                  content: const Text("Por favor, seleccione una opción."),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Aceptar'),
                    )
                  ],
                ),
              );
            }

            if (_formKey.currentState!.validate()) {
              // hacer algo

              // final studentServices =
              //     Provider.of<StudentsServices>(context, listen: false);

              student.gender = genderSelect!;
              student.bloodGrade = bloodGradeSelect!;
              student.age = ageSelect!;
              student.studentTutor.kinship = kinshipSelect!;
              student.group = groupSelect!;
              student.semestre.add(semestreSelect!);

              student.generation = generationSelect!;

              student.numberPhone = int.parse(phoneStudent!);
              student.studentTutor.numberPhoneTutor = int.parse(phoneTutor!);
              await studentServices.registerStudent(student);
              print(student.name);

              // final studentServices =
              //     Provider.of<StudentsServices>(context, listen: false);
              // await studentServices.registerStudent(student);
              // print(student.name);

            }
          },
          child: studentServices.status == true
              ? const CircularProgressIndicator()
              : const Text('Registrar'),
        ),
      ],
    );
  }
  // para moviles

  Column ContentWindowsMac(
      // String tuition,
      Size size,
      MenuOptionProvider dropMenuProvider,
      List<String> gender,
      BuildContext context,
      List<String> bloodType,
      List<int> ageStudent,
      List<String> parentesco,
      Groups group,
      List<Semestre> semestre,
      List<Generation> generation,
      StudentsServices studentServices,
      List<String> areas,
      Students students,
      String numberPhone1,
      String numberPhone2) {
    return Column(
      children: [
        Column(
          children: [
            // const SizedBox(
            //   height: 10,
            // ),
            // datos personales
            const Text(
              'Datos Personales',
              // style: TextStyle(
              //     fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              runSpacing: 50,
              spacing: 40,
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: size.width * 0.2,
                  // height: 60,
                  child: TextFormField(
                    initialValue: students.name,
                    onChanged: (String value) {
                      student.name = value;
                    },
                    decoration: InputDecorations.authDecoration(
                        hintText: '',
                        labelText: 'Nombre',
                        prefixIcon: Icons.near_me),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Ingresa el nombre';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  width: size.width * 0.2,
                  // height: 60,
                  child: TextFormField(
                    initialValue: students.lastName,
                    onChanged: (value) => student.lastName = value,
                    decoration: InputDecorations.authDecoration(
                        hintText: '',
                        labelText: 'Apelllido Paterno',
                        prefixIcon: Icons.person),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Ingresa el apellido paterno';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  width: size.width * 0.2,
                  // height: 60,
                  child: TextFormField(
                    initialValue: students.secondName,
                    onChanged: (value) => student.secondName = value,
                    decoration: InputDecorations.authDecoration(
                        hintText: '',
                        labelText: 'Apelllido Materno',
                        prefixIcon: Icons.add_a_photo),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Ingresa el apellido materno';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: Row(
                    children: [
                      const Text('Sexo'),
                      const SizedBox(
                        width: 20,
                      ),

                      // sexo
                      DropdownButton<String>(
                        // value: students.gender,
                        value: dropMenuProvider.dropdownMenuItemSexoGet,
                        icon: const Icon(Icons.arrow_downward),
                        elevation: 5,
                        // style: const TextStyle(color: Colors.deepPurple),
                        // underline: Container(
                        //   height: 2,
                        //   color: Colors.deepPurpleAccent,
                        // ),
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          dropMenuProvider.dropdownMenuItemSexo = value!;
                          // student.gender = value;
                          print('Sexo' + "" + value);
                          genderSelect = value;
                        },
                        items: gender
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            onTap: () {
                              genderSelect = value;
                            },
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  width: 300,
                  child: Column(
                    children: [
                      const Text('Fecha de nacimiento'),
                      const SizedBox(
                        width: 20,
                      ),
                      Row(
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                _selectDate(context);
                              },
                              child: const Text('Seleccion la fecha ')),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                              students.dateOfBirth.toString().substring(0, 10)),

                          // Text(
                          //     "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}"),
                          //  student.secondName = selectedDate;
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 260,
                  child: Row(
                    children: [
                      const Text('Tipo de sangre'),
                      const SizedBox(width: 50),
                      DropdownButton(
                          elevation: 6,
                          value: dropMenuProvider.bloogGradStudent,
                          // value: students.bloodGrade,
                          //  retorno d los tipos de sangre
                          items: bloodType
                              .map<DropdownMenuItem<String>>((String value) =>
                                  DropdownMenuItem<String>(
                                      value: value, child: Text(value)))
                              .toList(),
                          onChanged: (String? value) {
                            dropMenuProvider.bloogGradStudent = value!;
                            // student.bloodGrade = value;
                            bloodGradeSelect = value;
                          }),
                    ],
                  ),
                ),
                SizedBox(
                  // height: 60,
                  width: size.width * 0.2,
                  child: TextFormField(
                    initialValue: students.curp,
                    onChanged: (value) => student.curp = value,
                    decoration: InputDecorations.authDecoration(
                      hintText: '',
                      labelText: 'Curp',
                      // prefixIcon: Icons.document_scanner_sharp
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Ingresa el Curp';
                      }
                      return null;
                    },
                  ),
                ),

                // FIEL FOR INSRT AGE O LA EDAD EN ESPALOL

                SizedBox(
                  width: 110,
                  child: Row(
                    children: [
                      const Text('Edad'),
                      const SizedBox(
                        width: 15,
                      ),
                      DropdownButton<int>(
                          value: dropMenuProvider.ageStudent,
                          // value: students.age,
                          items: ageStudent
                              .map((int value) => DropdownMenuItem<int>(
                                  value: value, child: Text(value.toString())))
                              .toList(),
                          onChanged: (int? value) {
                            dropMenuProvider.ageStudent = value!;
                            // student.age = value;
                            ageSelect = value;
                            // print('Datos e los estudiantes');
                          }),
                    ],
                  ),
                ),

                // direccion town
                // para  crear  el usuario y la contraseña
                SizedBox(
                  width: 320,
                  // height: 40,
                  child: TextFormField(
                    onChanged: (value) => student.town = value,
                    initialValue: students.town,
                    decoration: InputDecorations.authDecoration(
                      hintText: '',
                      labelText: 'Direccion',
                      // prefixIcon: Icons.document_scanner_sharp
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Ingresa Direccion';
                      }
                      return null;
                    },
                  ),
                ),
                // number phone

                // para  crear  el usuario y la contraseña
                SizedBox(
                  width: 200,
                  // height: 40,
                  child: TextFormField(
                    initialValue: numberPhone1,
                    onChanged: (value) => phoneStudent = value,
                    // controller: numberPhoneStudent,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      final isDigitsOnly = RegExp(r'^\d+$').hasMatch(value!);
                      if (!isDigitsOnly || value.isEmpty) {
                        return 'Por favor ingrese solo números';
                      }
                      return null;
                    },

                    decoration: InputDecorations.authDecoration(
                      hintText: '',
                      labelText: 'Telefono',
                      // prefixIcon: Icons.document_scanner_sharp
                    ),
                  ),
                ),

                // para  crear  el usuario y la contraseña
                SizedBox(
                  width: 200,
                  // height: 40,
                  child: TextFormField(
                    onChanged: (value) => student.email = value,
                    initialValue: students.email,
                    decoration: InputDecorations.authDecoration(
                      hintText: '',
                      labelText: 'Correo electronico',
                      // prefixIcon: Icons.document_scanner_sharp
                    ),
                    validator: (value) {
                      String pattern =
                          r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z]{2,})$';
                      RegExp regex = RegExp(pattern);

                      if (!regex.hasMatch(value!)) {
                        return 'Ingresa un correo electronico valido';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                // para  crear  el usuario y la contraseña
                SizedBox(
                  width: 200,
                  // height: 40,
                  child: TextFormField(
                    initialValue: students.tuition,
                    onChanged: (value) => student.tuition = value,
                    decoration: InputDecorations.authDecoration(
                      hintText: '',
                      labelText: 'Matricula',
                      // prefixIcon: Icons.document_scanner_sharp
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Ingresa la matricula';
                      }
                      return null;
                    },
                  ),
                ),

                SizedBox(
                  width: 300,
                  // height: 40,
                  child: TextFormField(
                    initialValue: students.password,
                    onChanged: (value) => student.password = value,
                    decoration: InputDecorations.authDecoration(
                      hintText: '',
                      labelText: 'Contraseña',
                      // prefixIcon: Icons.document_scanner_sharp
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Este campo es obligatorio';
                      } else if (value.length < 8) {
                        return 'La contraseña debe tener 8 caracteres';
                      } else if (!RegExp(
                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$')
                          .hasMatch(value)) {
                        return ' Letra mayúscula,  minúscula  y un número';

                        // return 'La contraseña debe contener al menos una letra mayúscula, una letra minúscula y un número';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 20,
            ),
          ],
        ),
        // TODO:  date tutor

        // datoTutor(parentesco, size),
        Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            const Text(
              'Datos del tutor',
              // style: TextStyle(
              //     fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
            ),

            const SizedBox(
              height: 15,
            ),

            Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,

              runSpacing: 50,
              spacing: 40,
              // mainAxisAlignment:
              // MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 300,
                  // height: 60,
                  child: TextFormField(
                    initialValue: students.studentTutor.nameTutor,
                    onChanged: (value) =>
                        student.studentTutor.nameTutor = value,
                    decoration: InputDecorations.authDecoration(
                      hintText: '',
                      labelText: 'Nombre',
                      // prefixIcon: Icons.document_scanner_sharp
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Este campo es obligatorio';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  width: 250,
                  // height: 60,
                  child: TextFormField(
                    initialValue: students.studentTutor.lastNameTutor,
                    onChanged: (value) =>
                        student.studentTutor.lastNameTutor = value,
                    decoration: InputDecorations.authDecoration(
                      hintText: '',
                      labelText: 'Apellido Paterno',
                      // prefixIcon: Icons.document_scanner_sharp
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Este campo es obligatorio';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  width: 250,
                  // height: 60,
                  child: TextFormField(
                    initialValue: students.studentTutor.secondNameTutor,
                    onChanged: (value) =>
                        student.studentTutor.secondNameTutor = value,
                    decoration: InputDecorations.authDecoration(
                      hintText: '',
                      labelText: 'Apellido Materno',
                      // prefixIcon: Icons.document_scanner_sharp
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Este campo es obligatorio';
                      }
                      return null;
                    },
                  ),
                ),
                Column(
                  children: [
                    const Text('Parentesco'),
                    DropdownButton<String>(
                        isExpanded: false,
                        value: dropMenuProvider.parectencoStudent,
                        // value: students.studentTutor.kinship,
                        items: List.generate(
                            parentesco.length,
                            (index) => DropdownMenuItem<String>(
                                  onTap: () {
                                    // student.studentTutor.kinship =
                                    //     parentesco[index];
                                    kinshipSelect = parentesco[index];
                                  },
                                  value: parentesco[index],
                                  child: Text(parentesco[index]),
                                )),
                        // parentesco
                        // .map((String value) => DropdownMenuItem<String>(

                        //     value: value, child: Text(value)))
                        // .toList(),
                        onChanged: (String? value) {
                          dropMenuProvider.parectencoStudent = value!;
                          // kinshipSelect = value;

                          // student.studentTutor.nameTutor = value;
                        }),
                  ],
                ),
                SizedBox(
                  // width: 150,
                  width: size.height * 0.25,
                  // height: 40,
                  child: TextFormField(
                    initialValue: numberPhone2,
                    // students.studentTutor.numberPhoneTutor.toString(),
                    onChanged: (value) => phoneTutor = value,
                    validator: (value) {
                      // // Expresión regular para verificar si la entrada es numérica
                      final isDigitsOnly = RegExp(r'^\d+$').hasMatch(value!);
                      if (!isDigitsOnly || value.isEmpty) {
                        return 'Por favor ingrese solo números';
                      }
                      return null;
                    },

                    // student.studentTutor.numberPhoneTutor = int.parse(value);
                    decoration: InputDecorations.authDecoration(
                      hintText: '',
                      labelText: 'Telefono',
                      // prefixIcon: Icons.document_scanner_sharp
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),

            // TODO: DATOS DE LAS ESCUELAS
            const Text(
              'Datos Escolares del alumno',
              // style: TextStyle(
              //     fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold
              //     ),
            ),
            const SizedBox(height: 20),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,

              runSpacing: 50,
              spacing: 40,

              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // areas
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
                                    student.specialtyArea = areas[index];
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
                SizedBox(
                  width: 200,
                  child: Row(
                    children: [
                      const Text('Grupo'),
                      const SizedBox(
                        width: 10,
                      ),
                      DropdownButton(
                          value: dropMenuProvider.dropdownMenuItemGroup,
                          items: List.generate(
                              group.groups.length,
                              (index) => DropdownMenuItem<String>(
                                  onTap: () {
                                    // student.group = group[index].uid;
                                    groupSelect = group.groups[index].uid;
                                  },
                                  value: group.groups[index].name,
                                  child: Text(group.groups[index].name))),
                          onChanged: (String? value) {
                            dropMenuProvider.dropdownMenuItemGroup = value!;
                          }),
                      //  group
                      //     .map<DropdownMenuItem<String>>((value) =>
                      //         DropdownMenuItem<String>(
                      //             value: value.name, child: Text(value.name)))
                      //     .toList(),
                      // onChanged: (String? value) {
                      //   dropMenuProvider.dropdownMenuItemGroup = value!;
                      // }

                      // ),
                    ],
                  ),
                ),

                // lsita de los semestre
                SizedBox(
                  width: 210,
                  child: Row(
                    children: [
                      const Text('Semestre'),
                      const SizedBox(width: 20),
                      DropdownButton<String>(
                          value: dropMenuProvider.dropdownMenuItemSemestre,
                          items: List.generate(
                              semestre.length,
                              (index) => DropdownMenuItem<String>(
                                  onTap: () {
                                    // student.semestre.add(semestre[index].uid);
                                    // semestreSelect.add(semestre[index].uid);
                                    semestreSelect = semestre[index].uid;
                                  },
                                  value: semestre[index].name,
                                  child: Text(semestre[index].name))),
                          onChanged: (String? value) {
                            dropMenuProvider.dropdownMenuItemSemestre = value!;
                          }),
                    ],
                  ),
                ),

                // lista de las generaciones

                SizedBox(
                  width: 210,
                  child: Row(
                    children: [
                      const Text('Generacion'),
                      const SizedBox(width: 20),
                      DropdownButton<String>(
                          // value: generation.first.initialDate.toString(),

                          value: dropMenuProvider.dropDownMenuItemGeneracion,
                          items: List.generate(
                              generation.length,
                              (index) => DropdownMenuItem(
                                  onTap: () {
                                    // student.generation = generation[index].uid;
                                    generationSelect = generation[index].uid;
                                  },
                                  value:
                                      generation[index].initialDate.toString(),
                                  child: Text(
                                      '${generation[index].initialDate.year} - ${generation[index].finalDate.year}'))),

                          //  generation
                          //     .map<
                          //         DropdownMenuItem<
                          //             String>>((value) => DropdownMenuItem(
                          //         value: value.initialDate.toString(),
                          //         child: Text(
                          //             '${value.initialDate.year} - ${value.finalDate.year}')))
                          //     .toList(),
                          onChanged: (String? value) {
                            dropMenuProvider.dropDownMenuItemGeneracion =
                                value!;
                          }),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),

        const SizedBox(
          height: 20,
        ),
        // datoEscolar(dropMenuProvider, group, semestre, generacion)

        MaterialButton(
          onPressed: () async {
            if (ageSelect == null ||
                genderSelect == null ||
                bloodGradeSelect == null ||
                kinshipSelect == null ||
                groupSelect == null ||
                semestreSelect == null ||
                generationSelect == null ||
                phoneStudent == null ||
                phoneTutor == null) {
              print('No se ha seleccionado da de los DropDown');

              // Mostrar un mensaje de error si no se ha seleccionado una opción
              return showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text("Error"),
                  content: const Text("Por favor, seleccione una opción."),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Aceptar'),
                    )
                  ],
                ),
              );
            }

            if (_formKey.currentState!.validate()) {
              // hacer algo

              final studentServices =
                  Provider.of<StudentsServices>(context, listen: false);

              student.gender = genderSelect!;
              student.bloodGrade = bloodGradeSelect!;
              student.age = ageSelect!;
              student.studentTutor.kinship = kinshipSelect!;
              student.group = groupSelect!;
              student.semestre.add(semestreSelect!);

              student.generation = generationSelect!;

              student.numberPhone = int.parse(phoneStudent!);
              student.studentTutor.numberPhoneTutor = int.parse(phoneTutor!);
              await studentServices.updateStudent(student, students.uid.toString());
              print('Update student data');

              print(student.name);
            }
          },
          child: studentServices.status == true
              ? const CircularProgressIndicator()
              : const Text('Registrares'),
        ),
      ],
    );
  }

// funciuon para las fechas
  _selectDate(BuildContext context) async {
    // varaible que guarda la fecha seleccionada
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1990),
      lastDate: DateTime(2050),
      // cambaira el texto de los botones
      helpText: 'Seleccionar Fecha ',
      cancelText: 'Cancelar',
      confirmText: 'Guardar',
      // locale: const Locale('es', 'MX'),
    );

    // si para una de stas condiciones actualizamos el  datos
    if (selected != null && selected != selectedDate) {
      setState(() {
        student.dateOfBirth = selected;
        selectedDate = selected;
      });
    }
  }
}
