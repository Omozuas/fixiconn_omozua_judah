import 'package:fixiconn/apis/respones/general_respons.dart';
import 'package:fixiconn/apis/services/api_service.dart';
import 'package:fixiconn/apis/urls/connection_urls.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthApi {
  ApiService apiService = ApiService(baseUrl: ConnectionUrls.baseUrl);
  AuthApi(this.ref);
  final Ref ref;

  Future<GeneralRespons> createUser(
      {required String userName, required String password}) async {
    final token = await getAccessToken();
    try {
      final response = await apiService.post(
        endpoint: ConnectionUrls.signUp,
        token: token,
        body: {"name": userName, "password": password},
      );
      saveid(response);
      return response!;
    } catch (e) {
      rethrow;
    }
  }

  Future<GeneralRespons> loginData({
    required String userName,
    required String password,
  }) async {
    try {
      final response = await apiService.post(
        endpoint: ConnectionUrls.logIn,
        body: {"name": userName, "password": password},
      );
      saveToken(response);
      return response!;
    } catch (e) {
      rethrow;
    }
  }

  void saveToken(GeneralRespons? response) async {
    if (response!.accessToken == null) return;
    final preferences = await SharedPreferences.getInstance();
    preferences.setString('token', response.accessToken!);
    return;
  }

  void saveid(GeneralRespons? response) async {
    if (response!.data == null) return;
    final preferences = await SharedPreferences.getInstance();
    preferences.setString('userID', response.data['_id']);
    return;
  }

  Future<String> getAccessToken() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString('token') ?? '';
  }
}

final authApiProvider = Provider<AuthApi>((ref) => AuthApi(ref));
