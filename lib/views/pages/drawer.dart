import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:schoolapp/model/AppLandingResponse.dart';
import 'package:schoolapp/utils/nop_cart_icons.dart';
import 'package:schoolapp/utils/sign_config.dart';
import 'package:schoolapp/views/pages/account/account_screen.dart';
import 'package:schoolapp/views/pages/account/change_password_screen.dart';
import 'package:schoolapp/views/pages/account/faq.dart';
import 'package:schoolapp/views/pages/account/find_us.dart';
import 'package:schoolapp/views/pages/account/login_screen.dart';
import 'package:schoolapp/views/pages/assignmentCard_screen.dart';
import 'package:schoolapp/views/pages/attendance.dart';
import 'package:schoolapp/views/pages/calender_screen.dart';
import 'package:schoolapp/views/pages/examSchedule/exam_schedule.dart';
import 'package:schoolapp/views/pages/home/home_screen.dart';
import 'package:schoolapp/views/pages/more/contact_us_screen.dart';
import 'package:schoolapp/views/pages/more/settings_screen.dart';
import 'package:schoolapp/views/pages/courses.dart';
import 'package:schoolapp/views/pages/notice_screen.dart';
import 'package:schoolapp/views/pages/profile_screen.dart';
import 'package:schoolapp/views/pages/report_card.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key key,
  }) : super(key: key);

  static const routeNamedashboard = '/Dashboard';
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    var divider = Divider(
      thickness: 1.5,
      height: 2,
      indent: 10,
      endIndent: 10,
    );
    return SafeArea(
      child: Drawer(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FittedBox(
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(
                            'https://cdn.pixabay.com/photo/2018/01/15/07/52/woman-3083390_1280.jpg'),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Akhtar Abbas ",
                          style: Theme.of(context).textTheme.headline6.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 2.4 * SizeConfig.textMultiplier),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2.0),
                          child: Text(
                            "03109987653",
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(
                                    color: Colors.white,
                                    letterSpacing: 1.3,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 2.2 * SizeConfig.textMultiplier),
                          ),
                        ),
                      ],
                    )
                  ],
                )),
            customListTile(
              context: context,
              title: "My Profile",
              iconPath: "assets/svg/user.svg",
              onTap: () {
                Navigator.pushNamed(context, ProfileScreen.routeName);
              },
            ),
            divider,
            customListTile(
              context: context,
              title: "Manage Account",
              iconPath: "assets/svg/settings.svg",
              onTap: () {
                Navigator.pushNamed(context, SettingsScreen.routeName);
              },
            ),
            divider,
            customListTile(
              context: context,
              title: "Change Language",
              iconPath: "assets/svg/world.svg",
              onTap: () {
                Navigator.pushNamed(context, SettingsScreen.routeName);
              },
            ),
            divider,
            customListTile(
              context: context,
              title: "FAQs",
              iconPath: "assets/svg/faqs.svg",
              onTap: () {
                Navigator.pushNamed(context, FAQScreen.routeName);
              },
            ),
            divider,
            customListTile(
              context: context,
              title: "Find Us",
              iconPath: "assets/svg/search-alt.svg",
              onTap: () {
                Navigator.pushNamed(context, FindUsScreen.routeName);
              },
            ),
            divider,
            customListTile(
              context: context,
              title: "Contact us",
              iconPath: "assets/svg/portrait.svg",
              onTap: () {
                Navigator.pushNamed(context, ContactUsScreen.routeName);
              },
            ),
            divider,
            customListTile(
              context: context,
              title: "Log Out",
              iconPath: "assets/svg/power.svg",
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  ListTile customListTile(
      {BuildContext context,
      String title,
      String iconPath,
      VoidCallback onTap}) {
    return ListTile(
      leading: SvgPicture.asset(
        iconPath,
        height: 18,
        width: 18,
        color: Colors.blue,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.subtitle1.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 1.9 * SizeConfig.textMultiplier),
      ),
      onTap: () => onTap(),
    );
  }
}