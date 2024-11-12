import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_app_provider/application/icon_change_provider.dart';
import 'package:student_app_provider/application/student_data.dart';
import 'package:student_app_provider/core/constant_colors/colors.dart';
import 'package:student_app_provider/presentation/main_screen/widgets/search_bar.dart';
import 'package:student_app_provider/presentation/student_data/student_data.dart';
import 'package:student_app_provider/presentation/main_screen/widgets/add_new_student_button.dart';
import 'package:student_app_provider/presentation/main_screen/widgets/app_bar.dart';
import 'package:student_app_provider/presentation/main_screen/widgets/grid_of_students.dart';
import 'package:student_app_provider/presentation/main_screen/widgets/list_of_students.dart';

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
        appBar: const AppBarWidget(),
        body: Column(
          children: [
            const SearchBarWidget(),
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
                                          return StudentTile(
                                              data: data, index: index);
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
                                                        title: const Text(
                                                            'delete'),
                                                        content: Text(
                                                            'Are you sure to delete ${data.name}'),
                                                        actions: [
                                                          TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: const Text(
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
                                                              child: const Text(
                                                                  'delete')),
                                                        ],
                                                      );
                                                    });
                                              },
                                              child: StudentGridTile(
                                                  data: data, index: index));
                                        },
                                        itemCount: StudentDataController
                                            .filterStudent.length,
                                      ),
                                    )
                              : const Center(
                                  child: Text(
                                    'No Student Found',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.grey,
                                    ),
                                  ),
                                );
                        },
                      );
                    },
                  ),
                  const AddStudentButton()
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
