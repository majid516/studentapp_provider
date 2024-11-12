import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:student_app_provider/application/student_data.dart';
import 'package:student_app_provider/core/constant_colors/colors.dart';
import 'package:student_app_provider/core/constants/constants.dart';
import 'package:student_app_provider/presentation/student_data/student_data.dart';
class StudentGridTile extends StatelessWidget {
  final dynamic data;
  final int index;

  const StudentGridTile({super.key, required this.data, required this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (ctx) => StudentData(
              id: data.id!,
              name: data.name,
              age: data.age,
              phone: data.phone,
              guardian: data.guardian,
              image: data.image,
              index: index,
            ),
          ),
        );
      },
      onLongPress: () {
        showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text('delete'),
              content: Text('Are you sure to delete ${data.name}'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('cancel')),
                TextButton(
                    onPressed: () {
                      Provider.of<StudentDataController>(context, listen: false)
                          .deleteStudent(data.id!);
                      Navigator.pop(context);
                    },
                    child: const Text('delete')),
              ],
            );
          });
      },
      child: GridTile(
        child: Container(
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 1,
              color: const Color.fromARGB(134, 158, 158, 158),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(height: 5),
                CircleAvatar(
                  radius: 40,
                  backgroundImage: File(data.image).existsSync()
                      ? FileImage(File(data.image))
                      : const NetworkImage(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT0VykKbAbaa7tNQ143EKaeGO22WXPDSXQLaQ&s'),
                ),
                const SizedBox(height: 15),
                Text(
                  data.name,
                  style: normalTextStyle2,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}