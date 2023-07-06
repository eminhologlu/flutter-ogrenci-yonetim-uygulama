import 'package:flutter/material.dart';
import 'package:kursdeneme/student.dart';

// ignore: must_be_immutable
class StudentAdd extends StatefulWidget {
  List<Student> students = [];
  StudentAdd(List<Student> students) {
    this.students = students;
  }
  @override
  State<StatefulWidget> createState() {
    return _StudentAddState(students);
  }
}

class _StudentAddState extends State {
  List<Student> students = [];
  var student = Student.withoutInfo();
  var formKey = GlobalKey<FormState>();

  _StudentAddState(List<Student> students) {
    this.students = students;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Yeni öğrenci ekle")),
        body: Container(
            margin: EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  buildFirstNameField(),
                  buildLastNameField(),
                  buildGradeField(),
                  buildSubmitButton()
                ],
              ),
            )));
  }

  Widget buildFirstNameField() {
    return TextFormField(
        decoration: InputDecoration(labelText: "Öğrenci Adı", hintText: "Emin"),
        onSaved: (String? value) {
          student.firstName = value ?? "";
        });
  }

  Widget buildLastNameField() {
    return TextFormField(
        decoration:
            InputDecoration(labelText: "Öğrenci Soyadı", hintText: "Holoğlu"),
        onSaved: (String? value) {
          student.lastName = value ?? "";
        });
  }

  Widget buildGradeField() {
    return TextFormField(
        decoration: InputDecoration(labelText: "Aldığı Not", hintText: "100"),
        onSaved: (String? value) {
          student.grade = int.parse(value ?? "");
        });
  }

  Widget buildSubmitButton() {
    return ElevatedButton(
        onPressed: () {
          final formK = formKey.currentState;
          formK?.save();
          students.add(student);
          saveStudent();
        },
        child: Text("Kaydet"));
  }

  void saveStudent() {
    print(student.firstName);
  }
}
