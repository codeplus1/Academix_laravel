// import 'package:academix/pages/blog_search_page.dart';
// import 'package:flutter/material.dart';

// Widget herowidget(BuildContext context) {
//   return Container(
//     width: double.infinity,
//     height: 200,
//     decoration: const BoxDecoration(
//       // color: AppColor.kSecondary,
//       gradient: LinearGradient(
//         begin: Alignment.bottomCenter,
//         end: Alignment.topRight,
//         colors: [
//           Color.fromARGB(255, 163, 52, 52),
//           Color.fromARGB(255, 225, 180, 159),
//         ],
//       ),
//     ),
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         const Text(
//           "WANT TO MASTER IN IT ?",
//           style: TextStyle(
//             color: Colors.indigo,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         const SizedBox(height: 10),
//         SizedBox(
//           width: MediaQuery.of(context).size.width * .90,
//           child: TextField(
//             decoration: InputDecoration(
//                 contentPadding: const EdgeInsets.symmetric(
//                   horizontal: 10,
//                   vertical: 5,
//                 ),
//                 border: const OutlineInputBorder(),
//                 fillColor: Colors.white,
//                 filled: true,
//                 hintText: 'Search Here',
//                 suffixIcon: IconButton(
//                     onPressed: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => SearchPage()));
//                     },
//                     icon: const Icon(Icons.search))),
//           ),
//         ),
//         const SizedBox(
//           height: 10,
//         ),
//         const Text(
//           "Flutter | Laravel | WebDesigning | JAVA",
//           style: TextStyle(
//               // color: Colors.white70,
//               color: Colors.amber),
//         )
//       ],
//     ),
//   );
// }
