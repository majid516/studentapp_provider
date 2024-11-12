

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_app_provider/application/icon_change_provider.dart';
import 'package:student_app_provider/application/search_bar_controller.dart';

import 'package:student_app_provider/core/constant_colors/colors.dart';
import 'package:student_app_provider/core/constants/constants.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      shadowColor: blackColor.withOpacity(0.2),
      title: const Text('Student App provider', style: headingStyle),
      centerTitle: false,
      actions: [
        IconButton(
          onPressed: () {
            Provider.of<SearchBarController>(context, listen: false)
                .changeVisiblity();
          },
          icon: const Icon(
            Icons.search,
            color: whiteColor,
          ),
        ),
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
