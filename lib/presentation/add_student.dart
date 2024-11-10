import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_app_provider/application/student_data.dart';
import 'package:student_app_provider/core/constant_colors/colors.dart';
import 'package:student_app_provider/core/constants/constants.dart';
import 'package:student_app_provider/infrastructure/model/sutdent_model.dart';

class AddNewStudent extends StatelessWidget {
  AddNewStudent({
    super.key,
    required this.isAdd,
    this.id,
    this.student,
  });

  final bool isAdd;
  final String? id;
  final StudentModel? student;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController guardianController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    if (!isAdd) {
      nameController.text = student?.name ?? '';
      ageController.text = student?.age ?? '';
      phoneController.text = student?.phone ?? '';
      guardianController.text = student?.guardian ?? '';
      StudentDataController.profileImage = student?.image ?? 'default_path';
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Text(
          isAdd ? 'Add Student' : 'Update Student',
          style: headingStyle,
        ),
        backgroundColor: appThemeColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      backgroundColor: whiteColor,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Stack(
                  children: [
                    Consumer<StudentDataController>(
                        builder: (context, value, child) {
                      return InkWell(
                        onTap: () {
                          Provider.of<StudentDataController>(context,
                                  listen: false)
                              .pickImageFormGallery();
                        },
                        child: CircleAvatar(
                          radius: 60,
                            backgroundImage:value.getProfileImage()
                             
                        ),
                      );
                    }),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: Icon(
                        Icons.add_a_photo_outlined,
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
              _buildTextField(
                  nameController, 'Student Name', 'name is required'),
              _buildTextField(ageController, 'Student Age', 'age is required'),
              _buildTextField(phoneController, 'Phone', 'phone is required'),
              _buildTextField(guardianController, 'Guardian Name',
                  'guardian name is required'),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25.0, vertical: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final studentData = StudentModel(
                            id: isAdd ? null : id,
                            name: nameController.text,
                            age: ageController.text,
                            phone: phoneController.text,
                            guardian: guardianController.text,
                            image: StudentDataController.profileImage,
                          );

                          if (isAdd) {
                            await Provider.of<StudentDataController>(context,
                                    listen: false)
                                .addNewStudent(studentData);
                            Provider.of<StudentDataController>(context,
                                    listen: false)
                                .disposeImage();
                          } else {
                            await Provider.of<StudentDataController>(context,
                                    listen: false)
                                .updateStudentData(studentData);
                                 Provider.of<StudentDataController>(context,
                                    listen: false)
                                .disposeImage();
                          }
                          Navigator.pop(context);
                        } else {
                          print('Form data is invalid');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: appThemeColor),
                      child: const Wrap(
                        children: [
                          Text(
                            'Submit',
                            style: TextStyle(color: whiteColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText,
      String validationMessage) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 3,
            )
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextFormField(
          keyboardType: TextInputType.numberWithOptions(),
          controller: controller,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return validationMessage;
            }
            return null;
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(borderSide: BorderSide.none),
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
