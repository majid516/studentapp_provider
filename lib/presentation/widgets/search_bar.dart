import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_app_provider/application/search_bar_controller.dart';
import 'package:student_app_provider/application/student_data.dart';
import 'package:student_app_provider/core/constant_colors/colors.dart';


class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchBarController>(
      builder: (context, value, child) => Visibility(
        visible: value.isVisible,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SearchBar(
            controller: value.searchContoller,
            backgroundColor: const WidgetStatePropertyAll(whiteColor),
            leading: const Icon(
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
    );
  }
}
