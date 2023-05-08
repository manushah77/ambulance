// import 'package:embulance/screens/widgets/service_container.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class ServiceScreen extends StatefulWidget {
//   const ServiceScreen({super.key});
//
//   @override
//   State<ServiceScreen> createState() => _ServiceScreenState();
// }
//
// class _ServiceScreenState extends State<ServiceScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         // systemOverlayStyle: SystemUiOverlayStyle(
//         //   statusBarColor: Colors.white,
//         //   statusBarBrightness: Brightness.dark,
//         //   statusBarIconBrightness: Brightness.dark,
//         // ),
//         automaticallyImplyLeading: false,
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: Text(
//           'Services',
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 35.sp,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           SizedBox(
//             height: 30.h,
//           ),
//           Row(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(left: 12.0),
//                 child: Text(
//                   'Available Services',
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 20.sp,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 20.h,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               //1st container
//
//               ServiceContainer(
//                 img: 'assets/images/ambulance.png',
//                 txt: 'Available\n Ambulance',
//               ),
//
//               // 2nd container
//
//               ServiceContainer(
//                   img: 'assets/images/hospital.png', txt: 'Near Hospital'),
//
//               //3rd Container
//
//               ServiceContainer(
//                   img: 'assets/images/hospital.png', txt: 'Available Doctor'),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
