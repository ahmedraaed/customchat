// import 'package:flutter/material.dart';
//
//
//
//
// Widget CustomAppBar({
//   required BuildContext context,
//   required String title,
//   required VoidCallback function,
//   required String image,
//   required
// })
// {
//   return Container(
//     height: 90.h,
//     padding: EdgeInsetsDirectional.only(start: 30.w,end: 10.w,top:10.h ),
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.only(bottomLeft: Radius.circular(35.r),bottomRight: Radius.circular(35.r)),
//       color: Colors.white,
//     ),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         InkWell(
//           onTap: function,
//           child: Container(
//             padding: EdgeInsets.all(2.sp),
//             decoration: const BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Colors.white,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black12,
//                     spreadRadius: 1,
//                     offset: Offset(1, 1),
//                   ),
//                   BoxShadow(
//                     color: Colors.black12,
//                     spreadRadius: 1,
//                     blurRadius: 5,
//                     offset: Offset(-1, -1),
//                   ),
//                 ]
//             ),
//             child: Icon(Icons.arrow_back_ios_outlined,size: 18.sp,),
//           ),
//         ),
//         const Spacer(),
//
//         CircleAvatar(
//           backgroundImage: NetworkImage(AppString.baseUrl+"/"+image),
//         ),
//         SizedBox(width: 5.w,),
//
//         Column(
//           children: [
//             SizedBox(height: 25.h,),
//             Text(title,
//               style: TextStyle( fontWeight: FontWeight.w500,fontSize: 16.sp,color: Colors.black,overflow: TextOverflow.fade),
//             ),
//             Container(),
//           ],
//         ),
//         const Spacer(),
//
//       ],
//     ),
//   );
// }