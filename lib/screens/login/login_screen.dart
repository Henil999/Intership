// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:placement_app/bottom_nav_bar.dart';
import 'package:placement_app/data/repository/user_repo.dart';
import 'package:placement_app/screens/home/home_screen.dart';
import 'package:placement_app/screens/login/bloc/login_bloc.dart';
import 'package:placement_app/screens/personal_detail/personal_detail_screen.dart';
import 'package:placement_app/widgets/custom_button.dart';
import 'package:placement_app/widgets/cutom_textfield.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final txtCntun = TextEditingController();
  final txtCntpassw = TextEditingController();

  static Widget builder(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(context.read<UserRepo>())..add(LoginInitalEvent()),
      child: LoginScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Login Successfully"),
          ));

          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => BottomNavBarScreen()));
        } else if (state is LoginFailedState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Invalid Cardentials"),
          ));
        } else if (state is LoginMsgState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.msg),
          ));
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "Login",
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 30),
                  textFields(
                    label: "Username",
                    hintText: "Enter Username",
                    controller: txtCntun,
                  ),
                  SizedBox(height: 20),
                  textFields(
                      label: "Password",
                      hintText: "Enter Password",
                      isPassword: true,
                      controller: txtCntpassw),
                  SizedBox(height: 4),
                  TextButton(
                      onPressed: () {
                        if (txtCntun.text.isNotEmpty) {
                          BlocProvider.of<LoginBloc>(context)
                              .add(LoginForgetPasswordEvent(txtCntun.text));
                        }
                      },
                      child: Text(
                        "Forget Password?",
                        textAlign: TextAlign.start,
                      )),
                  SizedBox(height: 50),
                  Center(
                      child: customButton("Login", onPress: () {
                    BlocProvider.of<LoginBloc>(context).add(LoginSubmitEvent(
                        username: txtCntun.text, password: txtCntpassw.text));
                  }, padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4)))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
