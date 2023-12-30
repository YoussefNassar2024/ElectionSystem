import 'package:flutter/material.dart';
import 'package:vote/style/style.dart';

class AutoSizeContainer extends StatelessWidget {
  final Widget child;
  Color? color;
  double? width;
  AutoSizeContainer({super.key, required this.child, this.color, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: (color != null) ? color : CustomStyle.colorPalette.purple,
      ),
      width: (width != null) ? width : MediaQuery.of(context).size.width * 0.9,
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
          ),
          child: IntrinsicHeight(
            child: child,
          ),
        ),
      ),
    );
  }
}
