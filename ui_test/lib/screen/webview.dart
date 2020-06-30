import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebTest extends StatelessWidget {
  final String title;
  final String url;
  WebTest({Key key, this.url, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        ),
        body: SafeArea(
          child: WebView(
            initialUrl: url,
            javascriptMode: JavascriptMode.unrestricted,
            ),
          ),
    );
  }
}
