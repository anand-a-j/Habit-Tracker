import 'package:url_launcher/url_launcher.dart';

import '../constants/app_constants.dart';

class UrlLauncherUtils {
  /// Launches a URL using the device browser (not WebView).
  ///
  /// [url] - The URL to open.
  /// [enableJavaScript] - Only relevant if [forceWebView] is true.
  /// [forceWebView] - Set to true to open inside a WebView instead of a browser.
  /// [logErrors] - Set to true to print errors if URL fails to launch.
  static Future<void> openUrl(
    String url, {
    bool enableJavaScript = true,
    bool forceWebView = true,
  }) async {
    final uri = Uri.tryParse(url);
    if (uri == null) {
      throw Exception("The link appears to be invalid");
    }

    final canLaunchIt = await canLaunchUrl(uri);
    if (!canLaunchIt) {
      throw Exception(
        "We couldn't open the link. Please try again later.",
      );
    }

    await launchUrl(
      uri,
      mode: forceWebView
          ? LaunchMode.inAppWebView
          : LaunchMode.externalApplication,
      webViewConfiguration: WebViewConfiguration(
        enableJavaScript: enableJavaScript,
      ),
    );
  }

  static Future<void> openSupportEmail() async {
    const email = AppConsts.appSupportEmail;
    final uri = Uri(
      scheme: 'mailto',
      path: email,
      query: Uri.encodeQueryComponent('subject=App Feedback & Bug Report'),
    );

    if (!await canLaunchUrl(uri)) {
      throw Exception("No email app found on your device");
    }

    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
