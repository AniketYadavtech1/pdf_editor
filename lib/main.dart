import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pdf_editor/view/editor/provider/editor_provider.dart';
import 'package:pdf_editor/view/pdf/provider/pdfprovider.dart';
import 'package:pdf_editor/view/pdf/ui/pdf_screen.dart';
import 'package:pdf_editor/view/settings/controller/theme_controller.dart';
import 'package:provider/provider.dart';

final scaffoldKey = GlobalKey<ScaffoldState>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(ThemeController());
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
    ),
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ImagePdfProvider()),
        ChangeNotifierProvider(create: (_) => EditorProvider()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          final themeController = Get.find<ThemeController>();
          return Obx(() => GetMaterialApp(
                debugShowCheckedModeBanner: false,
                theme: themeController.themeData,
                darkTheme: ThemeData.dark(),
                themeMode: themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
                home: ImagePdfScreen(),
              ));
        },
      ),
    ),
  );
}
