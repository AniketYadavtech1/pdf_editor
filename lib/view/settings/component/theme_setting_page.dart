import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../utils/app_colors.dart';
import '../controller/theme_controller.dart';
import 'app_texts.dart';
import 'custom_clip.dart';
import 'hight.dart';
import 'theme_literals.dart';

class ThemeSettingsScreen extends StatelessWidget {
  final ThemeController themeController = Get.find();

  ThemeSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Theme Settings")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Obx(() => Switch(
                    value: themeController.isDarkMode.value,
                    onChanged: (value) => themeController.toggleTheme(),
                  )),

              Obx(
                () => Row(
                  children: [
                    CustomChoiceChip(
                      selected: themeController.isSelectedColor.value == 0,
                      onTap: () {
                        themeController.isSelectedColor.value = 0;
                      },
                      label: 'Colors',
                      textColor: themeController.isSelectedColor.value == 0 ? AppColors.white : null,
                    ),
                    CustomChoiceChip(
                      selected: themeController.isSelectedColor.value == 1,
                      onTap: () {
                        themeController.isSelectedColor.value = 1;
                        print("themeController.isSelectedColor.value ${themeController.isSelectedColor.value}");
                      },
                      label: 'Fonts',
                      textColor: themeController.isSelectedColor.value == 1 ? AppColors.white : null,
                    ),
                    const Spacer(),
                    TextButton(
                        onPressed: () {
                          themeController.setPrimaryColor(const Color(0xFF0037B3));
                          themeController.setFontFamily('Roboto');
                        },
                        child: const Text("Reset"))
                  ],
                ),
              ),
              Obx(() {
                final selectedColor = themeController.primaryColor.value;
                final visibleCount = themeController.visibleColorCount.value;
                return Visibility(
                  visible: themeController.isSelectedColor.value == 0,
                  child: Column(
                    children: [
                      Text("Choose Primary Color", style: AppTextStyles.kHeading2TextStyle),
                      SizedBox(height: height12),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: visibleCount,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 1,
                        ),
                        itemBuilder: (_, index) {
                          final color = kAvailableColors[index];
                          final isSelected = color == selectedColor;
                          return GestureDetector(
                            onTap: () => themeController.setPrimaryColor(color),
                            child: Container(
                              decoration: BoxDecoration(
                                color: color,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isSelected ? AppColors.white : Colors.transparent,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      TextButton(
                        onPressed: themeController.toggleShowAllColors,
                        child: Obx(() => Text(
                              themeController.visibleColorCount.value == 20 ? "Show More" : "Show Less",
                            )),
                      ),
                    ],
                  ),
                );
              }),

              /// ✅ Observe font
              Obx(() {
                final selectedFont = themeController.fontFamily.value;
                return Visibility(
                  visible: themeController.isSelectedColor.value == 1,
                  child: Column(
                    children: [
                      Text("Choose Font Family", style: AppTextStyles.kHeading2TextStyle),
                      SizedBox(height: height12),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: kAvailableFonts.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 4,
                        ),
                        itemBuilder: (_, index) {
                          final fontName = kAvailableFonts[index];
                          final isSelected = fontName == selectedFont;
                          return GestureDetector(
                            onTap: () => themeController.setFontFamily(fontName),
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: isSelected ? AppColors.primary.withOpacity(0.2) : AppColors.white,
                                border: Border.all(
                                  color: isSelected ? AppColors.primary : Colors.grey.shade400,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                fontName,
                                style: safeFont(
                                  fontName: fontName,
                                  fontSize: 16.sp,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
