import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:placement_app/bottom_nav_bar.dart';
import 'package:placement_app/data/models/academic_detail_model.dart';
import 'package:placement_app/data/models/user.dart';
import 'package:placement_app/data/repository/company_repo.dart';
import 'package:placement_app/data/repository/user_repo.dart';
import 'package:placement_app/screens/login/login_screen.dart';
import 'package:placement_app/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final userRepo = await UserRepo.init();
  final companyRepo = await CompanyRepo.init();
  var s = Student(
      firstName: "John",
      lastName: "Doe",
      phoneNumber: 9426824765,
      address: "123, ABC Street",
      email: "test5@gmail.com",
      dob: DateTime(2004, 7, 7),
      city: "city1",
      state: "state1",
      postalCode: 123456,
      profilePicture: "/pfp_1",
      academicDetailModel: AcademicDetailModel(
        studentId: "22it1340",
        institute: "XYZ Institute",
        dept: "IT",
        passingYrCurrent: 2023,
        passingYr10: 2018,
        percentage10: 90.0,
        board10: "CBSE",
        passingYr12: 2020,
        percentage12: 85.0,
        board12: "CBSE",
        passingYrDiploma: 2021,
        percentageDiploma: 80.0,
        cgpaDiploma: 8.0,
        collegeDiploma: "ABC College",
        skills: ["skill1", "skill2"],
        interestedRoles: ["role1", "role2"],
        resumeUrl: "/resume_1",
        semPercentage: {
          "sem1": "90.0",
          "sem2": "85.0",
          "sem3": "80.0",
          "sem4": "75.0",
          "sem5": "70.0",
          "sem6": "65.0",
          "sem7": "60.0",
          "sem8": "55.0",
        },
      ));

  // var r = await userRepo.loginUser("test5@gmail.com", "123456");
  // var r = await userRepo.loginUser("22it136@charusat.edu.in", "kaazx9ek");
  // var r = await userRepo.forgetPassword("22it136@charusat.edu.in");
  // inspect(r);
  // var r2 = await userRepo.getStudent();

  // var r2 = await userRepo.uploadImage("/home/samarth/Downloads/a.png");
  // s.profilePicture = r2;
  // var r = await userRepo.updateUser(s);
  // inspect(r);

  final vRes = await userRepo.validateUser();
  final isUpdated = await userRepo.isProfileUpdated();

  debugPrint("isUpdated: $isUpdated");
  runApp(MultiRepositoryProvider(providers: [
    RepositoryProvider<UserRepo>(create: (context) => userRepo),
    RepositoryProvider<CompanyRepo>(create: (context) => companyRepo),
  ], child: MyApp(loggedIn: vRes, isUpdated: isUpdated)));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.loggedIn, required this.isUpdated});

  final bool loggedIn;
  final bool isUpdated;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: loggedIn ? ProfilePage.builder(context) : LoginScreen.builder(context),
        home: loggedIn
            ? isUpdated
                ? const BottomNavBarScreen()
                : const BottomNavBarScreen()
            : LoginScreen.builder(context),
        // home: PersonalDetailScreen.builder(context),
        // home: AcademicInfoScreen.builder(context),
        // home: CompanyDescription(),
        // home: HomeScreen.builder(context),
        theme: ThemeData.from(colorScheme: ColorScheme.fromSeed(seedColor: mainColor)));
  }
}
