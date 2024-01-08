import 'package:bowerbird_messaging_app/ui/common/styles.dart';
import 'package:flutter/material.dart';

Widget bowerBirdLogo({required double size, required isDark}) {
  return Container(
    height: size,
    width: size,
    decoration: BoxDecoration(
      color: isDark ? kPrimaryColor : kWhiteColor,
      shape: BoxShape.circle,
    ),
  );
}

Widget bowerBirdLogoAndText({required double size, required isDark}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      bowerBirdLogo(size: size, isDark: isDark),
      size < sizeM ? horizontalSpaceXS : horizontalSpaceS,
      Text(
        'Bowerbird',
        style: TextStyle(
          fontSize: size,
          fontWeight: kFontWeightBold,
          color: isDark ? kPrimaryColor : kWhiteColor,
        ),
      ),
    ],
  );
}
