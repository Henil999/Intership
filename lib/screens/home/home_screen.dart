// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:placement_app/data/repository/company_repo.dart';
import 'package:placement_app/data/repository/user_repo.dart';
import 'package:placement_app/screens/company_description/company_description_screen.dart';
import 'package:placement_app/data/models/company.dart';
import 'package:placement_app/screens/home/bloc/home_bloc.dart';
import 'package:placement_app/utils/colors.dart';
import 'package:placement_app/utils/utils.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) => HomeBloc(context.read<CompanyRepo>(), context.read<UserRepo>())
        ..add(HomeInitialEvent()),
      child: HomeScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state.state != "Success") {
                return const Center(child: CircularProgressIndicator());
              }

              // print(state.companies[0].logoUrl);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  topBar(),
                  const SizedBox(height: 20),
                  RichText(
                    text: TextSpan(
                      text: 'Hey, ',
                      style: const TextStyle(
                        color: Color(0xFF828A9A),
                        fontWeight: FontWeight.w400,
                        fontSize: 28,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: state.user?.firstName,
                            style: const TextStyle(
                                decoration: TextDecoration.underline,
                                decorationStyle: TextDecorationStyle.wavy,
                                textBaseline: TextBaseline.ideographic,
                                decorationThickness: 1,
                                fontWeight: FontWeight.w600,
                                color: Colors.black)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: const Text(
                      "Upcoming Companies",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(height: 20),
                      itemBuilder: (context, index) =>
                          upcomingCompanyTemplate(context, state.companies[index], index),
                      itemCount: state.companies.length,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget upcomingCompanyTemplate(context, CompanyModel company, int index) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CompanyDescriptionScreen.builder(context, company)));
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: const Offset(0, 4),
                  blurRadius: 12),
            ]),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: company.logoUrl != null
                      ? Image.network(getImageUrl(company.logoUrl!),
                          errorBuilder: (_, __, ___) => Icon(Icons.hide_image_outlined))
                      : SizedBox(),
                ),
                const SizedBox(width: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      company.name,
                      style: TextStyle(
                          color: textGrey, fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      company.pkgRange,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => BlocProvider.of<HomeBloc>(context)
                      .add(HomeBookmarkCompanyEvent(companyIndex: index)),
                  icon: const Icon(Icons.bookmark_outline, size: 30),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.location_on_outlined, color: textGrey, size: 22),
                SizedBox(width: 5),
                Text(
                  company.city,
                  style: TextStyle(
                    color: textGrey,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  // "${employmentTypeToString(company.employmentType)} • Work From ${company.isRemote ? 'Home' : 'Office'}",
                  "${employmentTypeToString(company.employmentType)} • Work From Office",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: const [
                Text(
                  // "₹ ${company.packageMinLPA} - ${company.packageMaxLPA} LPA",
                  "₹ 6 - 10 LPA",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget topBar() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      CircleAvatar(
        radius: 25,
        backgroundColor: const Color(0xFFF7F8FA),
        // backgroundColor: Colors.red,
        child: Center(
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.filter_list_sharp,
            ),
          ),
        ),
      ),
      Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: const Color(0xFFF7F8FA),
            // backgroundColor: Colors.red,
            child: Center(
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search,
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          CircleAvatar(
            radius: 25,
            backgroundColor: const Color(0xFFF7F8FA),
            // backgroundColor: Colors.red,
            child: Center(
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications,
                ),
              ),
            ),
          ),
        ],
      )
    ],
  );
}
