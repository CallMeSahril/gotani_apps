// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../../../core/components/custom_text_field.dart';
// import '../../controllers/cart_controller.dart';
// import '../../model/model_kabupaten.dart';
// import '../../model/model_province.dart';

// class AddressScreen extends GetView<CartController> {
//   AddressScreen({Key? key}) : super(key: key);

//   final TextEditingController _controllerAddress = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     final height = MediaQuery.of(context).size.height;
//     return Scaffold(
//       body: SafeArea(
//           child: Column(
//         children: [
//           Container(
//             width: width,
//             padding: EdgeInsets.all(width * 0.03),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 InkWell(
//                   onTap: () {
//                     Get.back();
//                   },
//                   child: Icon(
//                     Icons.navigate_before_rounded,
//                     size: width * 0.1,
//                   ),
//                 ),
//                 SizedBox(
//                   width: width * 0.04,
//                 ),
//                 Text(
//                   controller.address.address ?? "Pilih Alamat Pengiriman",
//                   style: TextStyle(
//                     fontSize: 24,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: width * 0.04,
//           ),
//           InkWell(
//             child: Container(
//               decoration: BoxDecoration(
//                   color: Color(0xff0E803C),
//                   borderRadius: BorderRadius.circular(width * 0.03)),
//               padding: EdgeInsets.all(width * 0.03),
//               child: Expanded(
//                 child: Text(
//                   "Add Address",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           ListView.builder(
//             shrinkWrap: true,
//             physics: NeverScrollableScrollPhysics(),
//             itemCount: controller.listAddress.length,
//             itemBuilder: (context, index) {
//               print(controller.listAddress.length);
//               var address = controller.listAddress[index];
//               return Container(
//                 width: width,
//                 padding: EdgeInsets.all(width * 0.03),
//                 margin: EdgeInsets.only(bottom: width * 0.05),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey),
//                   borderRadius: BorderRadius.circular(width * 0.05),
//                 ),
//                 child: Column(
//                   children: [
//                     SizedBox(
//                       width: width * 0.9,
//                       child: Text(
//                         "${address.address}/${address.city}/${address.province}",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 18,
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               );
//             },
//           )
//         ],
//       )),
//     );
//   }
// }

// void _showPersistentBottomSheet(
//     BuildContext context, TextEditingController controller) {
//   double height = MediaQuery.of(context).size.height;
//   double width = MediaQuery.of(context).size.width;

//   showGeneralDialog(
//     context: context,
//     barrierDismissible: false,
//     barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
//     barrierColor: Colors.transparent,
//     transitionDuration: const Duration(milliseconds: 200),
//     pageBuilder: (BuildContext buildContext, Animation animation,
//         Animation secondaryAnimation) {
//       return SafeArea(
//         child: Container(
//           width: width,
//           alignment: Alignment.topCenter,
//           color: Colors.transparent,
//           child: Column(
//             children: [
//               TextButton(
//                 onPressed: () => Get.back(),
//                 child: Container(
//                   width: width,
//                   height: height,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(
//                             width > height ? width * 0.04 : height * 0.04),
//                         topRight: Radius.circular(
//                             width > height ? width * 0.04 : height * 0.04),
//                       ),
//                       color: Color(0xff0E803C)),
//                   child: SingleChildScrollView(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: <Widget>[
//                         Container(
//                           alignment: Alignment.centerRight,
//                           padding: EdgeInsets.all(
//                             width > height ? width * 0.02 : height * 0.02,
//                           ),
//                           child: Icon(
//                             Icons.close,
//                             color: Colors.white,
//                           ),
//                         ),
//                         Container(
//                           padding: EdgeInsets.all(
//                             width > height ? width * 0.02 : height * 0.02,
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: <Widget>[
//                               CustomTextField(
//                                 controller: controller,
//                                 label: "",
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }
