import 'dart:convert';

import 'package:googleapis_auth/auth_io.dart';
import 'package:my_coach/resourses/managers_files/secret_api_key_manager.dart';

class NotificationService {
  static late  AutoRefreshingAuthClient _authClient;

  static final List<String> _scopes = [
    'https://www.googleapis.com/auth/firebase.messaging'
  ];
  static final Uri _url = Uri.parse(
      'https://fcm.googleapis.com/v1/projects/portable-gym-a5cee/messages:send');

  static init() async {

    final Map<String, dynamic> serviceAccount =
        SecretApiKeyManager.serviceAccountJson;

    final ServiceAccountCredentials credentials =
        ServiceAccountCredentials.fromJson(serviceAccount);
    _authClient = await clientViaServiceAccount(credentials, _scopes);
  }

  static Future<void> sendNotification(
      {required String receiverDeviceToken,
      required String title,
     required String body
      }) async {

    final Map<String, dynamic> message = {
      'message': {
        'token': receiverDeviceToken,
        'notification': {
          'title': title,
          'body':body,
        },
      },
    };
    await _authClient.post(
      _url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(message),
    );
  }

static  close(){
    _authClient.close();
  }
}
