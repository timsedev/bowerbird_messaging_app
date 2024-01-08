import 'package:bowerbird_messaging_app/ui/common/logo.dart';
import 'package:bowerbird_messaging_app/ui/common/styles.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'login_viewmodel.dart';

class LoginView extends StackedView<LoginViewModel> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    LoginViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: viewModel.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Spacer(flex: 1),
              const Text(
                "Let's get started.",
                style: TextStyle(
                  fontSize: kFontSize2XL,
                  fontWeight: kFontWeightBold,
                ),
              ),
              verticalSpace2XS,
              const Text(
                'Sign in to your account.',
                style: TextStyle(
                  fontSize: kFontSizeS,
                  fontWeight: kFontWeightLight,
                ),
              ),
              verticalSpaceXL,
              _buildEmailField(viewModel),
              verticalSpaceM,
              _buildPasswordField(viewModel),
              verticalSpaceL,
              _buildLoginButton(viewModel),
              const Spacer(flex: 2),
              bowerBirdLogoAndText(size: sizeM, isDark: true),
              verticalSpaceS,
            ],
          ),
        ),
      ),
    );
  }

  @override
  LoginViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      LoginViewModel();

  Widget _buildEmailField(LoginViewModel viewModel) {
    return _buildField(
      viewModel,
      title: 'Email',
      controller: viewModel.emailController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email.';
        }

        final emailRegex =
            RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');

        if (!emailRegex.hasMatch(value)) {
          return 'Please enter a valid email';
        }

        return null;
      },
    );
  }

  Widget _buildPasswordField(LoginViewModel viewModel) {
    return _buildField(
      viewModel,
      title: 'Password',
      controller: viewModel.passwordController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password.';
        }
        return null;
      },
      isVisible: !viewModel.isVisible,
    );
  }

  Widget _buildField(LoginViewModel viewModel,
      {required String title,
      required TextEditingController controller,
      String? Function(String?)? validator,
      bool isVisible = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: sizeL),
      child: TextFormField(
        obscureText: isVisible,
        controller: controller,
        cursorColor: kPrimaryColor,
        cursorRadius: const Radius.circular(kBorderRadius),
        cursorWidth: 1.5,
        validator: validator,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 20, horizontal: sizeM),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kPrimaryColor, width: 1.5),
            borderRadius: BorderRadius.circular(kBorderRadius),
          ),
          labelText: title,
          labelStyle: const TextStyle(
            fontSize: kFontSizeS,
            fontWeight: kFontWeightSemiBold,
            color: kPrimaryColor,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kPrimaryColor, width: 1.5),
            borderRadius: BorderRadius.circular(kBorderRadius),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kErrorColor, width: 1.5),
            borderRadius: BorderRadius.circular(kBorderRadius),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kErrorColor, width: 1.5),
            borderRadius: BorderRadius.circular(kBorderRadius),
          ),
          suffixIcon: title == 'Password'
              ? IconButton(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onPressed: viewModel.toggleVisibility,
                  icon: Icon(
                    isVisible ? Icons.visibility_off : Icons.visibility,
                    size: sizeM,
                    color: isVisible ? kGreyColor : kPrimaryColor,
                  ),
                )
              : null,
        ),
      ),
    );
  }

  Widget _buildLoginButton(LoginViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: sizeL),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kBorderRadius),
          ),
        ),
        onPressed: () async => await viewModel.login(),
        child: Container(
          height: size3XL,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: sizeL,
            vertical: sizeM,
          ),
          child: Center(
            child: !viewModel.isBusy
                ? const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: kFontSizeM,
                      fontWeight: kFontWeightBold,
                    ),
                  )
                : ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxHeight: 20,
                      maxWidth: 20,
                    ),
                    child: const CircularProgressIndicator(
                      color: kWhiteColor,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
