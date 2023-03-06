import 'package:flutter/material.dart';

import '../layout_pages/desktop.dart';
import '../layout_pages/mobile.dart';
import '../layout_pages/tablet.dart';

const mobileScreenSize = 360;
const tabletScreenSize = 700;
const desktopScreenSize = 1200;

class Responsiveness extends StatelessWidget {
  const Responsiveness({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    const DesktopScreen();
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth >= desktopScreenSize) {
          return const DesktopScreen();
        } else if (constraints.maxWidth > tabletScreenSize &&
            constraints.maxWidth < desktopScreenSize) {
          return const TabletScreen();
        } else if (constraints.maxWidth <= mobileScreenSize &&
            constraints.maxWidth > mobileScreenSize &&
            constraints.maxWidth < tabletScreenSize) {
          return const MobileScreen();
        }
        return const MobileScreen();
      },
    );
  }
}
