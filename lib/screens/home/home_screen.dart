import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:eunbeyol/components/my_bottom_nav_bar.dart';
import 'package:eunbeyol/screens/home/components/body.dart';
import 'package:eunbeyol/screens/home/components/slide_menu.dart';
import 'package:eunbeyol/size_config.dart';

import 'package:eunbeyol/online/views/home.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
      drawer: LoveYouDrawer(),
      bottomNavigationBar: MyBottomNavBar(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: SvgPicture.asset("assets/icons/menu.svg"),
        onPressed: () {

        },
      ),
      centerTitle: true,
      title: Image.asset("assets/images/logo.png"),
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset("assets/icons/search.svg"),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => SearchSreen(),
              ),
            );
          },
        ),
        SizedBox(
          width: SizeConfig.defaultSize * 0.5,
        )
      ],
    );
  }
}