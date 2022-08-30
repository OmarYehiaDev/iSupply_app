import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isupply/blocs/auth_cubit/auth_cubit.dart';
import 'package:isupply/components/inputs/input_field.dart';

import '../../components/header.dart';
import '../../components/inputs/loading_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final cubit = AuthCubit.of(context);
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Header(),
                InputField(
                  width: width * 0.85,
                  controller: cubit.phoneCtrl,
                  labelText: "Log In or Sign Up",
                  labelStyle: Theme.of(context).textTheme.button,
                  prefixIcon: const Text("Flag"),
                  prefix: const Text("+996"),
                  hintText: "055xxxxxxx",
                  maxChars: 10,
                ),
                RichText(
                  text: TextSpan(
                    text: "By continuing, I agree to",
                    style: Theme.of(context).textTheme.bodyText2,
                    children: [
                      TextSpan(
                        text: "Terms of use & Privacy policy",
                        style: Theme.of(context).textTheme.caption,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            if (kDebugMode) {
                              print("View Terms & Privacy policy");
                            }
                          },
                      ),
                    ],
                  ),
                ),
                LoadingButton(
                  isValid: true,
                  isLoading: false,
                  onPressed: cubit.loginOrRegister,
                  title: "Continue",
                  buttonSize: Size(width * 0.85, 30),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
