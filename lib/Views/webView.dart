import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewExample extends StatefulWidget {
  final String url;
  final String pageTitle;
  const WebViewExample({Key? key, required this.url,required this.pageTitle}) : super(key: key);

  @override
  State<WebViewExample> createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<WebViewExample> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    // Initialize controller if needed here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.pageTitle)),
      body: WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted, // allow JS if needed
      )
    );
  }
}
