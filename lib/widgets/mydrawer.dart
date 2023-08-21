import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_escolar_prepa/Services/login_provider.dart';
import 'package:sistema_escolar_prepa/providers/menu_option_provider.dart';
import 'package:sistema_escolar_prepa/providers/thme_provider.dart';
import 'package:sistema_escolar_prepa/screen/routes/app_route.dart';

import '../shared_preferences.dart/shared_preferences.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  int itemSelected = 0;
  final preferences = Preferences();
  bool isDarkMode = false;
  @override
  void initState() {
    super.initState();
    isDarkMode = preferences.getIsDarkMode;
  }

  // hacemos la intancia de la clase
  @override
  Widget build(BuildContext context) {
    // final teacher = Provider.of<TeachaerServices>(context);
    // teacher.getTeachers();

    final size = MediaQuery.of(context).size;

    // hamoes la instancia del as opcioens
    final menus = AppRoute.routes;

    // instancia del provider
    final menuProvider = Provider.of<MenuOptionProvider>(context);

    // create styl text
    const styleTitle =
        TextStyle(color: Color(0xffF9F9FF), fontSize: 24); // title
    const styleTextButton = TextStyle(color: Color(0xffF9F9FF), fontSize: 14);

    return Drawer(
      width: Platform.isWindows || Platform.isMacOS
          ? size.width * 0.2
          : size.width * 0.7,

      elevation: 0,
      // backgroundColor:  Color.fromARGB(255, 62, 29, 212),

      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            // color: Color.fromARGB(255, 62, 29, 212),
// backgroundBlendMode: Colors.red
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const Text('Control Esoclar', style: styleTitle),

                const SizedBox(
                  height: 50,
                ),

                // mostrmos la lsita de las opciones
                SizedBox(
                  height: size.height * 0.4,
                  // width: size.width * 0.18,
                  child: ListView.builder(
                    itemCount: menus.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          menuProvider.itemMenu = index;
                        },
                        child: Container(
                          // decoration de container
                          decoration: BoxDecoration(
                            color: menuProvider.itemMenuGet == index
                                ? Colors.black12
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(5),
                          ),

                          height: size.height * 0.07,
                          width: size.width * 0.18,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(
                                  menus[index].icon,
                                  size: menuProvider.itemMenuGet == index
                                      ? 21.0
                                      : 20.0,
                                  // color: const Color(0xfff2F2FF),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  menus[index].name.toString(),
                                  style: menuProvider.itemMenuGet == index
                                      ? const TextStyle(fontSize: 16)
                                      : styleTextButton,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // boton apra cambiar el tema de oscuro a blanco

                Platform.isAndroid || Platform.isIOS
                    ? SizedBox(
                        child: Column(children: [
                          SwitchListTile.adaptive(
                              title: const Text('Tema'),
                              value: preferences.getIsDarkMode,
                              // value: isDarkMode,
                              onChanged: (bool? value) {
                                preferences.setIsDarkMode = value!;
                                final themeProvider = Provider.of<ThemeProvier>(
                                    context,
                                    listen: false);
                                // isDarkMode = value;
                                value
                                    ? themeProvider.setDarkMode()
                                    : themeProvider.setLightMode();

                                setState(() {});
                              }),

                          // botor para salir del programa

                          Center(
                            child: MaterialButton(
                              onPressed: () async {
                                final loginServices =
                                    Provider.of<LoginServices>(context,
                                        listen: false);
                                await loginServices.logout();
                                // despues iremos  al login para el nuevo inicio de sesion

                                Navigator.pushReplacementNamed(
                                    context, 'login');
                              },
                              color: Colors.blueAccent,
                              child: const Text('SALIR DEL PROGRAMA'),
                            ),
                          )
                        ]),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// CRMEOS UNA LISTA DE TIPO  WIDGET
