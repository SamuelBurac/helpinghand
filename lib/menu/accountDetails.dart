import 'package:flutter/material.dart';
import 'package:helping_hand/services/UserState.dart';
import 'package:helping_hand/services/models.dart';
import 'package:provider/provider.dart';
part 'accountDetailsController.dart';

class AccountDetails extends StatelessWidget {
  const AccountDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Details'),
      ),
      body: ChangeNotifierProvider(
        create: (context) => AccountDetailsController(context),
        child: Consumer<AccountDetailsController>(
          builder: (context, controller, child) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(
                              labelText: "First Name",
                              border: OutlineInputBorder()),
                          readOnly: true,
                          controller: TextEditingController(
                            text: controller.user.firstName,
                          ),
                          onChanged: (value) {},
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: TextButton(
                          onPressed: () {},
                          child: const Text("Edit"),
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          readOnly: true,
                          decoration: const InputDecoration(
                              labelText: "Last Name", border: OutlineInputBorder()),
                          controller:
                              TextEditingController(text: controller.user.lastName),
                          onChanged: (value) {},
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: TextButton(
                          onPressed: () {},
                          child: const Text("Edit"),
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          readOnly: true,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                              labelText: "Email", border: OutlineInputBorder()),
                          controller:
                              TextEditingController(text: controller.user.email),
                          onChanged: (value) {},
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: TextButton(
                          onPressed: () {},
                          child: const Text("Edit"),
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          readOnly: true,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                              labelText: "Phone Number", border: OutlineInputBorder()),
                          controller: TextEditingController(
                              text: controller.user.phoneNumber),
                          onChanged: (value) {},
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: TextButton(
                          onPressed: () {},
                          child: const Text("Edit"),
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          readOnly: true,
                          decoration: const InputDecoration(
                                    labelText: "Location",
                                    border: OutlineInputBorder()
                                ),
                          controller:
                              TextEditingController(text: controller.user.location),
                          onChanged: (value) {},
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: TextButton(
                          onPressed: () {},
                          child: const Text("Edit"),
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          readOnly: true,
                          decoration: const InputDecoration(
                                    labelText: "Description",
                                    border: OutlineInputBorder()
                                ),
                          minLines: 1,
                          maxLines: 5,
                          controller: TextEditingController(
                              text: controller.user.description),
                          onChanged: (value) {},
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: TextButton(
                          onPressed: () {},
                          child: const Text("Edit"),
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  CheckboxListTile(
                    title: const Text(
                      "Display phone number on profile page?",
                      style: TextStyle(fontSize: 20),
                    ),
                    activeColor: Colors.orange,
                    controlAffinity: ListTileControlAffinity.trailing,
                    value: controller.displayPhoneNumber,
                    onChanged: (bool? value) {
                      controller.displayPhoneNumber = value!;
                    },
                  ),
                  const Divider(),
                  CheckboxListTile(
                    title: const Text(
                      "Looking for work?",
                      style: TextStyle(fontSize: 20),
                    ),
                    activeColor: Colors.orange,
                    controlAffinity: ListTileControlAffinity.trailing,
                    value: controller.lookingForWork,
                    onChanged: (bool? value) {
                      controller.lookingForWork = value!;
                    },
                  ),
                  const Divider(),
                  CheckboxListTile(
                    title: const Text(
                      "Looking for workers?",
                      style: TextStyle(fontSize: 20),
                    ),
                    activeColor: Colors.orange,
                    controlAffinity: ListTileControlAffinity.trailing,
                    value: controller.lookingForWorkers,
                    onChanged: (bool? value) {
                      controller.lookingForWorkers = value!;
                    },
                  ),
                  const Divider(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
