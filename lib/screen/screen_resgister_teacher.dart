import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_escolar_prepa/providers/form_teacher.dart';
import 'package:sistema_escolar_prepa/providers/menu_option_provider.dart';

import '../Services/teacher_services.dart';

import 'dart:io';

import '../widgets/text_fileds.dart';

class ScreenRegisterTeacher extends StatefulWidget {
  const ScreenRegisterTeacher({Key? key}) : super(key: key);

  @override
  State<ScreenRegisterTeacher> createState() => _ScreenRegisterTeacherState();
}

class _ScreenRegisterTeacherState extends State<ScreenRegisterTeacher> {
  final List<String> rol = [
    'DIRECTOR',
    'PROFESOR',
    'CONTROL ESCOLAR',
    'SUB DIRECTOR',
    'STUDENT'
  ];
  final List<String> gender = ['MASCULINO', 'FEMENINO'];

  final List<String> typeContract = ['BASE', 'INTERINADO'];

  @override
  Widget build(BuildContext context) {
    final teacherServicesStatus = Provider.of<TeachaerServices>(context);

    final teacherFormProvider = Provider.of<TeacherFormProvider>(context);
    final menuOptionProvider = Provider.of<MenuOptionProvider>(context);

    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text('Registrar Docente')),
      body: Padding(
        padding: Platform.isAndroid || Platform.isIOS
            ? const EdgeInsets.symmetric(horizontal: 15)
            : const EdgeInsets.all(50.0),
        child: SingleChildScrollView(
          child: Form(
            key: teacherFormProvider.formKey,
            // funcion para la validacion de los  datos
            // autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Platform.isWindows || Platform.isMacOS
                ?

// forwindows

                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 80,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            // height: 50,
                            width: 370,
                            child: TextFormField(
                              onChanged: (value) {
                                teacherFormProvider.teacher.name = value;
                              },
                              validator: (value) {
                                if (value == null || value.length <= 1) {
                                  return 'INGRESA EL NOMBRE';
                                }
                              },
                              // autocorrect: true,
                              decoration:
                                  const InputDecoration(labelText: 'Nombre'),
                            ),
                          ),
                          SizedBox(
                            // height: 50,
                            width: 370,
                            child: TextFormField(
                              onChanged: (value) {
                                teacherFormProvider.teacher.lastName = value;
                              },
                              validator: (value) {
                                if (value == null || value.length <= 1) {
                                  return 'INGRESA EL   APELLIDO PATERNO';
                                }
                              },
                              autocorrect: true,
                              decoration: const InputDecoration(
                                  labelText: 'Apellido Paterno'),
                            ),
                          ),
                          SizedBox(
                            // height: 50,
                            width: 370,
                            // width: size.width * 0.15,
                            child: TextFormField(
                              onChanged: (value) {
                                teacherFormProvider.teacher.secondName = value;
                              },
                              validator: (value) {
                                if (value == null || value.length <= 1) {
                                  return 'INGRESA EL  APELLIDO MATERNO';
                                }
                              },
                              autocorrect: true,
                              decoration: const InputDecoration(
                                  labelText: 'Apellido Materno'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),

                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,

                        children: [
                          Row(
                            children: [
                              const Text('Sexo'),
                              const SizedBox(
                                width: 20,
                              ),
                              DropdownButton<String>(
                                  value: menuOptionProvider.genderTeacher,
                                  items: gender
                                      .map((e) => DropdownMenuItem<String>(
                                          value: e, child: Text(e)))
                                      .toList(),
                                  onChanged: (value) {
                                    menuOptionProvider.genderTeacher = value!;

                                    teacherFormProvider.teacher.gender = value;
                                  }),
                            ],
                          ),

                          // tipo de sangre
                          Row(
                            children: [
                              const Text('Rol'),
                              const SizedBox(
                                width: 15,
                              ),
                              DropdownButton<String>(
                                  value: menuOptionProvider.rolTeacher,
                                  items: rol
                                      .map((e) => DropdownMenuItem<String>(
                                          value: e, child: Text(e)))
                                      .toList(),
                                  onChanged: (value) {
                                    menuOptionProvider.rolTeacher = value!;

                                    teacherFormProvider.teacher.rol = value!;
                                  }),
                            ],
                          ),

                          // titulo universitario
                          SizedBox(
                            height: 45,
                            width: 370,
                            child: TextFormField(
                              onChanged: (value) {
                                teacherFormProvider.teacher.collegeDegree =
                                    value;
                              },
                              validator: (value) {
                                if (value == null || value.length <= 1) {
                                  return 'INGRESA EL TITULO';
                                }
                              },
                              decoration: const InputDecoration(
                                labelText: 'Titulo',
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      // tercerap parte
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,

                        children: [
                          Row(
                            children: [
                              const Text('Tipo de contrato'),
                              const SizedBox(
                                width: 20,
                              ),
                              DropdownButton<String>(
                                  value: menuOptionProvider.typeContracTeacher,
                                  items: typeContract
                                      .map((e) => DropdownMenuItem<String>(
                                          value: e, child: Text(e)))
                                      .toList(),
                                  onChanged: (value) {
                                    menuOptionProvider.typeContracTeacher =
                                        value!;
                                    teacherFormProvider.teacher.typeContract =
                                        value!;
                                  }),
                            ],
                          ),
                          SizedBox(
                            width: 200,
                            // height: 40,
                            child: TextFormField(
                              // controller: numberPhoneStudent,
                              keyboardType: TextInputType.number,

                              validator: (value) {
                                // if (value!.isEmpty) {
                                //   return 'Por favor ingrese un número';
                                // }
                                // if (int.tryParse(value) == null) {
                                //   return 'Por favor ingrese solo números';
                                // }
                                // return null;

                                // // Expresión regular para verificar si la entrada es numérica
                                final isDigitsOnly =
                                    RegExp(r'^\d+$').hasMatch(value ?? '');
                                if (!isDigitsOnly) {
                                  return 'Por favor ingrese solo números';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                // student.numberPhone = int.parse(value);
                                // phoneStudent = value;
                                teacherFormProvider.teacher.numberPhone =
                                    value!;
                              },
                              initialValue: '',
                              decoration: InputDecorations.authDecoration(
                                hintText: '',
                                labelText: 'Telefono',
                                // prefixIcon: Icons.document_scanner_sharp
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 200,
                            // height: 40,
                            child: TextFormField(
                              // controller: numberPhoneStudent,
                              keyboardType: TextInputType.number,

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
                              onChanged: (value) {
                                // student.numberPhone = int.parse(value);

                                teacherFormProvider.teacher.email = value;
                              },
                              initialValue: '',
                              decoration: InputDecorations.authDecoration(
                                hintText: '',
                                labelText: 'Telefono',
                                // prefixIcon: Icons.document_scanner_sharp
                              ),
                            ),
                          ),
                        ],
                      ),

  Row(children: [
        Row(
                            children: [
                              const Text('Matricula'),
                              const SizedBox(
                                width: 15,
                              ),
                              SizedBox(
                                // height: 35,
                                width: 370,
                                child: TextFormField(
                                  onChanged: (value) {
                                    teacherFormProvider.teacher.tuition = value;
                                  },
                                  validator: (value) {
                                    if (value == null || value.length <= 1) {
                                      return 'INGRESA SU MATRICULA';
                                    }
                                  },
                                  decoration: const InputDecoration(
                                      labelText: 'Matricula'),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            // height: 35,
                            width: 370,
                            child: TextFormField(
                              obscureText: true,
                              onChanged: (value) {
                                teacherFormProvider.teacher.password = value;
                              },
                              validator: (value) {
                                if (value == null || value.length <= 1) {
                                  return 'INGRESA SU CONTRASEÑA';
                                }
                              },
                              decoration: const InputDecoration(
                                  labelText: 'Contraseña'),
                            ),
                          ),

  ]),
                
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            children: [
                              MaterialButton(
                                color: Colors.lightBlue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: const Text('REGISTRAR'),
                                onPressed: () {
                                  if (teacherFormProvider.isValidForm()) {
                                    final teacherServices =
                                        Provider.of<TeachaerServices>(context,
                                            listen: false);
                                    //  final teacher = Teachers(ScreenRegisterTeacher: ScreenRegisterTeacher, lastName: lastName, secondName: secondName, gender: gender, collegeDegree: collegeDegree, typeContract: typeContract, status: status, rol: rol, tuition: tuition, password: password, uid: uid)
                                    teacherServices.createTeacher(
                                        teacherFormProvider.teacher);

                                    // con esti limpiamos el campo de texto.

                                  }
                                  // Navigator.of(context).pop(controller.text);
                                },
                              ),
                              // MaterialButton(
                              //   color: Colors.lightBlue,
                              //   shape: RoundedRectangleBorder(
                              //     borderRadius: BorderRadius.circular(5),
                              //   ),
                              //   child: const Text('CANCELAR'),
                              //   onPressed: () {
                              //     Navigator.of(context).pop();
                              //     // Navigator.of(context).pop(controller.text);
                              //   },
                              // ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                : Column(
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      Wrap(
                        runSpacing: 20,
                        spacing: 10,
                        children: [
                          SizedBox(
                            // height: 50,
                            width: 370,
                            child: TextFormField(
                              onChanged: (value) {
                                teacherFormProvider.teacher.name = value;
                              },
                              validator: (value) {
                                if (value == null || value.length <= 1) {
                                  return 'INGRESA EL NOMBRE';
                                }
                              },
                              autocorrect: true,
                              decoration: InputDecorations.authDecoration(
                                hintText: '',
                                labelText: 'Nombre',
                                // prefixIcon: Icons.document_scanner_sharp
                              ),
                            ),
                          ),
                          SizedBox(
                            // height: 50,
                            width: 370,
                            child: TextFormField(
                              onChanged: (value) {
                                teacherFormProvider.teacher.lastName = value;
                              },
                              validator: (value) {
                                if (value == null || value.length <= 1) {
                                  return 'INGRESA EL   APELLIDO PATERNO';
                                }
                              },
                              autocorrect: true,
                              decoration: InputDecorations.authDecoration(
                                hintText: '',
                                labelText: 'Apellido Paterno',
                                // prefixIcon: Icons.document_scanner_sharp
                              ),
                            ),
                          ),
                          SizedBox(
                            // height: 50,
                            width: 370,
                            // width: size.width * 0.15,
                            child: TextFormField(
                              onChanged: (value) {
                                teacherFormProvider.teacher.secondName = value;
                              },
                              validator: (value) {
                                if (value == null || value.length <= 1) {
                                  return 'INGRESA EL  APELLIDO MATERNO';
                                }
                              },
                              autocorrect: true,
                              decoration: InputDecorations.authDecoration(
                                hintText: '',
                                labelText: 'Apellido Materno',
                                // prefixIcon: Icons.document_scanner_sharp
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              const Text('Sexo'),
                              const SizedBox(
                                width: 20,
                              ),
                              DropdownButton<String>(
                                  value: menuOptionProvider.genderTeacher,
                                  items: gender
                                      .map((e) => DropdownMenuItem<String>(
                                          value: e, child: Text(e)))
                                      .toList(),
                                  onChanged: (value) {
                                    menuOptionProvider.genderTeacher = value!;

                                    teacherFormProvider.teacher.gender = value;
                                  }),
                            ],
                          ),

                          // tipo de sangre
                          Row(
                            children: [
                              const Text('Rol'),
                              const SizedBox(
                                width: 15,
                              ),
                              DropdownButton<String>(
                                  value: menuOptionProvider.rolTeacher,
                                  items: rol
                                      .map((e) => DropdownMenuItem<String>(
                                          value: e, child: Text(e)))
                                      .toList(),
                                  onChanged: (value) {
                                    menuOptionProvider.rolTeacher = value!;

                                    teacherFormProvider.teacher.rol = value!;
                                  }),
                            ],
                          ),
                          SizedBox(
                            // height: 45,
                            width: 370,
                            child: TextFormField(
                              onChanged: (value) {
                                teacherFormProvider.teacher.collegeDegree =
                                    value;
                              },
                              validator: (value) {
                                if (value == null || value.length <= 1) {
                                  return 'INGRESA EL TITULO';
                                }
                              },
                              decoration: InputDecorations.authDecoration(
                                hintText: '',
                                labelText: 'Titulo',
                                // prefixIcon: Icons.document_scanner_sharp
                              ),
                            ),
                          ),

                          Row(
                            children: [
                              const Text('Tipo de contrato'),
                              const SizedBox(
                                width: 20,
                              ),
                              DropdownButton<String>(
                                  value: menuOptionProvider.typeContracTeacher,
                                  items: typeContract
                                      .map((e) => DropdownMenuItem<String>(
                                          value: e, child: Text(e)))
                                      .toList(),
                                  onChanged: (value) {
                                    menuOptionProvider.typeContracTeacher =
                                        value!;
                                    teacherFormProvider.teacher.typeContract =
                                        value!;
                                  }),
                            ],
                          ),

// phone email
                          SizedBox(
                            width: 370,
                            // height: 40,
                            child: TextFormField(
                              // controller: numberPhoneStudent,
                              keyboardType: TextInputType.number,

                              validator: (value) {
                                // if (value!.isEmpty) {
                                //   return 'Por favor ingrese un número';
                                // }
                                // if (int.tryParse(value) == null) {
                                //   return 'Por favor ingrese solo números';
                                // }
                                // return null;

                                // // Expresión regular para verificar si la entrada es numérica
                                final isDigitsOnly =
                                    RegExp(r'^\d+$').hasMatch(value ?? '');
                                if (!isDigitsOnly) {
                                  return 'Por favor ingrese solo números';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                // student.numberPhone = int.parse(value);
                                // phoneStudent = value;
                                teacherFormProvider.teacher.numberPhone =
                                    value.toString();
                              },
                              initialValue: '',
                              decoration: InputDecorations.authDecoration(
                                hintText: '',
                                labelText: 'Telefono',
                                // prefixIcon: Icons.document_scanner_sharp
                              ),
                            ),
                          ),

                          SizedBox(
                            width: 370,
                            // height: 40,
                            child: TextFormField(
                              // controller: numberPhoneStudent,
                              keyboardType: TextInputType.emailAddress,

                              validator: (value) {
                                // if (value!.isEmpty) {
                                //   return 'Por favor ingrese un número';
                                // }
                                // if (int.tryParse(value) == null) {
                                //   return 'Por favor ingrese solo números';
                                // }
                                // return null;

                                // // Expresión regular para verificar si la entrada es numérica
                                // final isDigitsOnly =
                                //     RegExp(r'^\d+$').hasMatch(value ?? '');
                                // if (!isDigitsOnly) {
                                //   return 'Por favor ingrese solo números';
                                // }
                                // return null;
                              },
                              onChanged: (value) {
                                // student.numberPhone = int.parse(value);
                                // phoneStudent = value;
                                teacherFormProvider.teacher.email = value;
                              },
                              initialValue: '',
                              decoration: InputDecorations.authDecoration(
                                hintText: '',
                                labelText: 'Correo Electronico',
                                // prefixIcon: Icons.document_scanner_sharp
                              ),
                            ),
                          ),

                          Column(
                            children: [
                              const Text('Matricula'),
                              const SizedBox(
                                width: 15,
                              ),
                              SizedBox(
                                // height: 35,
                                width: 370,
                                child: TextFormField(
                                  onChanged: (value) {
                                    teacherFormProvider.teacher.tuition = value;
                                  },
                                  validator: (value) {
                                    if (value == null || value.length <= 1) {
                                      return 'INGRESA SU MATRICULA';
                                    }
                                  },
                                  decoration: InputDecorations.authDecoration(
                                    hintText: '',
                                    labelText: 'Matricula',
                                    // prefixIcon: Icons.document_scanner_sharp
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(
                            // height: 35,
                            width: 370,
                            child: TextFormField(
                              obscureText: true,
                              onChanged: (value) {
                                teacherFormProvider.teacher.password = value;
                              },
                              validator: (value) {
                                if (value == null || value.length <= 1) {
                                  return 'INGRESA SU CONTRASEÑA';
                                }
                              },
                              decoration: InputDecorations.authDecoration(
                                hintText: '',
                                labelText: 'Contraeña',
                                // prefixIcon: Icons.document_scanner_sharp
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      MaterialButton(
                        color: Colors.lightBlue,
                        // color: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: teacherServicesStatus.status == false
                            ? const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 10),
                                child: Text('REGISTRAR'),
                              )
                            : const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 10),
                                child: CircularProgressIndicator(),
                              ),
                        onPressed: () async {
                          if (teacherFormProvider.isValidForm()) {
                            final teacherServices =
                                Provider.of<TeachaerServices>(context,
                                    listen: false);
                            //  final teacher = Teachers(ScreenRegisterTeacher: ScreenRegisterTeacher, lastName: lastName, secondName: secondName, gender: gender, collegeDegree: collegeDegree, typeContract: typeContract, status: status, rol: rol, tuition: tuition, password: password, uid: uid)
                            await teacherServices
                                .createTeacher(teacherFormProvider.teacher);
                                
                            await teacherServices.getTeachers();

                            // con esti limpiamos el campo de texto.

                          }
                          // Navigator.of(context).pop(controller.text);
                        },
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
