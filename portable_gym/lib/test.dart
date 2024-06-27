import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:googleapis_auth/auth_io.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GoogleSignInAccount? _currentUser;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      drive.DriveApi.driveFileScope,
    ],
  );

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });
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

  Future<void> _uploadFileToGoogleDrive(File file) async {
    final tokenData = await _getAccessToken();
    if (tokenData.isEmpty) return;

    final client = http.Client();
  print(tokenData.toString());

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Drive Upload'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_currentUser != null)
              Column(
                children: [
                  Text('Signed in as ${_currentUser!.displayName}'),
                  ElevatedButton(
                    onPressed: _handleSignOut,
                    child: Text('Sign out'),
                  ),
                ],
              )
            else
              ElevatedButton(
                onPressed: _handleSignIn,
                child: Text('Sign in with Google'),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Replace this with the path to your file
              await  pickImage();
                File file = imageFile!;
                await _uploadFileToGoogleDrive(file);
              },
              child: Text('Upload File to Google Drive'),
            ),
            // SizedBox(
            //     height: 300,
            //     child: Image.network('https://drive.google.com/uc?id=1XSPKtSMHF7lKyZrCmlA_1jvtvLsZPMQE'))
          ],
        ),
      ),
    );
  }
}

var pickedFilename;
File? imageFile;
var imagePicker=ImagePicker();
Future<File> pickImage()
async {
  // emit(PickImageLoadingState());
  final pickedFile=await imagePicker.pickImage(source: ImageSource.gallery);
  if(pickedFile!=null)
  {
    pickedFilename=pickedFile.path.split('/').last;
    imageFile=File(pickedFile.path);
    // emit(PickImageSuccessState());
  }
  else
  {
    print('no image selected');
    //emit(PickImageErrorState());
  }
  return imageFile!;

}