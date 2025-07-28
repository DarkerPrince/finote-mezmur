import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewExample extends StatefulWidget {
  final String url;
  final String pageTitle;

  WebViewExample({required this.url, required this.pageTitle});

  @override
  _WebViewExampleState createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<WebViewExample> {
  bool _isLoading = true;
  bool _hasError = false;

  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) {
            // Allow only http(s) schemes
            if (request.url.startsWith('http') || request.url.startsWith('https')) {
              return NavigationDecision.navigate;
            } else {
              // Block unknown or custom schemes (e.g. whatsapp://, intent://)
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('ሚዲያ አድራሻ አልታወቀም')),
              );
              return NavigationDecision.prevent;
            }
          },
          onPageStarted: (url) {
            setState(() {
              _isLoading = true;
              _hasError = false;
            });
          },
          onPageFinished: (url) {
            setState(() {
              _isLoading = false;
            });
          },
          onWebResourceError: (error) {
            setState(() {
              _hasError = true;
              _isLoading = false;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pageTitle),
      ),
      body: Stack(
        children: [
          if (_hasError)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: Colors.red),
                  SizedBox(height: 8),
                  Text('ገጹን መጫን አልተሳካም።'),
                  ElevatedButton(
                    onPressed: () {
                      _controller.loadRequest(Uri.parse(widget.url));
                      setState(() {
                        _hasError = false;
                        _isLoading = true;
                      });
                    },
                    child: Text('እንደገና ይሞክሩ'),
                  ),
                ],
              ),
            )
          else
            WebViewWidget(
                controller: _controller
            ),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
