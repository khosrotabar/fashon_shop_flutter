import 'package:fashon_shop/common/utils/kcolors.dart';
import 'package:fashon_shop/common/widgets/app_style.dart';
import 'package:fashon_shop/common/widgets/back_button.dart';
import 'package:fashon_shop/common/widgets/custom_button.dart';
import 'package:fashon_shop/common/widgets/email_textfield.dart';
import 'package:fashon_shop/common/widgets/password_field.dart';
import 'package:fashon_shop/src/auth/controllers/auth_notifier.dart';
import 'package:fashon_shop/src/auth/models/login_model.dart';
import 'package:fashon_shop/src/entrypoint/controllers/bottom_tab_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _passwordNode = FocusNode();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _passwordNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<AuthNotifier>(context);
    final controller2 = Provider.of<TabIndexNotifier>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: AppBackButton(
          onTap: () {
            controller2.setIndex = 0;
            context.go('/home');
          },
        ),
      ),
      body: ListView(
        children: [
          SizedBox(height: 160.h),
          Text(
            'DBest Fashons',
            style: appStyle(
              24,
              Kolors.kPrimary,
              FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10.h),
          Text(
            "Hi! Welcome back. You've been missed",
            style: appStyle(
              13,
              Kolors.kGray,
              FontWeight.normal,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 25.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                EmailTextField(
                  radius: 25,
                  focusNode: _passwordNode,
                  hintText: 'Username',
                  controller: _usernameController,
                  prefixIcon: const Icon(CupertinoIcons.profile_circled, size: 20, color: Kolors.kGray),
                  keyboardType: TextInputType.name,
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(_passwordNode);
                  },
                ),
                SizedBox(height: 25.h),
                PasswordField(
                  controller: _passwordController,
                  focusNode: _passwordNode,
                  radius: 25,
                ),
                SizedBox(height: 20.h),
                controller.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Kolors.kPrimary,
                          valueColor: AlwaysStoppedAnimation<Color>(Kolors.kWhite),
                        ),
                      )
                    : GradientBtn(
                        onTap: () {
                          LoginModel model = LoginModel(
                            password: _passwordController.text,
                            username: _usernameController.text,
                          );

                          String data = loginModelToJson(model);

                          controller.loginFunction(data, context);
                        },
                        text: 'L O G I N',
                        btnWidth: ScreenUtil().screenWidth,
                        btnHieght: 40,
                        radius: 20,
                      ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 130.h,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 110),
            child: GestureDetector(
              onTap: () {
                context.push('/register');
              },
              child: Text(
                'Do not have account? Register a new one',
                style: appStyle(
                  12,
                  Colors.blue,
                  FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
