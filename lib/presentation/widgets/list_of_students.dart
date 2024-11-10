
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:student_app_provider/application/icon_change_provider.dart';
// import 'package:student_app_provider/application/student_data.dart';
// import 'package:student_app_provider/presentation/main_screen.dart';
// import 'package:student_app_provider/presentation/widgets/grid_of_students.dart';

// class StudentListWidget extends StatelessWidget {
//   const StudentListWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<IconChangeProvider>(
//       builder: (context, iconChangeProvider, child) {
//         return Consumer<StudentDataController>(
//           builder: (context, studentDataController, child) {
//             return StudentDataController.filterStudent.isNotEmpty
//                 ? iconChangeProvider.isList
//                     ? Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 8.0),
//                         child: ListView.builder(
//                           itemBuilder: (ctx, index) {
//                             final data = StudentDataController.filterStudent[index];
//                             return StudentTile(data: data, index: index);
//                           },
//                           itemCount: StudentDataController.filterStudent.length,
//                         ),
//                       )
//                     : Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: GridView.builder(
//                           gridDelegate:
//                               const SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 2,
//                             crossAxisSpacing: 10,
//                             mainAxisSpacing: 10,
//                           ),
//                           itemBuilder: (ctx, index) {
//                             final data = StudentDataController.filterStudent[index];
//                             return StudentGridTile(data: data, index: index);
//                           },
//                           itemCount: StudentDataController.filterStudent.length,
//                         ),
//                       )
//                 : const Center(
//                     child: Text(
//                       'No Student Found',
//                       style: TextStyle(fontSize: 20, color: Colors.grey),
//                     ),
//                   );
//           },
//         );
//       },
//     );
//   }
// }
