import 'package:get/get.dart';

class UserController extends GetxController{

  bool checkCredentials(String email, String password) {
    return email == 'Admin@unimap.com' && password == '123456';
  }
}
