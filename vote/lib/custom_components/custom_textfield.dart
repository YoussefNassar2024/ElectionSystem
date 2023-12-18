import 'package:flutter/material.dart';
import 'package:vote/style/style.dart';

Widget customTextField(
    {required TextEditingController textEditingController,
    required BuildContext context,
    void Function(String)? onchanged,
    void Function()? onEditingComplete,
    void Function()? ontap,
    TextDirection textDirection = TextDirection.ltr,
    String? Function(String?)? validator,
    Key? key,
    TextInputType? keyboardType,
    double? width,
    int? maxLenght,
    int? maxLines,
    String? hintText,
    IconButton? suffixIcon,
    bool? obscureText,
    FocusNode? focusNode,
    double? height,
    Icon? icon}) {
  return SizedBox(
    width: width ?? MediaQuery.of(context).size.width * 0.95,
    child: TextFormField(
      onTap: (ontap != null) ? ontap : null,
      maxLength: (maxLenght != null) ? maxLenght : null,
      key: key,
      validator: validator,
      onEditingComplete: onEditingComplete,
      maxLines: maxLines,
      obscureText: (obscureText != null) ? obscureText : false,
      minLines: 1,
      focusNode: focusNode,
      keyboardType: keyboardType,
      onChanged: onchanged,
      controller: textEditingController,
      textDirection: textDirection,
      style: TextStyle(
          fontSize: CustomStyle.fontSizes.mediumFont,
          color: CustomStyle.colorPalette.darkPurple,
          fontFamily: CustomStyle.meduimFont),
      decoration: InputDecoration(
          hintTextDirection: TextDirection.ltr,
          hintText: (hintText == null) ? "" : hintText,
          counterText: '',
          isCollapsed: true,
          contentPadding: EdgeInsets.symmetric(
              vertical: (height != null) ? height : 10, horizontal: 20),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9.0),
              borderSide: BorderSide(
                width: 1.0,
                color: CustomStyle.colorPalette.lightPurple,
              )),
          suffixIcon: suffixIcon,
          suffixIconColor: Colors.black,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(9.0),
            borderSide: BorderSide(
              width: 2.0,
              color: CustomStyle
                  .colorPalette.purple, // Sets the border color when focused
            ),
          ),
          fillColor: CustomStyle.colorPalette.lightPurple,
          filled: true,
          hintMaxLines: null,
          icon: icon,
          iconColor: CustomStyle.colorPalette.white),
      cursorColor: CustomStyle.colorPalette.darkPurple,
    ),
  );
}
