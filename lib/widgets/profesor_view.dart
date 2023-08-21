import 'package:flutter/material.dart';

class ProfesorView extends StatelessWidget {
  final String nombre;
  final String titulo;
  final String puesto;
  final String imageUrl; // Nueva propiedad para la imagen del profesor

  const ProfesorView({
    Key? key,
    required this.nombre,
    required this.titulo,
    required this.puesto,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: CircleAvatar(
            radius: 30.0,
            backgroundImage: NetworkImage(imageUrl), // Cargar imagen desde una URL
          ),
          title: Text(
            nombre,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 6.0),
              Text(
                titulo,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                puesto,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          trailing: Icon(Icons.keyboard_arrow_right, size: 30.0),
        ),
      ),
    );
  }
}
