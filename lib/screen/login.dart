import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dart:io';

import '../Services/login_provider.dart';
import '../models/login.dart';
import '../providers/form_provider.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final load = LoginServices();
    // // load.loginUser();

    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white10, width: 0.3)),
          // color: Colors.white,
          width: Platform.isAndroid || Platform.isIOS
              ? size.width
              : size.width / 3,
          height: size.height,
          child: Center(
            child: _Form(size: size),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  final Size size;

  const _Form({Key? key, required this.size}) : super(key: key);

  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {
  final _formKey = GlobalKey<FormState>();

  String user = '';
  String password = '';

  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    userController.text = user;
    passwordController.text = password;
  }

  @override
  Widget build(BuildContext context) {
    // instancia de la clasep para la validacio de los datos.

    final loginFormProvider = Provider.of<LoginFormProvider>(context);
    // final loginServices = Provider.of<LoginFormProvider>(context);

    // controlador para los texto

    return Form(
        key: loginFormProvider.formKey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // image
                const Text('Preparatoria'),

                const Text('Rafael Pascacio Gamboa'),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: widget.size.width * 0.35,
                    height: widget.size.height * 0.2,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.asset('asset/prepa_logo.png')),
                  ),
                ),
                //  user
                // password
                SizedBox(
                  height: widget.size.height * 0.04,
                ),
                const Text('Login'),
                SizedBox(
                  height: widget.size.height * 0.04,
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Matricula'),
                    SizedBox(
                      width: 300,
                      child: TextFormField(
                        initialValue: user,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'INGRESA LA MATRICULA';
                          }
                        },
                        onChanged: (String value) {
                          user = value;
                          setState(() {});
                        },
                        onSaved: (String? value) {
                          user = value!;
                        },
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.alternate_email_outlined),
                          // border: BorderRadius.circular(5),
                          // hintText: 'Hola',  se  queda dentro del caja de texto
                          labelText: 'Matricula',
                          // border: OutlineInputBorder(
                          //   borderRadius: BorderRadius.circular(5),
                          // ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,

                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Contraseña'),
                    SizedBox(
                      width: 300,
                      child: TextFormField(
                        initialValue: password,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'INGRESA LA CONTRASEÑA';
                          }
                        },
                        onChanged: (String value) {
                          password = value;
                          setState(() {});
                        },
                        onSaved: (String? value) {
                          password = value!;
                        },
                        obscureText: true,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.password_outlined),

                          // border: BorderRadius.circular(5),
                          // hintText: 'Hola',  se  queda dentro del caja de texto
                          labelText: 'Contraseña',
                          // border: OutlineInputBorder(
                          //   borderRadius: BorderRadius.circular(5),
                          // ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: TextButton(
                            onPressed: () {},
                            child: const Text('CREAR CUENTA',
                                style: TextStyle(fontSize: 13))))
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),

                Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                      // style: ButtonStyle(
                      //   backgroundColor:
                      //       MaterialStateProperty.all<Color>(Colors.Colors.blueAccent),
                      // ),
                      onPressed: loginFormProvider.isLoading
                          ? null
                          : () async {
                              // validacio ndel formulario
                              if (!loginFormProvider.isValidate()) return;

                              final loginServices = LoginServices();

                              final login =
                                  LoginUser(user: user, password: password);

                              final String? loginError =
                                  await loginServices.loginUser(login);
                              // // loginFormProvider.isLoading = false;
                              //
                              if (loginError == null) {
                                // Navigator.pushNamed(context, 'home');

                                Navigator.pushReplacementNamed(
                                    context, 'check_auth_screen');

                                // hacemos la llamda de los datos de perfil

                              } else {
                                // cason contrario mostramos el error

                                print("MOSTRANDO EL ERROR" + loginError);
                                _mostrarMensajeError(
                                    'POR FAVOR INGRESA SU MATRICULA Y CONTRASEÑA');
                              }
                            },
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                        child: Text('INICIAR SESION'),
                      )),
                )
              ],
            ),
          ),
        ));
  }

  void _mostrarMensajeError(String mensaje) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error de inicio de sesion'),
          content: Text(mensaje),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}







// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../Services/login_provider.dart';
// import '../Services/teacher_services.dart';
// import '../models/login.dart';
// import '../providers/form_provider.dart';

// // para la definir que platafofmr se le esta haciendo el uso
// import 'dart:io';

// class Login extends StatelessWidget {
//   const Login({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     return Scaffold(
//       body: Center(
//         child: _Form(size: size),
//       ),
//     );
//   }
// }

// class _Form extends StatefulWidget {
//   final Size size;

//   const _Form({Key? key, required this.size}) : super(key: key);

//   @override
//   State<_Form> createState() => _FormState();
// }

// class _FormState extends State<_Form> {
//   String user = '';
//   String password = '';

//   TextEditingController userController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     userController.text = user;
//     passwordController.text = password;
//   }

//   @override
//   Widget build(BuildContext context) {
//     // instancia de la clasep para la validacio de los datos.

//     final loginFormProvider = Provider.of<LoginFormProvider>(context);
//     final loginServices = Provider.of<LoginServices>(context);
//     final teachaerServices =
//         Provider.of<TeachaerServices>(context, listen: false);

//     // controlador para los texto

//     return Container(
//       //  width: widget.size.width,
//       //   height: widget.size.height,
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.black),
//         borderRadius: BorderRadius.circular(5),
//         color: Colors.white10,
//       ),
//       width: Platform.isWindows || Platform.isMacOS
//           ? widget.size.width * 0.4
//           : widget.size.width * 0.8,
//       // height: widget.size.height * 0.8,
//       child: Form(
//           key: loginFormProvider.formKey,
//           child: Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   // image

//                   SizedBox(
//                     width: widget.size.width * 0.25,
//                     height: widget.size.height * 0.25,
//                     child: ClipRRect(
//                         borderRadius: BorderRadius.circular(5),
//                         child: Image.asset('assets/control.gif')),
//                   ),
//                   //  user
//                   // password

//                   SizedBox(
//                     height: widget.size.height * 0.1,
//                   ),
//                   TextFormField(
//                     onChanged: (String value) {
//                       user = value;
//                     },
//                     decoration: InputDecoration(
//                         // border: BorderRadius.circular(5),
//                         // hintText: 'Hola',  se  queda dentro del caja de texto
//                         labelText: 'Usuario',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(5),
//                         )),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   TextFormField(
//                     onChanged: (String value) {
//                       password = value;
//                     },
//                     obscureText: true,
//                     decoration: InputDecoration(
//                         // border: BorderRadius.circular(5),
//                         // hintText: 'Hola',  se  queda dentro del caja de texto
//                         labelText: 'Contraseña',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(5),
//                         )),
//                   ),
//                   const SizedBox(
//                     height: 50,
//                   ),

//                   ElevatedButton(
//                       onPressed:() async {
//                               // validacio ndel formulario
//                               if (!loginFormProvider.isValidate()) return;

//                               // final loginServices = LoginServices();

//                               final login =
//                                   LoginUser(user: user, password: password);

//                               String? loginError =
//                                   await loginServices.loginUser(login);
//                               // loginFormProvider.isLoading = false;

//                               if (loginError == null) {
//                                 // Navigator.pushNamed(context, 'home');
//                                 // await teachaerServices.getForId();
 
//                                 Navigator.pushReplacementNamed(
//                                     context, 'check_auth_screen');
//                               } else {
//                                 // cason contrario mostramos el error
//                                 print(loginError);
//                               }
//                             },
//                       child: const Text('INICIAR SESION'))
//                 ],
//               ),
//             ),
//           )),
//     );
//   }
// }
