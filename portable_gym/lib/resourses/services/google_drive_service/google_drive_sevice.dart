import 'dart:io';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:googleapis_auth/auth_io.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
const _clientId = "167003414475-jpgm16pfuqofnfkhs0j8kifradg5npbs.apps.googleusercontent.com";
const List<String> scopes = [drive.DriveApi.driveScope];

class GoogleDriveSevice {
  GoogleSignInAccount? _currentUser;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      drive.DriveApi.driveFileScope,
    ],
  );
  initSignIn() {
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
        _currentUser = account;
    });
    _googleSignIn.signInSilently();
  }
  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }
  Future<void> _handleSignOut() async {
    await _googleSignIn.disconnect();
  }
  Future<Map<String, String>> _getAccessToken() async {
    if (_currentUser == null) {
      await _handleSignIn();
    }

    final auth = await _currentUser?.authentication;
    if (auth != null) {
      return {
        'accessToken': auth.accessToken!,
        'tokenType': 'Bearer',
      };
    }
    return {};
  }


  Future<void> uploadFileToGoogleDrive(File file) async {
    final tokenData = await _getAccessToken();
    if (tokenData.isEmpty) return;
    final client = http.Client();
    var driveApi = drive.DriveApi(authenticatedClient(
      client,
      AccessCredentials(
        AccessToken(tokenData['tokenType']!, tokenData['accessToken']!, DateTime.now().add(Duration(hours: 1)).toUtc()),
        null,
        [drive.DriveApi.driveFileScope],
      ),
    ));
    var fileToUpload = drive.File();
    fileToUpload.name = path.basename(file.path);

    var media = drive.Media(file.openRead(), file.lengthSync());
   print('*////////////////////////////////');
    try {
      var response = await driveApi.files.create(
        fileToUpload,
        uploadMedia: media,
      );
      print('File uploaded: ${response.name}');
      print('File ID: ${response.id}');
    } catch (e) {
      print('Error uploading file: $e');
    }
  }

}

