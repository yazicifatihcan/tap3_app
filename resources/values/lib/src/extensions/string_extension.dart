import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Flutter extension for the [String] class, providing
/// additional functionalities
/// for working with strings, launching URLs, and rendering SVG images.
extension StringExtension on String {
  /// Launches a web link using the URL launcher. This extension parses the
  /// current string as a URL and attempts to launch it. Any errors during the
  /// launch process are caught and printed to the debug console.
  Future<void> launchLink() async {
    try {
      final url = Uri.parse(this);
      await launchUrl(url);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  String trimString({
    int showFromStartNumber = 6,
    int showFromEndNumber = 5,
    int totalNumber = 14,
    String overflowChar = '.',
  }) {
    final toSplitStr =
        substring(showFromStartNumber, length - showFromEndNumber);

    final splittedStrs = split(toSplitStr);
    final remainingStrCount =
        totalNumber - (splittedStrs[0].length + splittedStrs[1].length);
    return splittedStrs[0] + overflowChar * remainingStrCount + splittedStrs[1];
  }
}
