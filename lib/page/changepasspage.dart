import 'package:flutter/material.dart';
import 'package:smp_app/theme.dart';
import 'package:provider/provider.dart';
import 'package:smp_app/providers/auth_provider.dart';
import 'package:smp_app/widget/loading_button.dart';

class ChangePassPage extends StatefulWidget {
  const ChangePassPage({super.key});

  @override
  State<ChangePassPage> createState() => _ChangePassPageState();
}

class _ChangePassPageState extends State<ChangePassPage> {
  bool _isLoading = false;
  bool _passwordvisible = false;
  void toogle() {
    setState(() {
      _passwordvisible = !_passwordvisible;
    });
  }

  TextEditingController passwordController = TextEditingController(text: '');
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    handleChangePass() async {
      setState(() {
        _isLoading = true;
      });

      if (await authProvider.changePass(passwordController.text)) {
        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: alertColor,
            content: const Text(
              'Request Gagal',
              textAlign: TextAlign.center,
            )));
      }
      setState(() {
        _isLoading = false;
      });
    }

    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back, color: primaryTextColor),
        ),
      ),
      body: Container(
          margin: EdgeInsets.only(top: 20, left: 30, right: 30, bottom: 30),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Align(
              child: Image.asset(
                'assets/resetpass.png',
                height: 200,
                width: 200,
                alignment: Alignment.center,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Align(
              child: (Text(
                'Masukkan Password Baru',
                style: primaryTextStyle.copyWith(
                    fontSize: 24, fontWeight: semiBold),
              )),
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              child: (Text(
                'Masukkan Password Baru Untuk Akun Anda',
                style: secondaryTextStyle.copyWith(
                    fontSize: 14, fontWeight: regular),
                textAlign: TextAlign.center,
              )),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
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
                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none),
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
            ),
            SizedBox(
              height: 30,
            ),
            _isLoading
                ? LoadingButton()
                : GestureDetector(
                    onTap: () {
                      handleChangePass();
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: bgColor3,
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                          child: Text(
                        'Reset Password',
                        style: whiteTextStyle.copyWith(
                            fontSize: 16, fontWeight: semiBold),
                      )),
                    ),
                  )
          ])),
    ));
  }
}
