import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_app_provider/application/student_data.dart';
import 'package:student_app_provider/core/constant_colors/colors.dart';
import 'package:student_app_provider/presentation/student_data/widgets/show_id_button.dart';
import 'package:student_app_provider/presentation/student_data/widgets/student_credentials.dart';
import 'package:student_app_provider/presentation/student_data/widgets/upadate_button.dart';

class StudentData extends StatelessWidget {
  const StudentData({
    super.key,
    required this.name,
    required this.age,
    required this.phone,
    required this.guardian,
    required this.image,
    required this.id,
    required this.index,
  });

  final String name;
  final String age;
  final String phone;
  final String guardian;
  final String image;
  final String id;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          return await Provider.of<StudentDataController>(context,
                  listen: false)
              .getAllStudents();
        },
        child:
            Consumer<StudentDataController>(builder: (context, newData, child) {
          return Stack(
            children: [
              StudentCredentials(image: image, index: index),
              const ShowIdButton(),
              const SizedBox(height: 10),
              UpdateButton(
                  id: id,
                  name: name,
                  age: age,
                  phone: phone,
                  guardian: guardian,
                  image: image),
            ],
          );
        }),
      ),
      backgroundColor: whiteColor,
    );
  }
}
