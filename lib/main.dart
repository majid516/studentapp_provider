import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:student_app_provider/application/icon_change_provider.dart';
import 'package:student_app_provider/application/search_bar_controller.dart';
import 'package:student_app_provider/application/student_data.dart';
import 'package:student_app_provider/application/sutudent_id_contoller.dart';
import 'package:student_app_provider/core/constant_size/size.dart';
import 'package:student_app_provider/infrastructure/model/sutdent_model.dart';
import 'package:student_app_provider/presentation/main_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(StudentModelAdapter().typeId)) {
    Hive.registerAdapter(StudentModelAdapter());
  }

  runApp(const StudentAppProvider());
}

class StudentAppProvider extends StatelessWidget {
  const StudentAppProvider({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSize.initialize(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => IconChangeProvider()),
        ChangeNotifierProvider(create: (context) => StudentDataController()),
        ChangeNotifierProvider(create: (context) => SutudentIdContoller()),
        ChangeNotifierProvider(create: (context) => SearchBarController()),
      ],
      child: const MaterialApp(
        home: MainScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
