import 'package:sticky_notes/models/api/login_response.dart';
import 'package:sticky_notes/service/base_service.dart';

class LoginService extends BaseService{
  static LoginService instance = LoginService();

  Future<LoginResponse?> doLogin({required String email, required String password}) async {
    return post('/api/login', body: {
      'email' : email,
      'password': password
    });
  }
}