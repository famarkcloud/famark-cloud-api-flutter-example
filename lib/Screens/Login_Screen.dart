import 'package:flutter/material.dart';
import './Display_Contact_Records_Screen.dart';
import '../services/FamarkCloudAPI.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FamarkCloudAPI cloudAPI = FamarkCloudAPI();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController domainNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  Future<bool> validateLogin() async{
    if(!formKey.currentState!.validate()) {
      return false;
    }
    String domainName = domainNameController.text;
    String userName = userNameController.text;
    String password = passwordController.text;
    await cloudAPI.loginPost(domainName, userName, password);
    // validate error message
    if(FamarkCloudAPI.errorDisplayMessage.isNotEmpty) {
      return false;
    }
    return true;
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
                        bool validated = await validateLogin();
                        if(validated){
                          // retrieve the records first then go to next screen
                          await DisplayState().setContactRecords();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              //
                              builder: (context) => Display(),
                            ),
                          );
                        }
                        else {
                          // display error message in ui
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Container(
                                height: 90,
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                ),
                                child: Center(
                                  child: Column(
                                    children: <Widget>[
                                      Text('Oh Snap!',
                                        style: TextStyle(
                                          fontSize: 18, color: Colors.white,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(FamarkCloudAPI.errorDisplayMessage,
                                        maxLines: 2,
                                        overflow: TextOverflow.clip,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                            ),
                          );
                        }
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
