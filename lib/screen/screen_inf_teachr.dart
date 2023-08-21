import 'package:flutter/material.dart';


class ScreenInformationTeacher extends StatelessWidget {
  const ScreenInformationTeacher({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final String nombreCompleto = 'Juan Pérez';
  final String tituloProfesional = 'Ingeniero en Sistemas';
  final String sexo = 'Masculino';
  final int edad = 35;
  final String correoElectronico = 'juanperez@example.com';
  final String numeroTelefono = '555-1234';
  final String fotoPerfil = 'https://picsum.photos/id/237/200/300';
    return  Scaffold(
        appBar: AppBar(
          title: Text('Información del Profesor'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(fotoPerfil),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                nombreCompleto,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                tituloProfesional,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                'Sexo: $sexo',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                'Edad: $edad años',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                'Correo Electrónico:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                correoElectronico,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                'Número de Teléfono:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                numeroTelefono,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      );
  }
}