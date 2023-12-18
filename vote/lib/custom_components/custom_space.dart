import 'package:flutter/material.dart';

Widget customVerticalSpace({required BuildContext context, double? height}) {
  return SizedBox(
    height: height ?? MediaQuery.of(context).size.height * 0.03,
  );
}

Widget customHorizontalSpace({required BuildContext context, double? width}) {
  return SizedBox(
    width: width ?? MediaQuery.of(context).size.width * 0.02,
  );
}
