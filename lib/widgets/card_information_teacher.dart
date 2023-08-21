import 'package:flutter/material.dart';
import 'package:sistema_escolar_prepa/models/teacher.dart';

class CardInformationTeacher extends StatefulWidget {
  final List<Teachers> teacher;
  final int index;

  const CardInformationTeacher(
      {Key? key, required this.teacher, required this.index})
      : super(key: key);

  @override
  State<CardInformationTeacher> createState() => _CardInformationTeacherState();
}

class _CardInformationTeacherState extends State<CardInformationTeacher> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.pushNamed(context, 'show_teacher_information', arguments: widget.teacher[widget.index]);
        
      },
      mouseCursor: MouseCursor.uncontrolled,
      leading: CircleAvatar(
        child: Text(widget.teacher[widget.index].name.substring(0, 2)),
      ),
      trailing: const Icon(Icons.navigate_next_rounded),
      dense: true,
      title: Text(widget.teacher[widget.index].name),
      subtitle: Text(widget.teacher[widget.index].collegeDegree),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        // side: BorderSide(
        //   color: Colors.red,
        // ),
      ),
    );
  }
}
