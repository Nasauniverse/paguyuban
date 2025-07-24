import 'package:url_launcher/url_launcher.dart';

class MapUtils {
  MapUtils._();

  static Future<void> openMap(
    double Latitude,
    double Longitude,
  ) async {
    Uri googleMapsUrl = Uri.parse(
        "https://www.google.com/maps/search/?api=1&query=$Latitude,$Longitude");
    if (await canLaunchUrl(googleMapsUrl)) {
      await launchUrl(
        googleMapsUrl,
        webViewConfiguration: WebViewConfiguration(enableJavaScript: true),
        browserConfiguration: BrowserConfiguration(showTitle: true),
      );
    } else {
      throw 'Could not open map';
    }
  }
}
