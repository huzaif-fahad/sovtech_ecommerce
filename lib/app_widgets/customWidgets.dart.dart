import 'package:flutter/material.dart';

Widget custom_Appbar(
  String? title,
  Color color,
) {
  return AppBar(
      backgroundColor: color,
      centerTitle: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
      title: Text(
        title.toString(),
        style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 19),
      ));
}

Widget custom_Buttom(
  String? text,
  Color color,
  double elev,
) {
  return SizedBox(
    height: 50,
    width: double.infinity,
    child: Material(
        borderRadius: BorderRadius.circular(50),
        shadowColor: color,
        color: color,
        elevation: elev,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text.toString(),
            ),
          ],
        )),
  );
}
