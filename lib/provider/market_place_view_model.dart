import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MarketPlaceViewModel extends ChangeNotifier{

    final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse(
        'https://nala.umkmcimahi.com/'));
}