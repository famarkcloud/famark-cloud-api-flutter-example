import 'package:flutter/material.dart';
import './Create_Contact_Record_Screen.dart';
import './Update_Contact_Record_Screen.dart';
import '../services/FamarkCloudAPI.dart';

class Display extends StatefulWidget {
  const Display({Key? key}) : super(key: key);

  @override
  State<Display> createState() => DisplayState();
}

class DisplayState extends State<Display> {

  static late List<dynamic> contactRecords;
  FamarkCloudAPI cloudAPI = FamarkCloudAPI();

  Future setContactRecords() async {
    List<dynamic> retrievedRecords = await cloudAPI.retrieveRecords() as List;
    contactRecords = retrievedRecords;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contacts"),
      ),
      body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 100),
              child: Scrollbar(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: DataTable(
                    showBottomBorder: true,
                    columns: const [
                      DataColumn(label: Text('Name')),
                      DataColumn(label: Text('Contact Type')),
                      DataColumn(label: Text(''))
                    ],
                    rows: contactRecords.map(
                          (element) => DataRow(cells: <DataCell>[
                        DataCell(Text(element['FirstName'])),
                        DataCell(Text(element['ContactType'])),
                        DataCell(ElevatedButton(
                          child: const Text("Edit"),
                          onPressed: () {
                            print("Element: " + element.toString());
                            print("Runtime Type: " + element.runtimeType.toString());
                            print("First Name: " + element['FirstName']);
                            print("Contact Type: " + element['ContactType']);
                            print("ContactId : " + element['ContactId']);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UpdateContact(contactData: element),
                              ),
                            );

                          },
                        )),
                      ]),
                    )
                        .toList(),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 25,
              //right: MediaQuery.of(context).size.width / 2,
              child: ElevatedButton(
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateContactRecords(),
                    ),
                  );
                },
                child: const Text('Add Contact'),
              ),
            ),
          ]
      ),
    );
  }
}
