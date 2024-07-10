String convertGoogleDriveLinkToStreamable(String originalLink) {
  final RegExp regExp = RegExp(r'd/([a-zA-Z0-9_-]+)/');
  final match = regExp.firstMatch(originalLink);
  if (match != null) {
    final fileId = match.group(1);
    return 'https://drive.google.com/uc?export=download&id=$fileId';
  } else {
    throw FormatException('Invalid Google Drive link');
  }
}