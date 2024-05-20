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
                  buildTextField("First Name", false),
                  buildTextField("Last Name", false),
                  buildTextField("Email", false),
                  buildTextField("Phone Number", false),
                  const CustomTextField(labelText: 'Password', obscureText: true),
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

TextField buildTextField(String labelText, bool obscureText) {
  return TextField(
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

  const CustomTextField({super.key, required this.labelText, this.obscureText = false});

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;
  final TextEditingController _controller = TextEditingController();
  bool _hasInput = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
    _controller.addListener(() {
      setState(() {
        _hasInput = _controller.text.isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
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
