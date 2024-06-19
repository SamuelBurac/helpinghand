import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_password_strength/flutter_password_strength.dart';
import 'package:validation_pro/validate.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
// import 'package:google_places_flutter/google_places_flutter.dart';
// import 'package:google_places_flutter/model/prediction.dart';

class SignupInputs {
  SignupInputs(
      this.firstName,
      this.lastName,
      this.email,
      this.phoneNumber,
      this.password,
      this.lookingForWork,
      this.lookingForWorkers);
  String firstName = '';
  String lastName = '';
  String email = '';
  String phoneNumber = '';
  String password = '';
  bool lookingForWork = false;
  bool lookingForWorkers = false;
  
}

class SignupScr extends StatefulWidget {
  const SignupScr({super.key});

  @override
  State<SignupScr> createState() => _SignupScrState();
}

class _SignupScrState extends State<SignupScr> {
  String password = '';
  String location = '';
  String phoneNumber = '';
  bool lookingForWork = false;
  bool lookingForWorkers = false;
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  
  var docRef;

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
                //inputs
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            FlutterPasswordStrength(
                              password: password,
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: 10,
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
                //create account and login buttons
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
                                docRef = await storeInputs(inputs, context);
                                Navigator.pushNamed(context, '/profileSetup',
                                    arguments: docRef);
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
        ),
      ),
    );
  }
}

bool validateInputs(SignupInputs inputs, BuildContext context) {
  // validate inputs
  List invalids = [];
  if (inputs.firstName.isEmpty) {
    invalids.add('First Name');
  }
  if (inputs.lastName.isEmpty) {
    invalids.add('Last Name');
  }
  if (inputs.email.isEmpty || !Validate.isEmail(inputs.email)) {
    invalids.add('Email');
  }
  RegExp regExp = RegExp(r'^\d{10}$');
  if (inputs.phoneNumber.isEmpty || !regExp.hasMatch(inputs.phoneNumber)) {
    invalids.add('Phone Number');
  }
  if (inputs.password.isEmpty || inputs.password.length < 8) {
    invalids.add('Password');
  }
  // if (inputs.location.isEmpty) {
  //   invalids.add('Location');
  // } location can be required if app has a large user base
  if (invalids.isEmpty) {
    if (inputs.lookingForWork == false && inputs.lookingForWorkers == false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          content: Text(
            'Please select at least one option for "Looking for work?" or "Looking for workers?"',
            style: TextStyle(color: Color.fromARGB(255, 255, 46, 46)),
          ),
        ),
      );
      return false;
    } else {
      return true;
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        content: Text(
          'The field(s) ${invalids.join(', ')} are invalid. Please correct them.',
          style: const TextStyle(color: Color.fromARGB(255, 255, 0, 0)),
        ),
      ),
    );
    return false;
  }
}

Future<DocumentReference> storeInputs(
    SignupInputs inputs, BuildContext context) async {
  final firestoreInstance = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  try {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
      email: inputs.email,
      password: inputs.password,
    );

    var docRef =
        firestoreInstance.collection('users').doc(userCredential.user!.uid);

    await docRef.set({
      'firstName': inputs.firstName,
      'lastName': inputs.lastName,
      'email': inputs.email,
      'phoneNumber': inputs.phoneNumber,
      'uid': userCredential.user!.uid,
      "lookingForWork": inputs.lookingForWork,
      'lookingForWorkers': inputs.lookingForWorkers,
      
    });

    return docRef;
  } catch (error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.grey.shade600,
        content: Text(
          'Failed with error $error',
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );

    // If a user was created, delete it
    if (auth.currentUser != null) {
      await auth.currentUser!.delete();
    }

    rethrow;
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
