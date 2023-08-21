import 'package:flutter/material.dart';

class CardTeachers extends StatefulWidget {
  final String titleAction;
  final Function onPressedOption;

  const CardTeachers(
      {Key? key, required this.titleAction, required this.onPressedOption})
      : super(key: key);

  @override
  State<CardTeachers> createState() => _CardTeachersState();
}

class _CardTeachersState extends State<CardTeachers> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      
      style: ElevatedButton.styleFrom(
        elevation: 5,
        // backgroundColor: Colors.red,
        shadowColor: Colors.black,
        // shadowOffset: const Offset(0, -10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Text(widget.titleAction),
      ),
      onPressed: () {
        setState(() {
          widget.onPressedOption();
        });
      },
    );
  }
}
