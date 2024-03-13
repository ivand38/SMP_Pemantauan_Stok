import 'package:flutter/material.dart';
import 'package:smp_app/theme.dart';
import 'package:smp_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:smp_app/widget/loading_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _passwordvisible = false;
  void toogle() {
    setState(() {
      _passwordvisible = !_passwordvisible;
    });
  }

  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    handleLogin() async {
      setState(() {
        isLoading = true;
      });

      if (await authProvider.login(
          email: emailController.text, password: passwordController.text)) {
        Navigator.pushNamedAndRemoveUntil(
            context, '/homepage', (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: alertColor,
            content: const Text(
              'Gagal Login',
              textAlign: TextAlign.center,
            )));
      }
      setState(() {
        isLoading = false;
      });
    }

    Widget emailInput() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: greyColor2,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: strokeColor),
            ),
            child: Center(
              child: Row(
                children: [
                  Expanded(
                      child: TextFormField(
                    controller: emailController,
                    style: primaryTextStyle,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      hintStyle: secondaryTextStyle.copyWith(fontSize: 14),
                      border:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ))
                ],
              ),
            ),
          ),
        ],
      );
    }

    Widget passwordInput() {
      return Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
            color: greyColor2,
            border: Border.all(color: strokeColor),
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            )),
        child: Center(
          child: Row(
            children: [
              Expanded(
                  child: TextField(
                controller: passwordController,
                style: primaryTextStyle,
                obscureText: !_passwordvisible,
                decoration: InputDecoration(
                    hintText: 'Password',
                    border:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                    hintStyle: secondaryTextStyle.copyWith(
                        fontSize: 14, fontWeight: regular),
                    suffixIcon: IconButton(
                        onPressed: () {
                          toogle();
                        },
                        icon: Icon(
                          _passwordvisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          size: 17,
                          color: primaryTextColor,
                        ))),
              ))
            ],
          ),
        ),
      );
    }

    Widget loginButton() {
      return GestureDetector(
        onTap: () {
          handleLogin();
        },
        child: Container(
          height: 50,
          decoration: BoxDecoration(
              color: bgColor3, borderRadius: BorderRadius.circular(15)),
          child: Center(
              child: Text(
            'Masuk',
            style: whiteTextStyle.copyWith(fontSize: 16, fontWeight: semiBold),
          )),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor3,
        resizeToAvoidBottomInset: false,
        body: Stack(children: [
          Container(
            height: 200,
            padding: const EdgeInsets.only(top: 60, bottom: 60),
            child: Center(
              child: Image.asset(
                'assets/logo.png',
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 200),
            padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30.0,
                ),
                Align(
                    child: Text(
                  'Masuk ke Akun Anda',
                  style: primaryTextStyle.copyWith(
                      fontSize: 24, fontWeight: semiBold),
                  textAlign: TextAlign.center,
                )),
                const SizedBox(
                  height: 10.0,
                ),
                Align(
                    child: Text('Silahkan Masukkan Email dan Password',
                        style: secondaryTextStyle.copyWith(
                            fontSize: 14, fontWeight: regular),
                        textAlign: TextAlign.center)),
                const SizedBox(height: 30.0),
                emailInput(),
                const SizedBox(
                  height: 20,
                ),
                passwordInput(),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/forgotpass');
                  },
                  child: Text('Lupa Password?',
                      style: blueTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: medium,
                          decoration: TextDecoration.underline,
                          decorationColor: bgColor3,
                          decorationThickness: 0.8)),
                ),
                const SizedBox(
                  height: 30,
                ),
                isLoading ? const LoadingButton() : loginButton(),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
