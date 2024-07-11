
import 'package:flutter/cupertino.dart';
String convertGoogleDriveLinkToStreamable(String originalLink) {
  // Regular expression to capture the file ID from different Google Drive link formats
  final RegExp regExp = RegExp(r'(?:/d/|id=|/open\?id=|file/d/)([a-zA-Z0-9_-]+)');
  final match = regExp.firstMatch(originalLink);
  if (match != null) {
    final fileId = match.group(1);
    return 'https://drive.google.com/uc?export=download&id=$fileId';
  } else {
    //throw FormatException('Invalid Google Drive link');
    debugPrint('Invalid Google Drive link : '+originalLink);
   return originalLink;
  }
}
