part of "ProfileSetupScr.dart";

Future<User> submitProfileData(
  bool thirdPartySignup,
  User newUser,
  String password,
  File selectedImage,
  String location,
  String description,
  bool displayPhoneNumber,
) async {
  String storageURL = "";
  final String userID;
  try {
    if (!thirdPartySignup) {
      userID = await AuthService().createUserWEAndPass(newUser.email, password);
    } else {
      userID = AuthService().user!.uid;
    }
    storageURL =
        await FirestoreService().uploadProfilePicture(userID, selectedImage);

    User finalUser = User(
      uid: userID,
      email: newUser.email,
      firstName: newUser.firstName,
      lastName: newUser.lastName,
      phoneNumber: newUser.phoneNumber,
      lookingForWork: newUser.lookingForWork,
      lookingForWorkers: newUser.lookingForWorkers,
      pfpURL: storageURL,
      location: location,
      description: description,
      displayPhoneNumber: displayPhoneNumber,
      numPostsLeft: 3,
      isPremium: false,
    );

    await FirestoreService().createNewUser(finalUser);
    return finalUser;
  } catch (e) {
    throw Exception("Error uploading profile data: $e");
  }
}
