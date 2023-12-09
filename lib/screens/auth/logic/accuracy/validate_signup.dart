import 'package:quickalert/quickalert.dart';
import 'package:shop_app/screens/app.dart';
import 'package:email_validator/email_validator.dart';

class ValidateSignUp {
  Future<void> isValidSignUpForm(String name, String email, String password,
      String confirmPassword) async {
    var errorDes = '';
    final context = applicationKey.currentContext;
    if (context == null) {
      return;
    }
    if (name.length < 3) {
      errorDes =
          'Please provide a name that is longer than 3 letters and shorter than 30 letters.';
    } else if (email.isEmpty || password.isEmpty) {
      errorDes = 'Please enter both email and password.';
    } else if (!EmailValidator.validate(email)) {
      errorDes = 'Email is not valid.';
    } else if (password.length < 6) {
      errorDes = 'Password is not valid. It should be at least 6 characters.';
    } else if (password.length < 6) {
      errorDes = 'Password is not valid. It should be at least 6 characters.';
    }
    if (errorDes.isNotEmpty)
      QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: "Oops...",
          text: errorDes);
    return;
  }
}
