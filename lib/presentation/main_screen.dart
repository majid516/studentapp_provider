import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_app_provider/application/icon_change_provider.dart';
import 'package:student_app_provider/application/search_bar_controller.dart';
import 'package:student_app_provider/application/student_data.dart';
import 'package:student_app_provider/core/constant_colors/colors.dart';
import 'package:student_app_provider/core/constants/constants.dart';
import 'package:student_app_provider/presentation/add_student.dart';
import 'package:student_app_provider/presentation/student_data.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<StudentDataController>(context, listen: false).getAllStudents();
    return RefreshIndicator(
      onRefresh: () =>
          Provider.of<StudentDataController>(context, listen: false)
              .getAllStudents(),
      child: Scaffold(
        appBar: AppBar(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          shadowColor: blackColor.withOpacity(0.2),
          title: const Text('Student App provider', style: headingStyle),
          centerTitle: false,
          actions: [
            IconButton(
                onPressed: () {
                  Provider.of<SearchBarController>(context, listen: false)
                      .changeVisiblity();
                },
                icon:const Icon(
                  Icons.search,
                  color: whiteColor,
                )),
            Consumer<IconChangeProvider>(
              builder: (context, iconChangeProvider, child) {
                return IconButton(
                  onPressed: () {
                    iconChangeProvider.changeIcon();
                  },
                  icon: Icon(
                    iconChangeProvider.isList
                        ? Icons.grid_view_outlined
                        : Icons.list,
                    color: whiteColor,
                  ),
                );
              },
            ),
          ],
          backgroundColor: appThemeColor,
        ),
        body: Column(
          children: [
            Consumer<SearchBarController>(
              builder: (context, value, child) => Visibility(
                visible: value.isVisible,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SearchBar(
                    controller: value.searchContoller,
                    backgroundColor:const WidgetStatePropertyAll(whiteColor),
                    leading:const Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    onChanged: (value) {
                      Provider.of<StudentDataController>(context, listen: false)
                          .filterStudents(value);
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Consumer<IconChangeProvider>(
                    builder: (context, iconChangeProvider, child) {
                      return Consumer<StudentDataController>(
                        builder: (context, studentDataController, child) {
                          return StudentDataController.filterStudent.isNotEmpty
                              ? iconChangeProvider.isList
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: ListView.builder(
                                        itemBuilder: (ctx, index) {
                                          final data = StudentDataController
                                              .filterStudent[index];
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10.0, vertical: 5),
                                            child: ListTile(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                    CupertinoPageRoute(
                                                        builder: (ctx) =>
                                                            StudentData(
                                                              id: data.id!,
                                                              name: data.name,
                                                              age: data.age,
                                                              phone: data.phone,
                                                              guardian:
                                                                  data.guardian,
                                                              image: data.image,
                                                              index: index,
                                                            )));
                                              },
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              minTileHeight: 80,
                                              tileColor: whiteColor,
                                              leading: CircleAvatar(
                                                radius: 30,
                                                backgroundImage: File(
                                                            data.image)
                                                        .existsSync()
                                                    ? FileImage(
                                                        File(data.image))
                                                    :const NetworkImage(
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
                                                          title:const Text('delete'),
                                                          content: Text(
                                                              'Are you sure to delete ${data.name}'),
                                                          actions: [
                                                            TextButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child:const Text(
                                                                    'cancel')),
                                                           TextButton(
                                                                onPressed: () {
                                                                  Provider.of<StudentDataController>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                       .deleteStudent(
                                                                          data.id!);
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child:const Text(
                                                                    'delete')),
                                                          ],
                                                        );
                                                      });
                                                },
                                                icon: const Icon(Icons.delete),
                                              ),
                                            ),
                                          );
                                        },
                                        itemCount: StudentDataController
                                            .filterStudent.length,
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GridView.builder(
                                        gridDelegate:
                                           const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 10,
                                        ),
                                        itemBuilder: (ctx, index) {
                                          final data = StudentDataController
                                              .filterStudent[index];
                                          return InkWell(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  CupertinoPageRoute(
                                                      builder: (ctx) =>
                                                          StudentData(
                                                            id: data.id!,
                                                            name: data.name,
                                                            age: data.age,
                                                            phone: data.phone,
                                                            guardian:
                                                                data.guardian,
                                                            image: data.image,
                                                            index: index,
                                                          )));
                                            },
                                              onLongPress: () {
                                                 showDialog(
                                                      context: context,
                                                      builder: (ctx) {
                                                        return AlertDialog(
                                                          title:const Text('delete'),
                                                          content: Text(
                                                              'Are you sure to delete ${data.name}'),
                                                          actions: [
                                                            TextButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child:const Text(
                                                                    'cancel')),
                                                           TextButton(
                                                                onPressed: () {
                                                                  Provider.of<StudentDataController>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                       .deleteStudent(
                                                                          data.id!);
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child:const Text(
                                                                    'delete')),
                                                          ],
                                                        );
                                                      });
                                              },
                                              child: GridTile(
                                                
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: whiteColor,
                                                    borderRadius:
                                                        BorderRadius.circular(10),
                                                    border: Border.all(
                                                      width: 1,
                                                      color: const Color.fromARGB(
                                                          134, 158, 158, 158),
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(8.0),
                                                    child: Column(
                                                      children: [
                                                        const SizedBox(height: 5),
                                                        
                                                            CircleAvatar(
                                                              radius: 40,
                                                              backgroundImage: File(
                                                                          data.image)
                                                                      .existsSync()
                                                                  ? FileImage(File(
                                                                      data.image))
                                                                  : NetworkImage(
                                                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT0VykKbAbaa7tNQ143EKaeGO22WXPDSXQLaQ&s'),
                                                            ),
                                                            
                                                        const SizedBox(
                                                            height: 15),
                                                        Text(
                                                          data.name,
                                                          style: normalTextStyle2,
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                          
                                          );
                                        },
                                        itemCount: StudentDataController
                                            .filterStudent.length,
                                      ),
                                    )
                              : Center(
                                  child: Text(
                                  'No Student Found',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.grey),
                                ));
                        },
                      );
                    },
                  ),
                  Positioned(
                      bottom: 40,
                      child: Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                CupertinoPageRoute(
                                  builder: (ctx) => AddNewStudent(
                                    isAdd: true,
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: appThemeColor),
                            child: const Wrap(
                              children: [
                                Icon(
                                  Icons.add,
                                  color: whiteColor,
                                ),
                                Text(
                                  'add student',
                                  style: TextStyle(color: whiteColor),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ))
                ],
              ),
            ),
          ],
        ),
        backgroundColor: backgroundThemeColor,
      ),
    );
  }
}
