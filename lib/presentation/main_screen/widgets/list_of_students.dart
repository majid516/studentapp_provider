import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_app_provider/application/student_data.dart';
import 'package:student_app_provider/core/constant_colors/colors.dart';
import 'package:student_app_provider/core/constants/constants.dart';
import 'package:student_app_provider/presentation/student_data/student_data.dart';


class StudentTile extends StatelessWidget {
  final dynamic data;
  final int index;

  const StudentTile({super.key, required this.data, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
      child: ListTile(
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        minTileHeight: 80,
        tileColor: whiteColor,
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: File(data.image).existsSync()
              ? FileImage(File(data.image))
              : const NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT0VykKbAbaa7tNQ143EKaeGO22WXPDSXQLaQ&s'),
        ),
        title: Text(
          data.name,
          style: normalTextStyle2,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: IconButton(
          onPressed: () {
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
          icon: const Icon(Icons.delete),
        ),
      ),
    );
  }
}
