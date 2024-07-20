import 'package:flutter/material.dart';
import 'package:placement_app/utils/colors.dart';

ElevatedButton customButton(String text,
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


//   Expanded(
                  //     child: InkWell(
                  //       onTap: () {},
                  //       child: Container(
                  //         height: 60,
                  //         decoration: const BoxDecoration(
                  //           color: mainColor,
                  //           borderRadius: BorderRadius.all(Radius.circular(14)),
                  //           boxShadow: [
                  //             BoxShadow(
                  //                 color: Color.fromRGBO(99, 99, 99, 0.2),
                  //                 offset: Offset(0, 2),
                  //                 blurRadius: 8,
                  //                 spreadRadius: 0),
                  //           ],
                  //         ),
                  //         child: const Center(
                  //           child: Text(
                  //             "Next",
                  //             style: TextStyle(
                  //               color: Colors.white,
                  //               fontSize: 20,
                  //               fontWeight: FontWeight.w600,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),