import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:placement_app/data/models/company.dart';
import 'package:placement_app/data/repository/company_repo.dart';
import 'package:placement_app/data/repository/user_repo.dart';
import 'package:placement_app/screens/company_description/bloc/company_description_bloc.dart';
import 'package:placement_app/screens/company_description/pending_fields.dart';
import 'package:placement_app/utils/colors.dart';
import 'package:placement_app/utils/utils.dart';
import 'package:slider_button/slider_button.dart';
import 'package:url_launcher/url_launcher_string.dart';

class CompanyDescriptionScreen extends StatelessWidget {
  const CompanyDescriptionScreen({super.key});

  static Widget builder(BuildContext context, CompanyModel company) {
    return BlocProvider<CompanyDescriptionBloc>(
      create: (context) =>
          CompanyDescriptionBloc(context.read<UserRepo>(), context.read<CompanyRepo>())
            ..add(CompanyDescriptionInitialEvent(company: company)),
      child: CompanyDescriptionScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<CompanyDescriptionBloc, CompanyDescriptionState>(
        listener: (context, state) async {
          debugPrint("State: ${state.runtimeType}");
          if (state is CompanyDescPendingKeysState) {
            print("pending");
            print(state.pendingKeys);
            Map<String, dynamic> data = await Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) =>
                        PendingFields(pendingKeys: state.pendingKeys!)));

            BlocProvider.of<CompanyDescriptionBloc>(context)
                .add(CompanyDescriptionApplyWithKeysEvent(data));
          }
          if (state is CompanyDescAppliedSuccessfulState) {
            print("applied");
            Future.delayed(Duration.zero).then((e) {
              Navigator.of(context).pop();
            });
          }
        },
        builder: (context, state) {
          if (state is CompanyDescLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                topBar(context),
                const SizedBox(height: 40),
                Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(),
                  child: state.company?.logoUrl?.isEmpty ?? true
                      ? const Icon(Icons.broken_image_outlined, size: 50)
                      : Image.network(
                          getImageUrl(state.company!.logoUrl!),
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                              const Icon(Icons.broken_image_outlined, size: 100),
                        ),
                ),
                const SizedBox(height: 20),
                Text(
                  state.company?.name ?? "",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  state.company?.pkgRange ?? "",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                // Text(
                //   state.company?.city ?? "",
                //   style: TextStyle(fontSize: 20, color: textGrey),
                // ),
                // const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.company?.city ?? "",
                      style: const TextStyle(fontSize: 20, color: textGrey),
                    ),
                    SizedBox(width: 10),
                    InkWell(
                      onTap: () async {
                        if ((state.company?.link) != null) {
                          bool b = await canLaunchUrlString(state.company!.link);
                          if (b) launchUrlString(state.company!.link);
                        }
                      },
                      child: Text(
                        (state.company?.link) != null
                            ? Uri.parse(state.company!.link).host
                            : "",
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.blueAccent,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(Colors.black),
                            minimumSize: MaterialStatePropertyAll(Size(50, 60)),
                            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(14))))),
                        onPressed: () {},
                        child: const Text(
                          "Description",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(Colors.white),
                            minimumSize: MaterialStatePropertyAll(Size(50, 60)),
                            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(14))))),
                        onPressed: () {},
                        child: const Text(
                          "About Company",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                    child: SingleChildScrollView(
                  child: Text(state.company?.description ?? ""),
                )),
                SliderButton(
                  backgroundColor: Colors.black,
                  width: MediaQuery.of(context).size.width * 0.9,
                  action: () async {
                    BlocProvider.of<CompanyDescriptionBloc>(context)
                        .add(CompanyDescriptionApplyEvent());
                    return false;
                  },
                  label: const Text(
                    "Slide to Apply",
                    style: TextStyle(
                        color: Color(0xff4a4a4a),
                        fontWeight: FontWeight.w500,
                        fontSize: 25),
                  ),
                  icon: const Text(">",
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 40)),
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    ));
  }
}

ElevatedButton customButton(String text, BuildContext context,
    {bool isPrimary = true,
    void Function()? onPress,
    EdgeInsetsGeometry padding = EdgeInsets.zero}) {
  return ElevatedButton(
      onPressed: onPress,
      style: ButtonStyle(
        fixedSize:
            MaterialStatePropertyAll(Size(MediaQuery.of(context).size.width * 0.9, 60)),
        backgroundColor:
            MaterialStatePropertyAll(isPrimary ? Colors.black : Colors.white),
        foregroundColor:
            MaterialStatePropertyAll(isPrimary ? Colors.white : Colors.black),
        shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
      ),
      child: Padding(
        padding: padding,
        child: Text(text,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            )),
      ));
}

Widget topBar(context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      if (Navigator.of(context).canPop())
        CircleAvatar(
          radius: 25,
          backgroundColor: const Color(0xFFF7F8FA),
          // backgroundColor: Colors.red,
          child: Center(
            child: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back_ios),
            ),
          ),
        ),
      Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: CircleAvatar(
              radius: 25,
              backgroundColor: const Color(0xFFF7F8FA),
              // backgroundColor: Colors.red,
              child: Center(
                child: IconButton(
                  onPressed: () {
                    BlocProvider.of<CompanyDescriptionBloc>(context)
                        .add(CompanyDescriptionBookmarkEvent());
                  },
                  icon: const Icon(
                    Icons.bookmark_outline,
                  ),
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
                  Icons.share_outlined,
                ),
              ),
            ),
          ),
        ],
      )
    ],
  );
}
