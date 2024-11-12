import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_app_provider/application/student_data.dart';
import 'package:student_app_provider/application/sutudent_id_contoller.dart';
import 'package:student_app_provider/core/constant_colors/colors.dart';
import 'package:student_app_provider/core/constant_size/size.dart';
import 'package:student_app_provider/core/constants/constants.dart';

class StudentCredentials extends StatelessWidget {
  const StudentCredentials({
    super.key,
    required this.image,
    required this.index,
  });

  final String image;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          clipBehavior: Clip.none,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: const BoxDecoration(
                color: appThemeColor,
              ),
            ),
            Positioned(
              bottom: -90,
              child: Consumer<StudentDataController>(
                builder: (context, value, child) => CircleAvatar(
                    radius: 88,
                    backgroundColor: whiteColor,
                    child: CircleAvatar(
                      radius: 80,
                      backgroundImage: File(image).existsSync()
                          ? FileImage(File(StudentDataController
                              .studentListProvider[index].image))
                          : const NetworkImage(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT0VykKbAbaa7tNQ143EKaeGO22WXPDSXQLaQ&s'),
                    )),
              ),
            ),
            const Positioned(
              left: 20,
              top: 70,
              child: Text('Details', style: headingStyle),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.1,
            horizontal: 50,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Text(
                  'Name : ${StudentDataController.studentListProvider[index].name}',
                  style: normalTextStyle1,
                  overflow: TextOverflow.clip),
              Text(
                  'Age : ${StudentDataController.studentListProvider[index].age}',
                  style: normalTextStyle1,
                  overflow: TextOverflow.clip),
              Text(
                  'Phone : ${StudentDataController.studentListProvider[index].phone}',
                  style: normalTextStyle1,
                  overflow: TextOverflow.clip),
              Text(
                  'Guardian : ${StudentDataController.studentListProvider[index].guardian}',
                  style: normalTextStyle1,
                  overflow: TextOverflow.clip),
              Consumer<SutudentIdContoller>(builder: (context, value, child) {
                return Visibility(
                  visible:
                      Provider.of<SutudentIdContoller>(context, listen: true)
                          .isVisible,
                  child: Text(
                    'Id : ${StudentDataController.studentListProvider[index].id}',
                    style: normalTextStyle2,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }),
              SizedBox(height: ScreenSize.height * 0.1),
            ],
          ),
        ),
      ],
    );
  }
}
