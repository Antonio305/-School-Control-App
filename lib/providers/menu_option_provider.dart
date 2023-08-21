//  creamos una para mostrar los datos heeee

import 'package:flutter/material.dart';

class MenuOptionProvider extends ChangeNotifier {
// creamos un metodo getter y seetter

// TODO: PARA EL MENU DE LA APLICACION
  int _index = 0;

  get itemMenuGet {
    return _index;
  }

  set itemMenu(int item) {
    _index = item;
    // cuando cambie de valos notificamos el cambio
    notifyListeners();
  }

//TODO: para los estudianes

// funciones para gestinoar los  DRopMenuAButton

  String _dropButtonValue = 'MASCULINO';

  String get dropdownMenuItemSexoGet {
    return _dropButtonValue;
  }

  set dropdownMenuItemSexo(String value) {
    _dropButtonValue = value;
    notifyListeners();
  }

// blooGrade ( Tipo de sagnre)
  String _blooGrade = "A+";
  String get bloogGradStudent {
    return _blooGrade;
  }

  set bloogGradStudent(String value) {
    _blooGrade = value;
    notifyListeners();
  }

  // edad
  int _age = 14;

  int get ageStudent {
    return _age;
  }

  set ageStudent(int value) {
    _age = value;
    notifyListeners();
  }

  // ´parentesco
  String _parectesco = 'HERMANO';
  String get parectencoStudent {
    return _parectesco;
  }

  set parectencoStudent(String value) {
    _parectesco = value;
    notifyListeners();
  }



// TODO: FUNCION PARA LOS DATOS  ESCOLARES

  String _group = 'A';
  // String  _group = '';

  String get dropdownMenuItemGroup {
    return _group;
  }

  set dropdownMenuItemGroup(String value) {
    _group = value;
    notifyListeners();
  }

  String _semestre = 'SEMESTRE I';
  // gestor del semetre
  String get dropdownMenuItemSemestre {
    return _semestre;
  }

  set dropdownMenuItemSemestre(String value) {
    _semestre = value;
    notifyListeners();
  }

// oara la gesti onde la s generaiciones
// en la cual los datos seran obenidos en la base de datos
  String _gereracion = '2019-08-30 06:55:24.698Z';
  //  DateTime  sapos =  new DateTime("2019-08-30T06:55:24.698Z");
  String get dropDownMenuItemGeneracion {
    return _gereracion;
  }

  set dropDownMenuItemGeneracion(String value) {
    _gereracion = value;
    notifyListeners();
  }

  //TODO: METODOS PARA GESTIONAR LOS DATOS DE LA  MATERIA

  String _gender = 'MASCULINO';

  String get genderTeacher {
    return _gender;
  }

  set genderTeacher(String value) {
    _gender = value;
    notifyListeners();
  }

  String _rol = 'DIRECTOR';

  String get rolTeacher {
    return _rol;
  }

  set rolTeacher(String value) {
    _rol = value;
    notifyListeners();
  }

  bool _status = true;

  bool get statusTeacher {
    return _status;
  }

  set statusTeacher(bool value) {
    _status = value;
    notifyListeners();
  }

  // typeContrac
  String _typeContrac = 'BASE';
  String get typeContracTeacher {
    return _typeContrac;
  }

  set typeContracTeacher(String value) {
    _typeContrac = value;
    notifyListeners();
  }

  // metodo creeate subject

  String? _nameMateria;

  String get getMateria {
    return _nameMateria!;
  }

  set setMateria(String? value) {
    _nameMateria = value;
    notifyListeners();
  }

  String _teacher = 'ING. JAIME';

  String get getTeacher {
    return _teacher;
  }

  set setTeacher(String value) {
    _teacher = value;
    notifyListeners();
  }

  String _semestreMateria = "SEMESTRE I";

  String get getSemestre {
    return _semestreMateria;
  }

  set setSemestre(String value) {
    _semestreMateria = value;
    notifyListeners();
  }

// metodo para las generaciones
// en la cual recivimos la fecha inicial

  String _dateTime = "2022-12-16 06:55:24.698Z";
  String get getGeneration {
    return _dateTime;
  }

  set setGeneration(String value) {
    _dateTime = value;
    notifyListeners();
  }

  // creaer los horarios

  List data = [];

  List get getList {
    return data;
  }

  set setList(String value) {
    data.add(value);
    notifyListeners();
  }

  set deleteList(int index) {
    data.removeAt(index);
    notifyListeners();
  }

  // getter y setter parra el ingreso de las materias por grupo.

  String _day = "LUNES";

  String get getDay {
    return _day;
  }

  set setDay(String value) {
    _day = value;
    notifyListeners();
  }

  // metodosp crear las generaciones
  // para cada unos de lso dias de la semana

  List dayMonday = [];
  List dayTuesday = [];
  List dayWednesday = [];
  List dayThursday = [];
  List dayFriday = [];

// lista del dia lunes
  List get getDayMonday {
    return dayMonday;
  }

  set setDayMonday(String value) {
    dayMonday.add(value);
    notifyListeners();
  }

  // borrar uno por uno losdatoa
  set deleteDayMonday(int index) {
    dayMonday.removeAt(index);
    notifyListeners();
  }
  // limpiar los array

  void clearList() {
    dayMonday.clear();
    dayTuesday.clear();
    dayWednesday.clear();
    dayThursday.clear();
    dayFriday.clear();
    notifyListeners();
  }

// Lista para dia martes
  List get getDayTuesday {
    return dayTuesday;
  }

  set setDayTuesday(String value) {
    dayTuesday.add(value);
    notifyListeners();
  }

  // dlete item
  set deleteDayTuesday(int index) {
    dayTuesday.removeAt(index);
    notifyListeners();
  }

  List get getDayWednesday {
    return dayWednesday;
  }

  set setDayWednesday(String value) {
    dayWednesday.add(value);
    notifyListeners();
  }

  set deleteDayWednesday(int index) {
    dayWednesday.removeAt(index);
    notifyListeners();
  }

  List get getDayThurday {
    return dayThursday;
  }

  set setDayThursday(String value) {
    dayThursday.add(value);
    notifyListeners();
  }

  set deleteDayThursday(int index) {
    dayThursday.removeAt(index);
    notifyListeners();
  }

  List get getDayFriday {
    return dayFriday;
  }

  set setDayFriday(String value) {
    dayFriday.add(value);
    notifyListeners();
  }

  set deleteDayFriday(int index) {
    dayFriday.removeAt(index);
    notifyListeners();
  }


   
}
