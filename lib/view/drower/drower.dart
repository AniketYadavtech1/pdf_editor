import 'package:flutter/material.dart';

import '../settings/component/theme_setting_page.dart';
import '../utils/app_colors.dart';
import '../utils/common_text.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height / 10),
      child: Container(
        width: MediaQuery.of(context).size.width / 1.5,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            bottomLeft: Radius.circular(15),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 8),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  height: 1,
                ),
                SizedBox(height: 10),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    buildDrawerItem(
                      iconData: Icons.settings,
                      text: 'Store Closing Time',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ThemeSettingsScreen(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20)
          ],
        ),
      ),
    );
  }

  Widget buildDrawerItem({
    IconData? iconData,
    required String text,
    required VoidCallback onTap,
    String? iconPath, // (optional) if you want to use SVG instead
  }) {
    return ListTile(
      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
      leading:
          iconData != null ? Icon(iconData) : (iconPath != null ? Image.asset(iconPath, width: 24, height: 24) : null),
      title: Text(text, style: AppText.black14500),
      onTap: onTap,
    );
  }
}
