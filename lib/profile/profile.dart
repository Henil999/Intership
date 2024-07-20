import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:placement_app/data/repository/user_repo.dart';
import 'package:placement_app/profile/bloc/profile_bloc.dart';
import 'package:placement_app/screens/company_description/company_description_screen.dart';
import 'package:placement_app/screens/login/login_screen.dart';
import 'package:placement_app/utils/utils.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  static Widget builder(BuildContext context) {
    return BlocProvider<ProfileBloc>(
      create: (context) =>
          ProfileBloc(context.read<UserRepo>())..add(ProfileInitialEvent()),
      child: const ProfilePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        title: const Text(
          "Profile",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state.state != "Success") {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey,
                    child: Image.network(getImageUrl(state.student?.profilePicture ?? ""),
                        errorBuilder: (_, __, ___) =>
                            const Icon(Icons.person, color: Colors.white, size: 60)),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "${state.student?.firstName} ${state.student?.lastName}",
                    style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Personal Details",
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text("Edit", style: TextStyle(fontSize: 18)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(Icons.mail_outline, size: 25),
                            const SizedBox(width: 25),
                            Text(
                              "${state.student?.email}",
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        const Divider(),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(Icons.phone_outlined, size: 25),
                            const SizedBox(width: 25),
                            Text(
                              "${state.student?.phoneNumber}",
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        const Divider(),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(Icons.calendar_today, size: 25),
                            const SizedBox(width: 25),
                            Text(
                              (state.student?.dob != null)
                                  ? getFormatedDate(state.student!.dob!)
                                  : "",
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  customButton("Change Password", context, onPress: () {
                    // BlocProvider.of<ProfileBloc>(context).add(
                    //   ProfileChangePasswordEvent(
                    //       oldPassword: oldPassword, newPassword: newPassword),
                    // );
                  }),
                  const SizedBox(height: 15),
                  customButton("Logout", context, onPress: () {
                    context.read<UserRepo>().logout();
                    Navigator.of(context).popUntil((route) => true);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => LoginScreen.builder(context)),
                    );
                  })
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
