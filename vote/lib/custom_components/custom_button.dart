import 'package:flutter/material.dart';
import 'package:vote/style/style.dart';

Widget customButton(
    {required BuildContext context,
    required onPressed, //pass function that will execute when button is pressed here inside (){}
    required String childText, //text written inside the button
    double? width,
    double? height,
    double borderRadius = 10, //default curvature of edges
    double? fontSize = 22,
    TextStyle?
        textStyle //if you want a different text size , color , etc pass the style you want here
    ,
    Color? color,
    Color? shadowColor,
    bool? rich,
    Icon? icon,
    Image? image}) {
  return SizedBox(
      //default size of button , if you enter a width or height as a parameter it will use it instead
      width: width ?? MediaQuery.of(context).size.width * 0.88,
      height: height ?? MediaQuery.of(context).size.height * 0.095,
      child: ElevatedButton(
        style: ButtonStyle(
            elevation: const MaterialStatePropertyAll(4),
            shadowColor: (shadowColor == null)
                ? MaterialStatePropertyAll(CustomStyle.colorPalette.lightPurple)
                : MaterialStatePropertyAll(shadowColor),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                // Change your radius here
                borderRadius: BorderRadius.circular(borderRadius),
              ),
            ),
            backgroundColor: (color == null)
                ? MaterialStatePropertyAll(CustomStyle.colorPalette.purple)
                : MaterialStatePropertyAll(color)),
        onPressed: onPressed,
        child: (icon != null || image != null)
            ? (rich ?? true)
                ? FittedBox(
                    child: RichText(
                      textAlign: TextAlign.end,
                      textDirection: TextDirection.rtl,
                      text: TextSpan(
                        style: (textStyle == null)
                            ? TextStyle(
                                fontFamily: CustomStyle.boldFont,
                                fontSize: fontSize,
                                color: CustomStyle.colorPalette.white,
                                fontWeight: FontWeight.bold)
                            : textStyle,
                        children: [
                          TextSpan(
                            text: "$childText",
                          ),
                          WidgetSpan(child: icon ?? image!),
                        ],
                      ),
                    ),
                  )
                : Stack(
                    fit: StackFit.expand,
                    alignment: Alignment.center,
                    children: [
                      Center(
                        child: Text(
                          childText,
                          style: (textStyle == null)
                              ? TextStyle(
                                  fontFamily: CustomStyle.boldFont,
                                  fontSize: fontSize,
                                  color: CustomStyle.colorPalette.white,
                                  fontWeight: FontWeight.bold)
                              : textStyle,
                        ),
                      ),
                      Positioned(right: 0, child: icon ?? image!),
                    ],
                  )
            : FittedBox(
                child: Text(
                  childText,
                  style: (textStyle == null)
                      ? TextStyle(
                          fontFamily: CustomStyle.boldFont,
                          fontSize: fontSize,
                          color: CustomStyle.colorPalette.white,
                          fontWeight: FontWeight.bold)
                      : textStyle,
                ),
              ),
      ));
}
