import 'dart:ui';

import 'package:flutter/material.dart';

const kColorPrimary = Color(0xFF2E8376);
const kColorText = Color(0xFF9E9E9E);
const kColorTextDark = Color(0xFF212121);
const kColorFlightText = Color(0xFFE0E0E0);
const kColorFlightIcon = Color(0xFFC1B695);
const kColorTicketBorder = Color(0xFFE0E0E0);
const kSingaporeLogoUrl =
    'https://user-images.githubusercontent.com/7200238/82220821-1ebc8880-995a-11ea-9d77-07edda64f05c.png';
const kQantasLogoUrl =
    'https://user-images.githubusercontent.com/7200238/82220824-1fedb580-995a-11ea-8124-f59daff4ebda.png';
const kEmiratesLogoUrl =
    'https://user-images.githubusercontent.com/7200238/82220816-1c5a2e80-995a-11ea-921d-38b3f991d8d2.png';
const kHainanLogoUrl =
    'https://user-images.githubusercontent.com/7200238/82223309-73adce00-995d-11ea-98c0-2dba4e094aca.png';

class _TicketShapeBorder extends ShapeBorder {
  final double? width;
  final double? radius;

  const _TicketShapeBorder({
    required this.width,
    required this.radius,
  });

  @override
  EdgeInsetsGeometry get dimensions {
    return EdgeInsets.all(width!);
  }

  @override
  ShapeBorder scale(double t) {
    return _TicketShapeBorder(
      width: width! * t,
      radius: radius! * t,
    );
  }

  @override
  ShapeBorder? lerpFrom(ShapeBorder? a, double t) {
    if (a is _TicketShapeBorder) {
      return _TicketShapeBorder(
        width: lerpDouble(a.width, width, t),
        radius: lerpDouble(a.radius, radius, t),
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  ShapeBorder? lerpTo(ShapeBorder? b, double t) {
    if (b is _TicketShapeBorder) {
      return _TicketShapeBorder(
        width: lerpDouble(width, b.width, t),
        radius: lerpDouble(radius, b.radius, t),
      );
    }
    return super.lerpTo(b, t);
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return getOuterPath(
      rect.deflate(width!),
      textDirection: textDirection,
    );
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final r = radius!;
    final rs = radius! / 2; // 区切り部分の半径
    final w = rect.size.width; // 全体の横幅
    final h = rect.size.height; // 全体の縦幅
    final wl = w / 3; // ロゴ部分の横幅
    return Path()
      ..addPath(
        Path()
          ..moveTo(r, 0)
          ..lineTo(wl - rs, 0) // →
          ..arcToPoint(
            Offset(wl + rs, 0),
            radius: Radius.circular(rs),
            clockwise: false,
          )
          ..lineTo(w - r, 0) // →
          ..arcToPoint(Offset(w, r), radius: Radius.circular(r))
          ..lineTo(w, h - rs) // ↓
          ..arcToPoint(Offset(w - r, h), radius: Radius.circular(r))
          ..lineTo(wl + rs, h) // ←
          ..arcToPoint(
            Offset(wl - rs, h),
            radius: Radius.circular(rs),
            clockwise: false,
          )
          ..lineTo(r, h) // ←
          ..arcToPoint(Offset(0, h - r), radius: Radius.circular(r))
          ..lineTo(0, r) // ↑
          ..arcToPoint(Offset(r, 0), radius: Radius.circular(r)),
        Offset(rect.left, rect.top),
      );
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = width!
      ..color = kColorTicketBorder;
    canvas.drawPath(
      getOuterPath(
        rect.deflate(width! / 2.0),
        textDirection: textDirection,
      ),
      paint,
    );
  }
}

class _Ticket extends StatelessWidget {
  final Widget image;

  const _Ticket({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              title: Text('チケット利用処理'),
            );
          },
        );
      },
      child: Container(
        width: double.infinity,
        height: 128,
        decoration: const ShapeDecoration(
          color: Color.fromARGB(255, 252, 240, 213),
          shape: _TicketShapeBorder(width: 1, radius: 16.0),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('No******'),
                  Container(
                    padding: const EdgeInsets.all(24),
                    child: image,
                  ),
                ],
              ),
            ),
            Container(
              width: 1,
              height: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              color: kColorTicketBorder,
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'from',
                              style: TextStyle(color: kColorText),
                            ),
                            SizedBox(height: 4),
                            Text(
                              '2022/10/10',
                              style: TextStyle(
                                color: kColorTextDark,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'to',
                              style: TextStyle(color: kColorText),
                            ),
                            SizedBox(height: 4),
                            Text(
                              '2022/10/10',
                              style: TextStyle(
                                color: kColorTextDark,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const TableRow(
                      children: [
                        SizedBox(height: 8),
                        SizedBox(height: 8),
                      ],
                    ),
                    TableRow(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'name',
                              style: TextStyle(color: kColorText),
                            ),
                            SizedBox(height: 4),
                            Text(
                              '焼きそば',
                              style: TextStyle(
                                color: kColorTextDark,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              '5/5',
                              style: TextStyle(
                                color: kColorPrimary,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              '¥500',
                              style: TextStyle(color: kColorText),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TicketList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 24,
              bottom: 8,
              left: 16,
              right: 16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Tickets',
                  style: TextStyle(
                    color: kColorTextDark,
                    fontSize: 18,
                  ),
                ),
                Icon(Icons.filter_list, color: kColorText),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Column(
                  children: const [
                    // _Ticket(
                    //   image: Assets.img.cat.image(
                    //     fit: BoxFit.cover,
                    //   ),
                    // ),
                    // const SizedBox(height: 8),
                    // _Ticket(
                    //   image: Assets.img.cat.image(
                    //     fit: BoxFit.cover,
                    //   ),
                    // ),
                    // const SizedBox(height: 8),
                    // _Ticket(
                    //   image: Assets.img.cat.image(
                    //     fit: BoxFit.cover,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
