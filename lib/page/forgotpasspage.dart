import 'package:flutter/material.dart';
import 'package:smp_app/theme.dart';
import 'package:provider/provider.dart';
import 'package:smp_app/providers/auth_provider.dart';
import 'package:smp_app/widget/loading_button.dart';

class ForgotPassPage extends StatefulWidget {
  const ForgotPassPage({super.key});

  @override
  State<ForgotPassPage> createState() => _ForgotPassPageState();
}

class _ForgotPassPageState extends State<ForgotPassPage> {
  bool _isLoading = false;
  TextEditingController emailController = TextEditingController(text: '');
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    handleGenerateCode() async {
      setState(() {
        _isLoading = true;
      });

      if (await authProvider.generateCode(emailController.text)) {
        Navigator.pushNamed(context, '/passcode');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: alertColor,
            content: const Text(
              'Gagal Generate Kode',
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
                'Masukkan Email',
                style: primaryTextStyle.copyWith(
                    fontSize: 24, fontWeight: semiBold),
              )),
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              child: (Text(
                'Masukkan Email Anda Untuk Mereset Password',
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
                        border: const OutlineInputBorder(
                            borderSide: BorderSide.none),
                      ),
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
                      handleGenerateCode();
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: bgColor3,
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                          child: Text(
                        'Generate Kode',
                        style: whiteTextStyle.copyWith(
                            fontSize: 16, fontWeight: semiBold),
                      )),
                    ),
                  )
          ])),
    ));
  }
}
