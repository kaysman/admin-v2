import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lng_adminapp/presentation/screens/login/instruction.dart';
import 'package:lng_adminapp/shared.dart';
import 'widgets/layout.dart';

class ForgetPassword extends StatefulWidget {
  static const String routeName = 'forget-password';
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  String? _errorText;

  @override
  void initState() {
    _emailController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return LoginLayout(
      body: Expanded(
          child: Center(
        child: Container(
          width: 420,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 45,
                color: const Color(0xff000000).withOpacity(0.1),
              ),
            ],
          ),
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Spacings.kSpaceLarge,
                vertical: Spacings.kSpaceLittleBig,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Visibility(
                    visible: _errorText != null,
                    child: Container(
                      color: kDangerColor,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 13,
                      ),
                      child: Center(
                        child: Text(
                          "$_errorText",
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            color: kFailedColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Spacings.LITTLE_BIG_VERTICAL,
                  Text(
                    "Forget your password?",
                    style: GoogleFonts.inter(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacings.SMALL_VERTICAL,
                  Text(
                    "Don't worry. Just tell us the email address you registered with Load and Go.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  const SizedBox(height: 28),
                  ...buildEmailSection(),
                  Spacings.LITTLE_BIG_VERTICAL,
                  SizedBox(
                    width: 64,
                    child: ElevatedButton(
                      onPressed: onSendTapped,
                      child: Text("Send"),
                    ),
                  ),
                  Spacings.LITTLE_BIG_VERTICAL,
                  Text.rich(
                    TextSpan(
                      text:
                          "Forgot email? We'll need to manually verify you. Please reach out to your account manager or contact ",
                      style: Theme.of(context).textTheme.bodyText1,
                      children: [
                        TextSpan(
                          text: "customer support",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(color: kPrimaryColor),
                          mouseCursor: MaterialStateMouseCursor.clickable,
                          onEnter: (v) {},
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }

  buildEmailSection() {
    return [
      Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "Email",
          style: GoogleFonts.inter(
            fontSize: 12.sp,
          ),
        ),
      ),
      Spacings.TINY_VERTICAL,
      Align(
        alignment: Alignment.centerLeft,
        child: SizedBox(
          height: 32.0,
          child: TextFormField(
            controller: _emailController,
            validator: (v) {
              setState(() {
                _errorText = validateEmail(_emailController.text);
              });
              return null;
            },
            style: TextStyle(fontSize: 14.sp),
            decoration: InputDecoration(
              hintText: 'Enter email',
              errorStyle: TextStyle(
                height: 0,
                fontSize: 0,
              ),
            ),
          ),
        ),
      ),
    ];
  }

  onSendTapped() {
    if (_formKey.currentState?.validate() == true && _errorText == null) {
      _formKey.currentState?.save();
      Navigator.pushNamed(
        context,
        InstructionsSentPage.routeName,
      );
    } else {
      return;
    }
  }
}
