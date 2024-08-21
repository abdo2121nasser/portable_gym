
import 'package:flutter/material.dart';

String convertGoogleDriveLinkToStreamable(String originalLink) {
  // Regular expression to capture the file or folder ID from Google Drive link formats
  final RegExp fileRegExp = RegExp(r'(?:/d/|id=|/open\?id=|file/d/)([a-zA-Z0-9_-]+)');
  final RegExp folderRegExp = RegExp(r'(?:/folders/)([a-zA-Z0-9_-]+)');

  final fileMatch = fileRegExp.firstMatch(originalLink);
  final folderMatch = folderRegExp.firstMatch(originalLink);

  if (fileMatch != null) {
    final fileId = fileMatch.group(1);
    return 'https://drive.google.com/uc?export=download&id=$fileId';
  } else if (folderMatch != null) {
    final folderId = folderMatch.group(1);
    return 'https://drive.google.com/drive/folders/$folderId';
  } else {
    debugPrint('Invalid Google Drive link: $originalLink');
    return originalLink;
  }
}

