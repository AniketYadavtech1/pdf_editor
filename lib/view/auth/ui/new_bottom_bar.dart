import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_images.dart';
import '../provider/auth_provider.dart';

class NewBottomBar extends StatelessWidget {
  NewBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthProvider>(
        builder: (context, v, child) => Stack(
          children: [
            v.pages[v.myCurrentIndex],
            Positioned(
              bottom: 5,
              left: 15,
              right: 15,
              child: SafeArea(
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CommonBottomTabs(
                        title: "Home",
                        isSelected: v.myCurrentIndex == 0,
                        image: v.myCurrentIndex == 0 ? AppImages.home : AppImages.selectHome,
                        onTap: () => v.changePage(0),
                      ),
                      CommonBottomTabs(
                        title: "Profile",
                        icon: Icons.person,
                        isSelected: false,
                        onTap: () => v.myCurrentIndex == 1 ? Icons.add : Icons.abc,
                      ),
                      CommonBottomTabs(
                        title: "file",
                        isSelected: v.myCurrentIndex == 1,
                        image: v.myCurrentIndex == 1 ? AppImages.order : AppImages.selectOrder,
                        onTap: () => v.changePage(1),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CommonBottomTab extends StatelessWidget {
  final String title;
  final String image;
  final bool isSelected;
  final void Function()? onTap;

  const CommonBottomTab({super.key, required this.title, required this.isSelected, required this.image, this.onTap});
  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        child: isSelected
            ? Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [SvgPicture.asset(image), Text(title, style: const TextStyle(color: AppColors.white))],
                ),
              )
            : Container(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [SvgPicture.asset(image), Text(title, style: const TextStyle(color: AppColors.black))],
                ),
              ),
      );
}

// commonTab
class CommonBottomTabs extends StatelessWidget {
  final String title;
  final String? image; // Optional image (SVG path)
  final IconData? icon; // Optional icon
  final bool isSelected;
  final void Function()? onTap;

  const CommonBottomTabs({
    super.key,
    required this.title,
    required this.isSelected,
    this.image,
    this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Widget leadingWidget;

    if (image != null) {
      // If image path is provided -> show Svg
      leadingWidget = SvgPicture.asset(
        image!,
        color: isSelected ? AppColors.white : AppColors.black,
      );
    } else if (icon != null) {
      // If icon is provided -> show Icon
      leadingWidget = Icon(
        icon,
        color: isSelected ? AppColors.white : AppColors.black,
      );
    } else {
      // Fallback in case neither is given
      leadingWidget = const SizedBox.shrink();
    }

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        decoration: isSelected
            ? BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(10),
              )
            : null,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            leadingWidget,
            Text(
              title,
              style: TextStyle(
                color: isSelected ? AppColors.white : AppColors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
