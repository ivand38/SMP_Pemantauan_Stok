import 'package:flutter/material.dart';
import 'package:smp_app/theme.dart';

class LoadingButton extends StatelessWidget {
  const LoadingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
          color: bgColor3,
          borderRadius: const BorderRadius.all(Radius.circular(12))),
      child: TextButton(
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation(bgColor1),
              ),
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              'Loading',
              style:
                  whiteTextStyle.copyWith(fontSize: 16, fontWeight: semiBold),
            ),
          ],
        ),
      ),
    );
  }
}
