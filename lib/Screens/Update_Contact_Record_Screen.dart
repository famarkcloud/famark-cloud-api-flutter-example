import 'package:flutter/material.dart';
import '../services/FamarkCloudAPI.dart';
import 'Display_Contact_Records_Screen.dart';

class UpdateContact extends StatefulWidget {
  final Map<String, dynamic> contactData;
  const UpdateContact({Key? key, required this.contactData}) : super(key: key);

  @override
  State<UpdateContact> createState() => _UpdateContactState();
}

class _UpdateContactState extends State<UpdateContact> {

  FamarkCloudAPI cloudAPI = FamarkCloudAPI();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  String? _contactType;
  final contactTypesList = ['Colleague', 'Family', 'Friend'];

  Future updateContact() async{
    if(!formKey.currentState!.validate()) {
      return;
    }
    String name = nameController.text;
    String contactType = _contactType!;
    await cloudAPI.updateRecords(name, contactType, widget.contactData['ContactId']);
  }

  @override
  void initState() {
    // TODO: set text
    super.initState();
    nameController.text = widget.contactData['FirstName'];
    _contactType = widget.contactData['ContactType'];
  }

  DropdownMenuItem<String> buildMenuItem(String item) =>
      DropdownMenuItem(
          value: item,
          child: Text(
              item,
              style: const TextStyle(fontWeight: FontWeight.bold)
          )
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Contact"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Center(
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: nameController,
                  autofocus: true,
                  maxLength: 15,
                  validator: (name){
                    if(name == null || name.isEmpty){
                      return "Required *";
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Name",
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: DropdownButtonFormField(
                      value: _contactType,
                      hint: const Text('Select Contact Type'),
                      validator: (contactType) {
                        if(contactType == null || contactType.toString().isEmpty) {
                          return "Required *";
                        } else {
                          return null;
                        }
                      },
                      items: contactTypesList.map(buildMenuItem).toList(),
                      onChanged: (contactType) => _contactType=contactType as String?,
                    )
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                      onPressed: () async{
                        await updateContact();
                        // retrieve the records first then go to next screen
                        await DisplayState().setContactRecords();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Display(),
                          ),
                        );
                      },
                      child: const Text('Update'),
                    )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}