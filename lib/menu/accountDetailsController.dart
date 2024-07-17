part of 'accountDetails.dart';

class AccountDetailsController with ChangeNotifier {
  late BuildContext context;
  late User user;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? location;
  String? description;
  bool? displayPhoneNumber;
  bool? lookingForWork;
  bool? lookingForWorkers;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  AccountDetailsController(this.context) {
    user = Provider.of<UserState>(context, listen: false).user;
    firstName = user.firstName;
    lastName = user.lastName;
    email = user.email;
    phoneNumber = user.phoneNumber;
    location = user.location;
    description = user.description;
    displayPhoneNumber = user.displayPhoneNumber;
    lookingForWork = user.lookingForWork;
    lookingForWorkers = user.lookingForWorkers;
    firstNameController.text = firstName!;
    lastNameController.text = lastName!;
    emailController.text = email!;
    phoneNumberController.text = phoneNumber!;
    locationController.text = location!;
    descriptionController.text = description!;
  }

  String? get getFirstName => firstName;
  String? get getLastName => lastName;
  String? get getEmail => email;
  String? get getPhoneNumber => phoneNumber;
  String? get getLocation => location;
  String? get getDescription => description;
  bool? get getDisplayPhoneNumber => displayPhoneNumber;
  bool? get getLookingForWork => lookingForWork;
  bool? get getLookingForWorkers => lookingForWorkers;

  void setFirstName(String value) {
    firstName = value;
    notifyListeners();
  }

  set setLastName(String value) {
    lastName = value;
    notifyListeners();
  }

  set setEmail(String value) {
    email = value;
    notifyListeners();
  }

  set setPhoneNumber(String value) {
    phoneNumber = value;
    notifyListeners();
  }

  set setLocation(String value) {
    location = value;
    notifyListeners();
  }

  set setDescription(String value) {
    description = value;
    notifyListeners();
  }

  set setDisplayPhoneNumber(bool value) {
    displayPhoneNumber = value;
    notifyListeners();
  }

  set setLookingForWork(bool value) {
    lookingForWork = value;
    notifyListeners();
  }

  set setLookingForWorkers(bool value) {
    lookingForWorkers = value;
    notifyListeners();
  }

  bool verifyInputs() {
    if (firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        phoneNumberController.text.isEmpty ||
        locationController.text.isEmpty ||
        descriptionController.text.isEmpty) {
      return false;
    }
    return true;
  }

  void updateProfile() {
    User updated = User(
      uid: user.uid,
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      email: emailController.text,
      phoneNumber: phoneNumberController.text,
      location: locationController.text,
      description: descriptionController.text,
      displayPhoneNumber: displayPhoneNumber!,
      lookingForWork: lookingForWork!,
      lookingForWorkers: lookingForWorkers!,
      pfpURL: user.pfpURL,
      rating: user.rating,
    );
    Provider.of<UserState>(context, listen: false).user = updated;
    FirestoreService().updateUser(updated);
    notifyListeners();
  }
}

class EditButtonState extends ChangeNotifier {
  bool isEditing = false;

  void toggleEditing() {
    isEditing = !isEditing;
    notifyListeners();
  }
}

class EditTextWithButton extends StatelessWidget {
  final TextEditingController controller;
  late final String labelText;

  EditTextWithButton(
      {required this.controller, required this.labelText, super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EditButtonState(),
      child: Consumer(
        builder: (context, EditButtonState state, child) {
          return Row(
            children: [
              Expanded(
                child: TextField(
                  readOnly: !state.isEditing,
                  decoration: InputDecoration(
                      filled: !state.isEditing,
                      fillColor: Colors.grey.withOpacity(0.4),
                      labelText: labelText,
                      border: const OutlineInputBorder()),
                  controller: controller,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: TextButton(
                  style: Theme.of(context).textButtonTheme.style!.copyWith(
                        backgroundColor: WidgetStateProperty.all<Color>(
                            state.isEditing ? Colors.green: Colors.orange.shade900),
                      
                  ),
                  onPressed: () {
                    Provider.of<EditButtonState>(context, listen: false)
                        .toggleEditing();
                  },
                  child: Text(
                    state.isEditing ? "Good": "Edit",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
