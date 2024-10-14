import 'package:flutter/material.dart';
import 'package:validation_pro/validate.dart';
import 'package:helping_hand/services/models.dart';

class SignupInputs {
  SignupInputs(this.firstName, this.lastName, this.email, this.phoneNumber,
      this.password, this.lookingForWork, this.lookingForWorkers);
  String firstName = '';
  String lastName = '';
  String email = '';
  String phoneNumber = '';
  String password = '';
  bool lookingForWork = false;
  bool lookingForWorkers = false;
}

bool validateInputs(SignupInputs inputs, BuildContext context) {
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

User assembleUser(SignupInputs inputs) {
  return User(
    firstName: inputs.firstName,
    lastName: inputs.lastName,
    email: inputs.email,
    phoneNumber: inputs.phoneNumber,
    lookingForWork: inputs.lookingForWork,
    lookingForWorkers: inputs.lookingForWorkers,
  );
  
}
