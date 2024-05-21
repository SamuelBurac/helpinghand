import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupInputs {
  SignupInputs(this.firstName, this.lastName, this.email, this.phoneNumber,
      this.password);
  String firstName = '';
  String lastName = '';
  String email = '';
  String phoneNumber = '';
  String password = '';
}

class SignupScr extends StatefulWidget {
  const SignupScr({super.key});

  @override
  State<SignupScr> createState() => _SignupScrState();
}

class _SignupScrState extends State<SignupScr> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();

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
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
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
            child: Container(
              padding: const EdgeInsets.all(15.0),
              constraints:
                  BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomTextField(
                      labelText: 'First Name',
                      obscureText: false,
                      controller: firstNameController),
                  CustomTextField(
                      labelText: 'Last Name',
                      obscureText: false,
                      controller: lastNameController),
                  CustomTextField(
                      labelText: 'Email',
                      obscureText: false,
                      controller: emailController),
                  CustomTextField(
                      labelText: 'Phone Number',
                      obscureText: false,
                      controller: phoneNumberController),
                  CustomTextField(
                      labelText: 'Password',
                      obscureText: true,
                      controller: passwordController),
                ],
              ),
            ),
          ),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(10.0).copyWith(bottom: 25.0),
              constraints:
                  BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        style: Theme.of(context)
                            .textButtonTheme
                            .style
                            ?.copyWith(
                              backgroundColor: WidgetStateProperty.all<Color>(
                                  Colors.grey.shade600),
                              textStyle: WidgetStateProperty.all<TextStyle>(
                                const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              minimumSize: WidgetStateProperty.all<Size>(
                                  const Size(
                                      0, 50)), // set the height as needed
                            ),
                        child: const Text("Already a member? Log in"),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextButton(
                        onPressed: () {
                          SignupInputs inputs = SignupInputs(
                              firstNameController.text,
                              lastNameController.text,
                              emailController.text,
                              phoneNumberController.text,
                              passwordController.text);
                          String firstName = firstNameController.text;
                          print("forgetti" + firstName + "spaghet");
                          print(inputs.lastName);
                          print(inputs.email);
                          print(inputs.phoneNumber);
                          print(inputs.password);

                          validateInputs();
                          storeInputs();
                          // createAccount(
                          //     'email', 'password'); //update email and password
                          // Navigator.pushNamed(context, '/personalInfo');
                        },
                        style:
                            Theme.of(context).textButtonTheme.style?.copyWith(
                                  textStyle: WidgetStateProperty.all<TextStyle>(
                                    const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  minimumSize: WidgetStateProperty.all<Size>(
                                      const Size(
                                          0, 50)), // set the height as needed
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
    );
  }
}

void validateInputs() {}

void storeInputs() {}

void createAccount(String emailAddress, String password) async {
  try {
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
  } catch (e) {
    print(e);
  }
}

TextField buildTextField(
    TextEditingController controller, String labelText, bool obscureText) {
  return TextField(
    controller: controller,
    obscureText: obscureText,
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
      labelText: labelText,
    ),
  );
}

class CustomTextField extends StatefulWidget {
  final String labelText;
  final bool obscureText;
  final TextEditingController controller;

  const CustomTextField({
    super.key,
    required this.labelText,
    this.obscureText = false,
    required this.controller,
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
