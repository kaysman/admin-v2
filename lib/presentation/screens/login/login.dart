import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lng_adminapp/presentation/blocs/auth/auth.bloc.dart';
import 'package:lng_adminapp/presentation/blocs/auth/auth.state.dart';
import 'package:lng_adminapp/presentation/screens/index/index.screen.dart';
import 'package:lng_adminapp/presentation/screens/login/forget_password.dart';
import 'package:lng_adminapp/presentation/screens/login/widgets/layout.dart';
import 'package:lng_adminapp/shared.dart';
import 'login.bloc.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late LoginBloc loginBloc;

  late TextEditingController _emailController;
  String? _errorText;

  late TextEditingController _passwordController;
  bool? _rememberMe = false;

  @override
  void initState() {
    loginBloc = LoginBloc(context.read<AuthBloc>());
    _emailController = TextEditingController(text: 'bryan@gmail.com');
    _passwordController = TextEditingController(text: '@Password001');
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.authenticated &&
            state.identity != null) {
          goToHome();
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: LoginLayout(
            body: BlocBuilder<LoginBloc, LoginState>(
                bloc: loginBloc,
                builder: (context, state) {
                  return Expanded(
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          ?.copyWith(
                                            color: kFailedColor,
                                            fontSize: 12.sp,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                              Spacings.LITTLE_BIG_VERTICAL,
                              Text(
                                "Log in",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4
                                    ?.copyWith(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              Spacings.LITTLE_BIG_VERTICAL,
                              ...buildEmailSection(),
                              Spacings.NORMAL_VERTICAL,
                              ...buildPasswordSection(),
                              Spacings.TINY_VERTICAL,
                              buildRememberMe(),
                              Spacings.LITTLE_BIG_VERTICAL,
                              loginButton(),
                              Spacings.NORMAL_VERTICAL,
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, ForgetPassword.routeName);
                                },
                                child: Text(
                                  "Forgot password?",
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        );
      },
    );
  }

  loginButton() {
    return Button(
      textColor: kWhite,
      primary: kPrimaryColor,
      isLoading: loginBloc.state.status == LoginStatus.inProgress ||
          context.read<AuthBloc>().state.identityStatus ==
              IdentityStatus.loading,
      text: "Log in",
      onPressed: onLoginTapped,
      textStyle: GoogleFonts.inter(
        fontWeight: FontWeight.w500,
        fontSize: 18,
        color: kWhite,
      ),
    );
  }

  goToHome() => Navigator.of(context)
      .pushNamedAndRemoveUntil(IndexScreen.routeName, (_) => false);

  goTo(String route) =>
      Navigator.of(context).pushNamedAndRemoveUntil(route, (_) => false);

  buildEmailSection() {
    return [
      Align(
        alignment: Alignment.topLeft,
        child: SelectableText(
          "Email",
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
      Spacings.TINY_VERTICAL,
      Align(
        alignment: Alignment.topLeft,
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

  buildPasswordSection() {
    return [
      Align(
        alignment: Alignment.centerLeft,
        child: SelectableText(
          "Password",
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
      Spacings.TINY_VERTICAL,
      Align(
        alignment: Alignment.centerLeft,
        child: SizedBox(
          height: 32.0,
          child: TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
              hintText: 'Enter password',
            ),
          ),
        ),
      ),
    ];
  }

  buildRememberMe() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(children: [
        Checkbox(
          value: _rememberMe,
          onChanged: (v) {
            setState(() {
              _rememberMe = v;
            });
          },
        ),
        Spacings.TINY_HORIZONTAL,
        Text(
          "Remember me",
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ]),
    );
  }

  Future<void> onLoginTapped() async {
    if (_formKey.currentState!.validate() && _errorText == null) {
      _formKey.currentState!.save();
      Map<String, dynamic> loginData = {
        'emailAddress': _emailController.text,
        'password': _passwordController.text,
      };
      await loginBloc.login(loginData);
    } else {
      print('Form inputs are not valid');
      throw ("error");
    }
  }
}
