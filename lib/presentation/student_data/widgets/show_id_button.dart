
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_app_provider/application/sutudent_id_contoller.dart';
import 'package:student_app_provider/core/constant_colors/colors.dart';
import 'package:student_app_provider/core/constant_size/size.dart';

class ShowIdButton extends StatelessWidget {
  const ShowIdButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
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
    );
  }
}