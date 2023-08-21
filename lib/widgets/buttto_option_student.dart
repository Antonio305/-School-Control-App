import 'package:flutter/material.dart';

class ButtonOptionStudent extends StatefulWidget {
  // we  received three parameters
  final String pathImage;
  final String textButton;
  final String? route;
  final IconData icon;

  const ButtonOptionStudent(
      {Key? key,
      required this.pathImage,
      required this.textButton,
       this.route,
      required this.icon})
      : super(key: key);

  @override
  State<ButtonOptionStudent> createState() => _ButtonOptionStudentState();
}

class _ButtonOptionStudentState extends State<ButtonOptionStudent> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 5,
      // onPressed: widget.onPressed(),
      onPressed: () async {
        Navigator.pushNamed(context, widget.route!);

        // Navigator.pushNamed(context, 'create_student');
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [
              Theme.of(context).brightness == Brightness.dark
                  ? Colors.white38
                  : Colors.black12,
              Theme.of(context).brightness == Brightness.dark
                  ? Colors.black12
                  : Colors.white30
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SizedBox(
          width: 300,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: 50,
                    height: 50,
                    child: Image.asset('asset/active_public.png')),
                Text(widget.textButton),
                Icon(widget.icon),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
