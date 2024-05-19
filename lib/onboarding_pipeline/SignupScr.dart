import 'package:flutter/material.dart';

class EmailSignupScr extends StatelessWidget {
  const EmailSignupScr({super.key});

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
                  buildTextField("First Name"),
                  buildTextField("Last Name"),
                  buildTextField("Email"),
                  buildTextField("Phone Number"),
                  buildTextField("Password")
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
                          Navigator.pushNamed(context, '/personalInfo');
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
                                      const Size(0, 50)), // set the height as needed
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

TextField buildTextField(String labelText) {
  return TextField(
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
