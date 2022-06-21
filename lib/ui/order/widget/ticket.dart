// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:intl/intl.dart';

// import '../../../data/model/transaction/purchase/order_model.dart';
// import '../../hooks/use_l10n.dart';
// import '../../hooks/use_router.dart';
// import '../../theme/app_theme.dart';

// const kColorPrimary = Color(0xFF2E8376);
// const kColorText = Color(0xFF9E9E9E);
// const kColorTextDark = Color(0xFF212121);
// const kColorFlightText = Color(0xFFE0E0E0);
// const kColorFlightIcon = Color(0xFFC1B695);
// const kColorTicketBorder = Color(0xFFE0E0E0);

// class _TicketShapeBorder extends ShapeBorder {
//   const _TicketShapeBorder({
//     required this.width,
//     required this.radius,
//   });

//   final double? width;
//   final double? radius;
//   @override
//   EdgeInsetsGeometry get dimensions {
//     return EdgeInsets.all(width!);
//   }

//   @override
//   ShapeBorder scale(double t) {
//     return _TicketShapeBorder(
//       width: width! * t,
//       radius: radius! * t,
//     );
//   }

//   @override
//   ShapeBorder? lerpFrom(ShapeBorder? a, double t) {
//     if (a is _TicketShapeBorder) {
//       return _TicketShapeBorder(
//         width: lerpDouble(a.width, width, t),
//         radius: lerpDouble(a.radius, radius, t),
//       );
//     }
//     return super.lerpFrom(a, t);
//   }

//   @override
//   ShapeBorder? lerpTo(ShapeBorder? b, double t) {
//     if (b is _TicketShapeBorder) {
//       return _TicketShapeBorder(
//         width: lerpDouble(width, b.width, t),
//         radius: lerpDouble(radius, b.radius, t),
//       );
//     }
//     return super.lerpTo(b, t);
//   }

//   @override
//   Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
//     return getOuterPath(
//       rect.deflate(width!),
//       textDirection: textDirection,
//     );
//   }

//   @override
//   Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
//     final r = radius!;
//     final rs = radius! / 2; // 区切り部分の半径
//     final w = rect.size.width; // 全体の横幅
//     final h = rect.size.height; // 全体の縦幅
//     final wl = w / 3; // ロゴ部分の横幅
//     return Path()
//       ..addPath(
//         Path()
//           ..moveTo(r, 0)
//           ..lineTo(wl - rs, 0) // →
//           ..arcToPoint(
//             Offset(wl + rs, 0),
//             radius: Radius.circular(rs),
//             clockwise: false,
//           )
//           ..lineTo(w - r, 0) // →
//           ..arcToPoint(Offset(w, r), radius: Radius.circular(r))
//           ..lineTo(w, h - rs) // ↓
//           ..arcToPoint(Offset(w - r, h), radius: Radius.circular(r))
//           ..lineTo(wl + rs, h) // ←
//           ..arcToPoint(
//             Offset(wl - rs, h),
//             radius: Radius.circular(rs),
//             clockwise: false,
//           )
//           ..lineTo(r, h) // ←
//           ..arcToPoint(Offset(0, h - r), radius: Radius.circular(r))
//           ..lineTo(0, r) // ↑
//           ..arcToPoint(Offset(r, 0), radius: Radius.circular(r)),
//         Offset(rect.left, rect.top),
//       );
//   }

//   @override
//   void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
//     final paint = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = width!
//       ..color = kColorTicketBorder;
//     canvas.drawPath(
//       getOuterPath(
//         rect.deflate(width! / 2.0),
//         textDirection: textDirection,
//       ),
//       paint,
//     );
//   }
// }

// class Ticket extends HookConsumerWidget {
//   const Ticket({
//     Key? key,
//     required this.index,
//     required this.order,
//   }) : super(key: key);
//   final int index;
//   final Order order;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final theme = ref.watch(appThemeProvider);
//     final l10n = useL10n();
//     final appRoute = useRouter();
//     final NumberFormat formatter = NumberFormat.simpleCurrency(
//         locale: Localizations.localeOf(context).toString());
//     return InkWell(
//       onTap: () {
//         showDialog(
//           context: context,
//           builder: (context) {
//             return const AlertDialog(
//               title: Text('チケット利用処理'),
//             );
//           },
//         );
//       },
//       child: Container(
//         width: double.infinity,
//         height: 128,
//         decoration: const ShapeDecoration(
//           color: Color.fromARGB(255, 252, 240, 213),
//           shape: _TicketShapeBorder(width: 1, radius: 16.0),
//         ),
//         child: Row(
//           children: [
//             Expanded(
//               flex: 1,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Text(order.id.toString()),
//                   Container(
//                     padding: const EdgeInsets.all(12),
//                     child: (order.picture1URL == null)
//                         ? const Text('NoImage')
//                         : SizedBox.expand(
//                             child: Image.network(order.picture1URL as String)),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               width: 1,
//               height: double.infinity,
//               margin: const EdgeInsets.symmetric(vertical: 8.0),
//               color: kColorTicketBorder,
//             ),
//             Expanded(
//               flex: 2,
//               child: Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 24),
//                 child: Table(
//                   children: [
//                     TableRow(
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: const [
//                             Text(
//                               'from',
//                               style: TextStyle(color: kColorText),
//                             ),
//                             SizedBox(height: 4),
//                             Text(
//                               '2022/10/10',
//                               style: TextStyle(
//                                 color: kColorTextDark,
//                                 fontSize: 16,
//                               ),
//                             ),
//                           ],
//                         ),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: const [
//                             Text(
//                               'to',
//                               style: TextStyle(color: kColorText),
//                             ),
//                             SizedBox(height: 4),
//                             Text(
//                               '2022/10/10',
//                               style: TextStyle(
//                                 color: kColorTextDark,
//                                 fontSize: 16,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     const TableRow(
//                       children: [
//                         SizedBox(height: 8),
//                         SizedBox(height: 8),
//                       ],
//                     ),
//                     TableRow(
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Text(
//                               'name',
//                               style: TextStyle(color: kColorText),
//                             ),
//                             const SizedBox(height: 4),
//                             Text(
//                               order.name.toString(),
//                               style: const TextStyle(
//                                 color: kColorTextDark,
//                                 fontSize: 18,
//                               ),
//                             ),
//                           ],
//                         ),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               children: [
//                                 Text(
//                                   order.numberOfUse.toString(),
//                                   style: const TextStyle(
//                                     color: kColorPrimary,
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 const Text(
//                                   '/',
//                                   style: TextStyle(
//                                     color: kColorPrimary,
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 Text(
//                                   order.quantity.toString(),
//                                   style: const TextStyle(
//                                     color: kColorPrimary,
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 4),
//                             const Text(
//                               '¥500',
//                               style: TextStyle(color: kColorText),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // class TicketList extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Expanded(
// //       child: Column(
// //         children: [
// //           Padding(
// //             padding: const EdgeInsets.only(
// //               top: 24,
// //               bottom: 8,
// //               left: 16,
// //               right: 16,
// //             ),
// //             child: Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               children: const [
// //                 Text(
// //                   'Tickets',
// //                   style: TextStyle(
// //                     color: kColorTextDark,
// //                     fontSize: 18,
// //                   ),
// //                 ),
// //                 Icon(Icons.filter_list, color: kColorText),
// //               ],
// //             ),
// //           ),
// //           Expanded(
// //             child: SingleChildScrollView(
// //               child: Padding(
// //                 padding: const EdgeInsets.symmetric(
// //                   horizontal: 16,
// //                   vertical: 8,
// //                 ),
// //                 child: Column(
// //                   children: [
// //                     _Ticket(
// //                       image: Assets.img.cat.image(
// //                         fit: BoxFit.cover,
// //                       ),
// //                     ),
// //                     const SizedBox(height: 8),
// //                     _Ticket(
// //                       image: Assets.img.cat.image(
// //                         fit: BoxFit.cover,
// //                       ),
// //                     ),
// //                     const SizedBox(height: 8),
// //                     _Ticket(
// //                       image: Assets.img.cat.image(
// //                         fit: BoxFit.cover,
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           )
// //         ],
// //       ),
// //     );
// //   }
// // }
