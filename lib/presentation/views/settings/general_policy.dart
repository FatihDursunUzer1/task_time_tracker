import 'package:flutter/material.dart';
import 'package:task_time_tracker/core/application/constants/color_constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GeneralPolicy extends StatefulWidget {
  final String url;
  const GeneralPolicy({super.key, required this.url});

  @override
  State<GeneralPolicy> createState() => _GeneralPolicyState();
}

class _GeneralPolicyState extends State<GeneralPolicy> {
  late WebViewController _controller;
  late int progress;
  @override
  void initState() {
    progress = 0;
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.disabled)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            setState(() {
              this.progress = progress;
            });
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: progress == 100
            ? WebViewWidget(
                controller: _controller,
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(
                      color: ColorConstants.customPurple,
                    ),
                    Text('$progress%')
                  ],
                ),
              ));
  }
}
