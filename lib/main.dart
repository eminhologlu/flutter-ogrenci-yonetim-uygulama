import 'package:flutter/material.dart';
import 'package:kursdeneme/screens/student_add.dart';
import 'package:kursdeneme/student.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  String mesaj = "Öğrenci Takip Sistemi";
  final Student bos = Student.withId(0, "", "", 0);
  late Student selectedStudent = bos;
  List<Student> students = [
    Student.withId(1, "Emin", "Holoğlu", 53),
    Student.withId(2, "Ali", "Yılmaz", 65),
    Student.withId(3, "Alex", "Souza", 10)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(mesaj),
      ),
      body: buildBody(context),
    );
  }

  void mesajGoster(BuildContext context, String mesaj) {
    var alert = AlertDialog(
      title: Text("İşlem sonucu"),
      content: Text(mesaj),
    );
    showDialog(context: context, builder: (BuildContext context) => alert);
  }

  Widget buildBody(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
            child: ListView.builder(
                itemCount: students.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading:
                        CircleAvatar(backgroundColor: Colors.deepOrangeAccent),
                    title: Text(students[index].firstName +
                        " " +
                        students[index].lastName),
                    subtitle: Text("Sınav notu: " +
                        students[index].grade.toString() +
                        " [" +
                        students[index].getStatus +
                        "]"),
                    trailing: buildStatusIcon(students[index].grade),
                    onTap: () {
                      setState(() {
                        selectedStudent = students[index];
                      });
                    },
                  );
                })),
        Text("Seçili öğrenci: " +
            selectedStudent.firstName +
            " " +
            selectedStudent.lastName),
        Row(
          children: <Widget>[
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent),
                child: Row(
                  children: [
                    Icon(Icons.add),
                    SizedBox(
                      width: 4.0,
                    ),
                    Text("Öğr Ekle"),
                  ],
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StudentAdd(students)));
                },
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                child: Row(
                  children: [
                    Icon(Icons.update),
                    SizedBox(
                      width: 4.0,
                    ),
                    Text("Güncelle"),
                  ],
                ),
                onPressed: () {
                  var mesaj = "Güncellendi";
                  mesajGoster(context, mesaj);
                },
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: ElevatedButton(
                style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                child: Row(
                  children: [
                    Icon(Icons.delete),
                    SizedBox(width: 4.0),
                    Text("Sil"),
                  ],
                ),
                onPressed: () {
                  setState(() {
                    students.remove(selectedStudent);
                  });
                  var mesaj = "Silindi : " +
                      selectedStudent.firstName +
                      " " +
                      selectedStudent.lastName;
                  mesajGoster(context, mesaj);
                  selectedStudent = bos;
                },
              ),
            )
          ],
        )
      ],
    );
  }

  Widget buildStatusIcon(int grade) {
    if (grade >= 50)
      return Icon(Icons.done);
    else if (grade >= 40)
      return Icon(Icons.album);
    else
      return Icon(Icons.clear);
  }
}
