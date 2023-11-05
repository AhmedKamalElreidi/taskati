// import 'package:flutter/material.dart';

// // ignore: must_be_immutable
// class ColorItem extends StatefulWidget {
//   ColorItem({super.key,required this.color,required this.index});
//   int index;
//   Color color;
//   @override
//   State<ColorItem> createState() => _ColorItemState();
// }

// class _ColorItemState extends State<ColorItem> {
 
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           _selectedColor = index;
//         });
//       },
//       child: CircleAvatar(
//         backgroundColor: color,
//         radius: 20,
//         child: (_selectedColor == index)
//             ? const Icon(
//                 Icons.check,
//                 color: Colors.white,
//               )
//             : null,
//       ),
//     );
//   }
// }