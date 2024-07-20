import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:placement_app/bottom_nav_bar.dart';
import 'package:placement_app/data/repository/user_repo.dart';
import 'package:placement_app/utils/colors.dart';
import 'package:placement_app/utils/utils.dart';
import 'package:placement_app/widgets/custom_button.dart';
import 'package:placement_app/widgets/cutom_textfield.dart';

import 'bloc/personal_detail_bloc.dart';

class PersonalDetailScreen extends StatefulWidget {
  const PersonalDetailScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<PersonalDetailBloc>(
      create: (context) =>
          PersonalDetailBloc(context.read<UserRepo>())..add(PersonalDetailInitalEvent()),
      child: PersonalDetailScreen(),
    );
  }

  @override
  State<PersonalDetailScreen> createState() => _PersonalDetailScreenState();
}

class _PersonalDetailScreenState extends State<PersonalDetailScreen> {
  final txtCntfn = TextEditingController();
  final txtCntln = TextEditingController();
  final txtCntaddr = TextEditingController();
  final txtCntcity = TextEditingController();
  final txtCntstate = TextEditingController();
  final txtCntphone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        title: const Text(
          "Personal Details",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: BlocConsumer<PersonalDetailBloc, PersonalDetailState>(
            listener: (context, state) {
              debugPrint("state: ${state.runtimeType}");
              if (state is PersonalDetailSucessState) {
                txtCntfn.text = state.student!.firstName;
                txtCntln.text = state.student!.lastName;
                txtCntaddr.text = state.student!.address ?? txtCntaddr.text;
                txtCntcity.text = state.student!.city ?? txtCntcity.text;
                txtCntstate.text = state.student!.state ?? txtCntstate.text;
                txtCntphone.text = state.student!.phoneNumber.toString();
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey,
                    child: state is PersonalDetailPfPChangedState
                        ? Image.file(File(state.imgPath))
                        : state is PersonalDetailSucessState
                            ? Image.network(
                                getImageUrl(state.student!.profilePicture ?? ""),
                                errorBuilder: (_, __, ___) => const Icon(Icons.person,
                                    color: Colors.white, size: 60))
                            : const Icon(Icons.person, color: Colors.white, size: 60),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () => _editImage(context),
                    borderRadius: BorderRadius.circular(10),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Edit Image",
                        style: TextStyle(
                            color: mainColor, fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  textFields(
                      label: "First Name",
                      hintText: "Enter Your First Name",
                      controller: txtCntfn),
                  const SizedBox(height: 20),
                  // textFields(label: "Middle Name", hintText: "Enter Your Middle Name",controller:txtCnt),
                  // const SizedBox(height: 20),
                  textFields(
                      label: "Last Name",
                      hintText: "Enter Your Last Name",
                      controller: txtCntln),
                  const SizedBox(height: 20),
                  textFields(
                      label: "Address Line 1",
                      hintText: "Enter Your Address",
                      controller: txtCntaddr),
                  // const SizedBox(height: 20),
                  // textFields(label: "Address Line 2", hintText: "Enter Your Address",controller:txtCnt),
                  const SizedBox(height: 20),
                  textFields(
                      label: "City", hintText: "Enter Your City", controller: txtCntcity),
                  const SizedBox(height: 20),
                  textFields(
                      label: "State",
                      hintText: "Enter Your State",
                      controller: txtCntstate),
                  // const SizedBox(height: 20),
                  // textFields(label: "Country", hintText: "Enter Your Country",controller:txtCnt),
                  const SizedBox(height: 20),
                  // textFields(label: "Zip Code", hintText: "Enter Your Postal Code ",controller:txtCnt),
                  // const SizedBox(height: 20),
                  textFields(
                      label: "Phone Number",
                      hintText: "Enter Your Phone Number",
                      controller: txtCntphone),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // customButton("Prev",
                      //     isPrimary: false,
                      //     onPress: () {},
                      //     padding:
                      //         const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                      const SizedBox(width: 40),
                      customButton("Next", onPress: () async {
                        // BlocProvider.of<PersonalDetailBloc>(context)
                        //     .add(PersonalDetailSubmitEvent(PersonalDetailModel(
                        //   firstName: txtCntfn.text,
                        //   lastName: txtCntln.text,
                        //   addr: txtCntaddr.text,
                        //   city: txtCntcity.text,
                        //   phone: txtCntphone.text,
                        //   state: txtCntstate.text,
                        // )));
                        if (state is PersonalDetailPfPChangedState) {
                          await context.read<UserRepo>().uploadImage(state.imgPath);
                        }

                        // Navigator.of(context).push(MaterialPageRoute(
                        //   builder: (context) => AcademicDetailScreen.builder(
                        //       context,
                        //       PersonalDetailModel(
                        //         firstName: txtCntfn.text,
                        //         lastName: txtCntln.text,
                        //         addr: txtCntaddr.text,
                        //         city: txtCntcity.text,
                        //         phone: txtCntphone.text,
                        //         state: txtCntstate.text,
                        //       )),
                        // ));
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => BottomNavBarScreen(),
                        ));
                      },
                          padding:
                              const EdgeInsets.symmetric(horizontal: 20, vertical: 10))
                    ],
                  ),
                  const SizedBox(height: 50),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void _editImage(BuildContext context) async {
    var picker = ImagePicker();
    var imgFile = await picker.pickImage(source: ImageSource.gallery);
    if (imgFile != null) {
      BlocProvider.of<PersonalDetailBloc>(context)
          .add(PersonalDetailChangePfpEvent(imgFile.path));
    }
  }

  void nextPress() {
    debugPrint(
        "next: $txtCntfn $txtCntln $txtCntaddr $txtCntcity $txtCntstate $txtCntphone ");
  }
}
