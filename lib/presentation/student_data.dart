import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_app_provider/application/student_data.dart';
import 'package:student_app_provider/application/sutudent_id_contoller.dart';
import 'package:student_app_provider/core/constant_colors/colors.dart';
import 'package:student_app_provider/core/constant_size/size.dart';
import 'package:student_app_provider/core/constants/constants.dart';
import 'package:student_app_provider/infrastructure/model/sutdent_model.dart';
import 'package:student_app_provider/presentation/add_student.dart';

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
          return await Provider.of<StudentDataController>(context, listen: false)
              .getAllStudents();
        },
        child:
            Consumer<StudentDataController>(builder: (context, newData, child) {
          return Stack(
            children: [
              ListView(
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
                          builder: (context, value, child) => 
                       CircleAvatar(
                              radius: 88,
                              backgroundColor: whiteColor,
                              child: CircleAvatar(
                                radius: 80,
                                backgroundImage: File(image).existsSync()
                                    ? FileImage(File(StudentDataController.studentListProvider[index].image))
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
                        Consumer<SutudentIdContoller>(
                            builder: (context, value, child) {
                          return Visibility(
                            visible: Provider.of<SutudentIdContoller>(context,
                                    listen: true)
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
              ),
              Positioned(
                bottom: 50,
                left: 60,
                right: 60,
                child: ElevatedButton(
                  onPressed: () {
                    Provider.of<SutudentIdContoller>(context, listen: false)
                        .changeVisiblity();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: whiteColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    fixedSize: Size(ScreenSize.width * 0.3, 40),
                    elevation: 1,
                  ),
                  child: const Wrap(
                    children: [
                      Icon(
                        Icons.remove_red_eye_outlined,
                        color: appThemeColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'show student Id',
                        style: TextStyle(color: appThemeColor),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Positioned(
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
                  style:
                      ElevatedButton.styleFrom(backgroundColor: appThemeColor),
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
              ),
            ],
          );
        }),
      ),
      backgroundColor: whiteColor,
    );
  }
}
