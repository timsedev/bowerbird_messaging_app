import 'package:bowerbird_messaging_app/app/app.locator.dart';
import 'package:bowerbird_messaging_app/app/app.router.dart';
import 'package:bowerbird_messaging_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  final _authService = locator<AuthService>();
  final _navigationService = locator<NavigationService>();

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> login() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    final isSuccess =
        await _authService.login(emailController.text, passwordController.text);

    if (isSuccess) {
      _navigationService.replaceWithHomeView();
    } else {
      ScaffoldMessenger.of(StackedService.navigatorKey!.currentContext!)
          .showSnackBar(
        const SnackBar(
          content: Text('Login failed'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
