import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:read_pdf/controllers/login_controller.dart';
import 'package:read_pdf/utils/app_theme.dart';
import '../widgets/app_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            _buildLeftSide(context),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(120.0),
                child: _buildForm(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeftSide(BuildContext context) {
    final isWideScreen = MediaQuery.of(context).size.width > 1100;
    final isMediumScreen = MediaQuery.of(context).size.width >= 880;

    return (isWideScreen || (isMediumScreen && !isWideScreen))
        ? Container(
            height: double.infinity,
            width: MediaQuery.of(context).size.width - 650,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.primaryColor,
                  Color(0xff1DBA46),
                  Color(0xff1ADA4C),
                ],
              ),
            ),
            child: const Align(
              alignment: Alignment.center,
              child: Text(
                "Mening oilam",
                style: TextStyle(
                  fontSize: 36.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          )
        : const SizedBox.shrink();
  }

  Widget _buildForm() {
    return Form(
      key: loginController.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Hello again!",
            style: TextStyle(
              color: Color(0xff333333),
              fontSize: 26,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10.0, bottom: 30.0),
            child: Text(
              "Welcome back",
              style: TextStyle(
                color: Color(0xff333333),
                fontSize: 18,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          _buildTextField(
            controller: loginController.fullNameController,
            hintText: "Full name",
            validator: (value) => value == null || value.isEmpty
                ? 'Please enter your Full name'
                : null,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: _buildPasswordField(),
          ),
          Obx(
            () {
              if (loginController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              return AppButton(
                text: "Log in",
                color: AppColors.primaryColor,
                onTap: () {
                  loginController.submit();
                },
              );
            },
          ),
          Obx(
            () {
              if (loginController.errorMessage.value.isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    loginController.errorMessage.value,
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required FormFieldValidator<String> validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xffF2F5F9),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Color(0xffB2BBC6),
          fontWeight: FontWeight.w400,
          fontSize: 16.0,
        ),
      ),
      validator: validator,
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: loginController.passwordController,
      obscureText: !loginController.isPasswordVisible.value,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: () {
            // setState(() {
            //   _isPasswordVisible = !_isPasswordVisible;
            // });
            loginController.togglePasswordVisibility();
          },
          icon: Icon(
            loginController.isPasswordVisible.value
                ? CupertinoIcons.eye
                : CupertinoIcons.eye_slash,
          ),
        ),
        filled: true,
        fillColor: const Color(0xffF2F5F9),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        hintText: "Password",
        hintStyle: const TextStyle(
          color: Color(0xffB2BBC6),
          fontWeight: FontWeight.w400,
          fontSize: 16.0,
        ),
      ),
      validator: (value) =>
          value == null || value.isEmpty ? 'Please enter your password' : null,
    );
  }
}
