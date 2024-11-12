import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:student_app_provider/core/constant_colors/colors.dart';

import 'package:student_app_provider/infrastructure/model/sutdent_model.dart';
import 'package:student_app_provider/presentation/add_student/add_student.dart';

class UpdateButton extends StatelessWidget {
  const UpdateButton({
    super.key,
    required this.id,
    required this.name,
    required this.age,
    required this.phone,
    required this.guardian,
    required this.image,
  });

  final String id;
  final String name;
  final String age;
  final String phone;
  final String guardian;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 120,
      left: 90,
      right: 90,
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(CupertinoPageRoute(
            builder: (ctx) => AddNewStudent(
                isAdd: false,
                id: id,
                student: StudentModel(
                    name: name,
                    age: age,
                    phone: phone,
                    guardian: guardian,
                    image: image)),
          ));
        },
        style: ElevatedButton.styleFrom(backgroundColor: appThemeColor),
        child: const Wrap(
          children: [
            Icon(
              Icons.edit_note_sharp,
              color: whiteColor,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'update student',
              style: TextStyle(color: whiteColor),
            ),
          ],
        ),
      ),
    );
  }
}
