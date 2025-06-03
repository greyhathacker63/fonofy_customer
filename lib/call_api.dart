import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

// Student Model
class Student {
  final String id;
  final String name;
  final String email;
  final int phone;
  final String gender;

  Student({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.gender,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      gender: json['gender'],
    );
  }
}

// Service to Fetch Data
Future<List<Student>> fetchStudents() async {
  final response = await http.get(Uri.parse('http://192.168.47.8:3000/student')); // Use 10.0.2.2 for Android emulator

  if (response.statusCode == 201) {
    final data = json.decode(response.body);
    final List students = data['StudentData'];
    return students.map((e) => Student.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load students');
  }
}

// Main App
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student List',
      home: StudentListScreen(),
    );
  }
}

// UI Screen
class StudentListScreen extends StatefulWidget {
  @override
  _StudentListScreenState createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  late Future<List<Student>> futureStudents;

  @override
  void initState() {
    super.initState();
    futureStudents = fetchStudents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Students')),
      body: FutureBuilder<List<Student>>(
        future: futureStudents,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          else if (snapshot.hasError)
            return Center(child: Text('Error: ${snapshot.error}'));
          else if (!snapshot.hasData || snapshot.data!.isEmpty)
            return Center(child: Text('No students found'));

          final students = snapshot.data!;
          return ListView.builder(
            itemCount: students.length,
            itemBuilder: (context, index) {
              final student = students[index];
              return ListTile(
                title: Text(student.name),
                subtitle: Text('${student.email} • ${student.phone}'),
                trailing: Text(student.gender),
              );
            },
          );
        },
      ),
    );
  }
}
