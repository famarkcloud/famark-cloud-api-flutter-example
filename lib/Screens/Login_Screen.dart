import 'package:flutter/material.dart';
import './Display_Contact_Records_Screen.dart';
import '../services/FamarkCloudAPI.dart';

class LoginPage extends StatelessWidget {
  FamarkCloudAPI cloudAPI = FamarkCloudAPI();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController domainNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future validateLogin() async{
    if(!formKey.currentState!.validate()) {
      return;
    }
    String domainName = domainNameController.text;
    String userName = userNameController.text;
    String password = passwordController.text;
    await cloudAPI.loginPost(domainName, userName, password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Padding(
        padding: const EdgeInsets.all(25),
        child: Center(
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: domainNameController,
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
                    labelText: "Domain Name",
                  ),
                ),
                TextFormField(
                  controller: userNameController,
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

                    labelText: "User Name",
                  ),
                ),

                TextFormField(
                  obscureText: true,
                  controller: passwordController,
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
                    labelText: "Password",
                  ),
                ),

                Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                      onPressed: () async{
                        await validateLogin();

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
                      child: const Text('Login'),
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