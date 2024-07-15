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
  
  

  void updateProfile() {
    User updated = User(
      uid: user.uid,
      firstName: firstName!,
      lastName: lastName!,
      email: email!,
      phoneNumber: phoneNumber!,
      location: location!,
      description: description!,
      displayPhoneNumber: displayPhoneNumber!,
      lookingForWork: lookingForWork!,
      lookingForWorkers: lookingForWorkers!,
      pfpURL: user.pfpURL,
      rating: user.rating,

    );
    Provider.of<UserState>(context, listen: false).user = updated;
    notifyListeners();
  }
}
