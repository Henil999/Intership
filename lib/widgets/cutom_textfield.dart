import 'package:flutter/material.dart';
import 'package:placement_app/utils/colors.dart';

textFields(
    {required String label,
    required String hintText,
    TextEditingController? controller,
    String? errorText,
    bool isPassword = false}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
            color: Colors.grey, fontSize: 15, fontWeight: FontWeight.w700),
      ),
      const SizedBox(
        height: 10,
      ),
      Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
          // color: Color.fromARGB(255, 232, 233, 242),
          color: mainColor.withOpacity(0.08),
          borderRadius: const BorderRadius.all(
            Radius.circular(14),
          ),
        ),
        child: TextField(
          style: const TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
          controller: controller,
          obscureText: isPassword ? true : false,
          enableSuggestions: isPassword ? false : true,
          decoration: InputDecoration(
            hintText: hintText,
            errorText: errorText,
            hintStyle: const TextStyle(
              color: Colors.grey,
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    ],
  );
}

Widget textFieldInsideLabel(
    {String? hintText, TextEditingController? controller, bool multiLine = false}) {
  return Container(
    // height: 60,
    padding: const EdgeInsets.only(left: 15, top: 10, bottom: 2),
    decoration: BoxDecoration(
      color: mainColor.withOpacity(0.08),
      borderRadius: const BorderRadius.all(
        Radius.circular(14),
      ),
    ),
    alignment: Alignment.bottomCenter,
    child: TextField(
      style:
          const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
      controller: controller,
      maxLines: !multiLine ? 1 : null,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: hintText,
        filled: true,
        isDense: true,
        fillColor: Colors.transparent,
        hintStyle: const TextStyle(color: Colors.grey),
        contentPadding: const EdgeInsets.symmetric(vertical: 10),
        border: const OutlineInputBorder(borderSide: BorderSide.none),
      ),
    ),
  );
}
