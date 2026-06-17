import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sendx/app/core/assets/drawables.dart';
import 'package:sendx/presentation/base_screen.dart';

class PaymentWebView extends StatefulWidget {
  const PaymentWebView({super.key});

  @override
  State<PaymentWebView> createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  ValueNotifier<double> loadingProgress = ValueNotifier<double>(0);
  String successURL = 'https://sendxja.com/tracking/lasco/payment/success';
  String failedURL = 'https://sendxja.com/tracking/lasco/payment/failed';
  String timoutIssue = 'https://payment.lascobizja.com/gateway/v1/failure';

  @override
  Widget build(BuildContext context) {
    final params = Get.arguments as Map<String, dynamic>;
    final url = params['url'];
    return PopScope(
      canPop: true,
      onPopInvoked: (e) async {
        Get.back(result: -1);
        return Future.value(true);
      },
      child: BaseScreen(
        showGradients: false,
        value: SystemUiOverlayStyle.dark,
        backgroundColor: const Color(0xFFFAF4F2).withOpacity(0.4),
        body: Stack(
          children: [
            InAppWebView(
              initialUrlRequest: URLRequest(
                url: WebUri.uri(Uri.parse(url)),
              ),
              onWebViewCreated: (controller) {},
              onProgressChanged: (controller, progress) {
                loadingProgress.value = progress / 100;
              },
              onUpdateVisitedHistory: (controller, url, androidIsReload) {
                final renderURL = url.toString().toLowerCase();
                if (renderURL == failedURL.toLowerCase()) {
                  Get.back(result: -1);
                } else if (renderURL == successURL.toLowerCase()) {
                  Get.back(result: 1);
                }
              },
            ),
            Positioned(
              top: 60,
              left: 11,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: IconButton(
                    icon: SvgPicture.asset(
                      Drawables.icBack,
                      height: 18,
                    ),
                    onPressed: () {
                      Get.back(result: -1);
                    },
                  ),
                ),
              ),
            ),
            Positioned.fill(
                child: ValueListenableBuilder<double>(
              valueListenable: loadingProgress,
              builder: (context, value, child) {
                return value < 1.0
                    ? const CircularProgressIndicator.adaptive()
                    : const SizedBox.shrink();
              },
            ))
          ],
        ),
      ),
    );
  }
}
