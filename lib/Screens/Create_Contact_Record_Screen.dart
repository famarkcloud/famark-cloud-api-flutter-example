import 'package:flutter/material.dart';
import '../services/FamarkCloudAPI.dart';
import 'Display_Contact_Records_Screen.dart';
//ignore: must_be_immutable
class CreateContactRecords extends StatelessWidget {
  CreateContactRecords({Key? key}) : super(key: key);

  FamarkCloudAPI cloudAPI = FamarkCloudAPI();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  Future createContact() async{
    if(!formKey.currentState!.validate()) {
        return;
    }
    String name = nameController.text;
    String phone = phoneController.text;
    await cloudAPI.createRecord(name, phone);
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
        title: const Text("Add Contact"),
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
                  validator: (value){
                    if(value == null || value.isEmpty){
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
                  child: TextFormField(
                    controller: phoneController,
                    autofocus: true,
                    maxLength: 15,
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return "Required *";
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),

                      labelText: "Phone",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                    onPressed: () async{
                      await createContact();

                      // retrieve the records first then go to next screen
                      await DisplayState().setContactRecords();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          //
                          builder: (context) => Display(),
                        ),
                      );
                    },
                    child: const Text('Create'),
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
