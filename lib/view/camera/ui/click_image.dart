// import 'package:flutter/material.dart';
// import 'package:pdf_editor/view/camera/provider/camera_provider.dart';
// import 'package:pdf_editor/view/utils/app_button.dart';
// import 'package:pdf_editor/view/utils/app_colors.dart';
// import 'package:pdf_editor/view/utils/app_padding.dart';
// import 'package:pdf_editor/view/utils/indicator.dart';
// import 'package:provider/provider.dart';
//
// class ClickImage extends StatefulWidget {
//   const ClickImage({super.key});
//
//   @override
//   State<ClickImage> createState() => _ClickImageState();
// }
//
// class _ClickImageState extends State<ClickImage> {
//   @override
//   void initState() {
//     context.read<CameraProvider>().captureCameraImages();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Consumer<CameraProvider>(
//           builder: (context, v, child) => Center(
//             child: Column(
//               children: [
//                 AppHeights.h18,
//                 AppButton(
//                   onTap: () => v.captureCameraImages(),
//                   text: 'pick Image',
//                 ),
//                 ListView.builder(shrinkWrap: true, itemBuilder: (context, index) =>v.load?Indicator(color: AppColors.red,):v.imagesList.isEmpty?Text("Not found"):Container(
//
//
//                   child:  )
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
