import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'love_you.dart';


class LoveYouDrawer extends StatelessWidget {

  // ValueNotifier stateIndex;

  LoveYouDrawer(
    // this.stateIndex,
    {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/loveyou.png'),
              ],
            ),
          ),
          DrawerListTile(
            title: 'Love you',
            svgSrc: 'assets/icons/heart_fill.svg',
            press: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => LoveYouPage(),
                fullscreenDialog: true,
              ));
            },
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        press();
      },
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        height: 16,
        color: Theme.of(context).iconTheme.color!,
      ),
      title: Opacity(
        opacity: 0.8,
        child: Text(
          title,
        ),
      ),
    );
  }
}
