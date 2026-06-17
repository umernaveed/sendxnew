import 'package:flutter/material.dart';
import 'package:sendx/app/util/web_launcher.dart';
import 'package:sizer/sizer.dart';

class LascoButton extends StatelessWidget {
  const LascoButton({
    super.key,
    this.height,
    this.width,
    this.margin,
    this.onTap,
  });
  final double? height;
  final double? width;
  final EdgeInsets? margin;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: () {
          if (onTap != null) {
            onTap?.call();
          } else {
            try {
              launchURL('https://pay.lascobizja.com/btn/MTVLU1yGC3qs');
            } catch (_) {}
          }
        },
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(const Color(0xFF8D3EB0)),
          elevation: WidgetStateProperty.all(0),
          padding: WidgetStateProperty.all(
            EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(90),
              child: Container(
                height: 6.h,
                width: 30.w,
                color: Colors.pinkAccent,
                child: Center(
                  child: Text(
                    'LASCO',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 2.w),
            const VerticalDivider(
              thickness: 3,
              color: Colors.white,
              width: 4,
            ),
            SizedBox(width: 2.w),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pay Now',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Powered by Lasco',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
