import 'package:http/http.dart' as http;
import 'dart:convert';

class FamarkCloudAPI {
  static final _baseURL = "https://www.famark.com/host/api.svc/api";
  static String _sessionId = "";
  static String errorDisplayMessage = "";

  Future loginPost(String domainName, String userName, String password) async{
    Map<String, dynamic> credData = {
      "DomainName" : domainName,
      "UserName" : userName,
      "Password" : password
    };
    String request = json.encode(credData);
    var response = await doPost("/Credential/Connect", request);
    if(response == null) {
      return false;
    }
    _sessionId = jsonDecode(response);
    return true;
  }

  Future<List<dynamic>> retrieveRecords() async {
    Map<String, String> retrieveData = {
      "Columns": "Name, ContactType, ContactId",
      "OrderBy": "Name"
    };
    String request = json.encode(retrieveData);
    var response = await doPost("/Contact/RetrieveMultipleRecords", request);
    List<dynamic> records = jsonDecode(response!);
    return records;
  }

  Future createRecord(String name, String contactType) async{
    Map<String, String> contactData = {
      'Name': name,
      'ContactType': contactType,
    };
    String request = json.encode(contactData);
    await doPost("/Contact/CreateRecord", request);
  }

  Future updateRecords(String name, String contactType, String contactId) async{
    Map<String, String> contactData = {
      'ContactId': contactId,
      'Name': name,
      'ContactType': contactType,
    };
    String request = json.encode(contactData);
    await doPost("/Contact/UpdateRecord", request);
  }

  Future<String?> doPost(String suffixUrl, String body) async {
    Map<String,String> headers = {
      'content-type' : 'application/json; charset=UTF-8',
    };
    // Add SessionId to Header if sessionId already exists
    if (_sessionId.isNotEmpty) {
      headers.putIfAbsent("SessionId", () => _sessionId);
    }
    try {
      var client = http.Client();
      var uri = Uri.parse(_baseURL + suffixUrl);
      var response = await client.post(
        uri, body: body,
        headers: headers,
      );
      if (response.headers.containsKey("errormessage")) {
        String errorMessage = response.headers["errormessage"] as String;
        errorDisplayMessage = errorMessage;
        print("Error= " + errorDisplayMessage);
        //handle this error and show on screen
        return null;
      }
      else{
        errorDisplayMessage = "";
      }
      return response.body;
    } catch (e) {
      print("Error in try catch" + e.toString());
      return null;
    }
  }
}
