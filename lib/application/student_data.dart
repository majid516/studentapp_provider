import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:student_app_provider/infrastructure/model/sutdent_model.dart';

class StudentDataController with ChangeNotifier {
  static List<StudentModel> studentListProvider = [];
  static List<StudentModel> filterStudent = [];
  final picker = ImagePicker();
  static String profileImage = '';


  void disposeImage(){
    profileImage = '';
    notifyListeners();
  }

 Future<void> pickImageFormGallery() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Get app document directory
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = '${directory.path}/${pickedFile.name}';

      // Copy the image to a persistent directory
      final File savedImage = await File(pickedFile.path).copy(imagePath);

      // Set the profileImage path to the new location
      profileImage = savedImage.path;
      notifyListeners();
    }
  }

  ImageProvider<Object> getProfileImage() {
    if (profileImage != 'default_path' && File(profileImage).existsSync()) {
      return FileImage(File(profileImage));
    }
    return NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT0VykKbAbaa7tNQ143EKaeGO22WXPDSXQLaQ&s');
  }

  Future<void> getAllStudents() async {
    final studentDB = await Hive.openBox<StudentModel>('Student_db');
    studentListProvider.clear();
    studentListProvider.addAll(studentDB.values);
    filterStudent = List.from(studentListProvider);
    notifyListeners();
  }

  Future<void> addNewStudent(StudentModel student) async {
    try {
      final id = DateTime.now().toIso8601String();
      student.id = id;
      final studentDB = await Hive.openBox<StudentModel>('Student_db');
      studentDB.put(id, student);
    } catch (e) {
      log('error found while adding ' + e.toString());
    }
    getAllStudents();
    notifyListeners();
  }

  Future<void> deleteStudent(String id) async {
    final studentDB = await Hive.openBox<StudentModel>('Student_db');
    studentDB.delete(id);
    getAllStudents();
    notifyListeners();
  }

  Future<void> updateStudentData(StudentModel studentData) async {
    try {
      final studentDB = await Hive.box<StudentModel>('Student_db');
      await studentDB.put(studentData.id!, studentData);
      await getAllStudents();
      notifyListeners();
    } catch (e) {
      print('Error updating student: $e');
      throw Exception('Failed to update student data: $e');
    }
  }


  void filterStudents(String query){
    if (query.isEmpty) {
      filterStudent = List.from(studentListProvider);
    }else{
      filterStudent = studentListProvider.where(((student)=>student.name.toLowerCase().contains(query.toLowerCase()))).toList();
    }
    notifyListeners();
  }
}
