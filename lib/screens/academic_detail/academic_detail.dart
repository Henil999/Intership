import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:placement_app/screens/academic_detail/bloc/academic_detail_bloc.dart';
import 'package:placement_app/screens/company_description/company_description_screen.dart';
import 'package:placement_app/screens/personal_detail/personal_detail_model.dart';
import 'package:placement_app/utils/colors.dart';
import 'package:placement_app/widgets/cutom_textfield.dart';

class AcademicDetailScreen extends StatefulWidget {
  PersonalDetailModel prsnlModel;
  AcademicDetailScreen({super.key, required this.prsnlModel});

  static Widget builder(BuildContext context, PersonalDetailModel prsnlModel) {
    return BlocProvider<AcademicDetailBloc>(
      create: (context) => AcademicDetailBloc(),
      child: AcademicDetailScreen(prsnlModel: prsnlModel),
    );
  }

  @override
  State<AcademicDetailScreen> createState() => _AcademicDetailScreenState();
}

class _AcademicDetailScreenState extends State<AcademicDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        title: const Text(
          "Academic Details",
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
          child: Column(
            children: [
              textFields(
                label: "10th Passing year",
                hintText: "Enter Your 10th passing Year",
              ),
              const SizedBox(height: 20),
              // textFields(label: "Middle Name", hintText: "Enter Your Middle Name",controller:txtCnt),
              // const SizedBox(height: 20),
              textFields(
                label: "10th percentage",
                hintText: "Enter Your 10th Percentage",
              ),
              const SizedBox(height: 20),
              textFields(
                label: "10th board",
                hintText: "Enter Your 10th board",
              ),
              const SizedBox(height: 20),
              textFields(
                label: "12th Passing year",
                hintText: "Enter Your 12th passing Year",
              ),
              const SizedBox(height: 20),
              // textFields(label: "Middle Name", hintText: "Enter Your Middle Name",controller:txtCnt),
              // const SizedBox(height: 20),
              textFields(
                label: "12th percentage",
                hintText: "Enter Your 12th Percentage",
              ),
              const SizedBox(height: 20),
              textFields(
                label: "12th board",
                hintText: "Enter Your 12th board",
              ),
              const SizedBox(height: 20),
              textFields(
                label: "Diploma Passing year",
                hintText: "Enter Your 12th passing Year",
              ),
              const SizedBox(height: 20),
              // textFields(label: "Middle Name", hintText: "Enter Your Middle Name",controller:txtCnt),
              // const SizedBox(height: 20),
              textFields(
                label: "Diploma percentage",
                hintText: "Enter Your 12th Percentage",
              ),
              const SizedBox(height: 20),
              textFields(
                label: "Diploma College Name",
                hintText: "Enter Your Diploma College Name",
              ),
              textFields(
                label: "Diploma College Passing year",
                hintText: "Enter Your Diploma College Year",
              ),
              const SizedBox(height: 20),
              textFields(
                label: "Diploma College Passing year",
                hintText: "Enter Your Diploma College Year",
              ),
              const SizedBox(height: 20),
              textFields(
                label: "Institute Name",
                hintText: "Enter Your Institute Name",
              ),
              const SizedBox(height: 20),
              textFields(
                label: "Department Name",
                hintText: "Enter Your Department Name",
              ),
              const SizedBox(height: 20),
              textFields(
                label: " Student Id",
                hintText: "Enter Your Student Id",
              ),
              const SizedBox(height: 20),
              textFields(
                label: "Sem1 SGPA",
                hintText: "Enter Your Sem1 SGPA",
              ),
              const SizedBox(height: 20),
              textFields(
                label: "Sem2 SGPA",
                hintText: "Enter Your Sem2 SGPA",
              ),
              const SizedBox(height: 20),
              textFields(
                label: "Sem3 SGPA",
                hintText: "Enter Your Sem3 SGPA",
              ),
              const SizedBox(height: 20),
              textFields(
                label: "Sem4 SGPA",
                hintText: "Enter Your Sem4 SGPA",
              ),
              const SizedBox(height: 20),
              textFields(
                label: "Sem5 SGPA",
                hintText: "Enter Your Sem5 SGPA",
              ),
              const SizedBox(height: 20),
              textFields(
                label: "Sem6 SGPA",
                hintText: "Enter Your Sem6 SGPA",
              ),
              const SizedBox(height: 20),
              textFields(
                label: "Sem7 SGPA",
                hintText: "Enter Your Sem7 SGPA",
              ),
              const SizedBox(height: 20),
              textFields(
                label: "Sem8 SGPA",
                hintText: "Enter Your Sem8 SGPA",
              ),
              const SizedBox(height: 20),
              textFields(
                label: "overall CGPA",
                hintText: "Enter Your Overall CGPA",
              ),
              const SizedBox(height: 20),

              // const SizedBox(height: 20),
              // textFields(label: "Country", hintText: "Enter Your Country",controller:txtCnt),
              const SizedBox(height: 20),
              // textFields(label: "Zip Code", hintText: "Enter Your Postal Code ",controller:txtCnt),
              // const SizedBox(height: 20),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _customButton("Prev",
                      onPress: () {},
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10)),
                  const SizedBox(
                    width: 40,
                  ),
                  _customButton("Next", onPress: () {
                    // BlocProvider.of<PersonalDetailBloc>(context)
                    //     .add(PersonalDetailSubmitEvent(PersonalDetailModel(
                    //   firstName: txtCntfn.text,
                    //   lastName: txtCntln.text,
                    //   addr: txtCntaddr.text,
                    //   city: txtCntcity.text,
                    //   phone: txtCntphone.text,
                    //   state: txtCntstate.text,
                    // )));
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
                  },
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10))
                ],
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  void _editImage(BuildContext context) async {
    var picker = ImagePicker();
    var imgFile = await picker.pickImage(source: ImageSource.gallery);
    if (imgFile != null) {
      // BlocProvider.of<PersonalDetailBloc>(context)
      //     .add(PersonalDetailChangePfpEvent(imgFile.path));
    }
  }

  void nextPress() {
    // debugPrint(
    //     "next: $txtCntfn $txtCntln $txtCntaddr $txtCntcity $txtCntstate $txtCntphone ");
  }
  ElevatedButton _customButton(String text,
      {bool isPrimary = true,
      void Function()? onPress,
      EdgeInsetsGeometry padding = EdgeInsets.zero}) {
    return ElevatedButton(
        onPressed: onPress,
        style: ButtonStyle(
          backgroundColor:
              MaterialStatePropertyAll(isPrimary ? mainColor : Colors.white),
          foregroundColor:
              MaterialStatePropertyAll(isPrimary ? Colors.white : Colors.black),
          shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
        ),
        child: Padding(
          padding: padding,
          child: Text(text,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              )),
        ));
  }
}
