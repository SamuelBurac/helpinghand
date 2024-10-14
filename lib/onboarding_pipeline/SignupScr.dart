import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_password_strength/flutter_password_strength.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:helping_hand/onboarding_pipeline/ProfileSetupScr.dart';
import 'package:helping_hand/services/models.dart';
import 'SignUpController.dart';

class SignupScr extends StatefulWidget {
  const SignupScr({super.key});

  @override
  State<SignupScr> createState() => _SignupScrState();
}

class _SignupScrState extends State<SignupScr> {
  String password = '';
  bool lookingForWork = false;
  bool lookingForWorkers = false;
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();

  User? newUser;

  @override
  void initState() {
    super.initState();

    passwordController.addListener(() {
      setState(() {
        password = passwordController.text;
      });
    });
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.arrow_back, size: 34.0),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  "Sign up",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
              Flexible(
                flex: 4,
                child: Container(
                  padding: const EdgeInsets.all(15.0),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      textSelectionTheme: const TextSelectionThemeData(
                        cursorColor: Colors.orange,
                        selectionHandleColor: Colors.orange,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextField(
                            labelText: 'First Name',
                            obscureText: false,
                            controller: firstNameController,
                            keyboardType: TextInputType.name),
                        CustomTextField(
                            labelText: 'Last Name',
                            obscureText: false,
                            controller: lastNameController,
                            keyboardType: TextInputType.name),
                        CustomTextField(
                            labelText: 'Phone Number',
                            obscureText: false,
                            controller: phoneNumberController,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              PhoneInputFormatter(
                                allowEndlessPhone: false,
                                defaultCountryCode: 'US',
                              ),
                              LengthLimitingTextInputFormatter(14)
                            ]),
                        CustomTextField(
                            labelText: 'Email',
                            obscureText: false,
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController),
                        CustomTextField(
                            labelText: 'Password',
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            controller: passwordController),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FlutterPasswordStrength(
                              password: password,
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: 15,
                              radius: 10,
                            ),
                            const Text(
                                "Password must be at least 8 characters long"),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 10.0),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CheckboxListTile(
                              title: const Text(
                                "Looking for work?",
                                style: TextStyle(fontSize: 20),
                              ),
                              activeColor: Colors.orange,
                              controlAffinity: ListTileControlAffinity.trailing,
                              value: lookingForWork,
                              onChanged: (bool? value) {
                                setState(() {
                                  lookingForWork = value!;
                                });
                              },
                            ),
                            CheckboxListTile(
                              title: const Text(
                                "Looking for workers?",
                                style: TextStyle(fontSize: 20),
                              ),
                              activeColor: Colors.orange,
                              controlAffinity: ListTileControlAffinity.trailing,
                              value: lookingForWorkers,
                              onChanged: (bool? value) {
                                setState(() {
                                  lookingForWorkers = value!;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.height * 0.05,
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/login');
                            },
                            style: Theme.of(context)
                                .textButtonTheme
                                .style
                                ?.copyWith(
                                  backgroundColor:
                                      WidgetStateProperty.all<Color>(
                                          Colors.grey.shade600),
                                  textStyle: WidgetStateProperty.all<TextStyle>(
                                    const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  minimumSize: WidgetStateProperty.all<Size>(
                                      const Size(0, 50)),
                                ),
                            child: const Text("Already a member? Log in"),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.height * 0.05,
                          child: TextButton(
                            onPressed: () async {
                              SignupInputs inputs = SignupInputs(
                                  firstNameController.text,
                                  lastNameController.text,
                                  emailController.text.trim(),
                                  phoneNumberController.text
                                      .replaceAll(RegExp(r'\D'), ''),
                                  passwordController.text,
                                  lookingForWork,
                                  lookingForWorkers);

                              if (validateInputs(inputs, context)) {
                                newUser = assembleUser(inputs);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProfileSetupScr(
                                            newUser: newUser!,
                                            password:
                                                passwordController.text)));
                              }
                            },
                            style: Theme.of(context)
                                .textButtonTheme
                                .style
                                ?.copyWith(
                                  textStyle: WidgetStateProperty.all<TextStyle>(
                                    const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  minimumSize: WidgetStateProperty.all<Size>(
                                      const Size(0, 50)),
                                ),
                            child: const Text("Create Account"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatefulWidget {
  final String labelText;
  final bool obscureText;
  final TextEditingController controller;
  final List<TextInputFormatter> inputFormatters;
  final TextInputType keyboardType;

  const CustomTextField({
    super.key,
    required this.labelText,
    this.obscureText = false,
    required this.controller,
    this.inputFormatters = const [],
    required this.keyboardType,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;
  bool _hasInput = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
    widget.controller.addListener(() {
      setState(() {
        _hasInput = widget.controller.text.isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      inputFormatters: widget.inputFormatters,
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      obscureText: _obscureText,
      cursorColor: Colors.orange,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        floatingLabelStyle: const TextStyle(
          color: Colors.orange,
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.orange,
            width: 1.0,
          ),
        ),
        labelText: widget.labelText,
        suffixIcon: widget.obscureText && _hasInput
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  color: Colors.orange,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
      ),
    );
  }
}
