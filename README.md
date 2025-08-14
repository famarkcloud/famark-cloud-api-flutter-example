# famark-cloud-api-flutter-example
This is a sample code showing how to call Famark Cloud API to store and retrieve data through Flutter mobile app with Dart programming language.

## Getting Started:

### Prerequisites:
* Android Studio
* Flutter SDK: download and follow the steps for [Flutter SDK Bundle](https://docs.flutter.dev/install/manual) (it includes Dart SDK at `flutter\bin\cache\dart-sdk`)
* Famark Cloud Domain

### Setup Steps:
1. This example requires **Famark Cloud Instance**, you can [register free instance](https://www.famark.com/Install/?ic=FreeDev) or sign in to your [existing instance](https://www.famark.com/) or [*download*](https://www.famark.com/cloud/products.htm) *Famark Cloud* for *Windows* or *Linux* platforms from [famark.com/cloud/products.htm](https://www.famark.com/cloud/products.htm).
2. This example performs *Create, Retrieve, Update and Delete (CRUD)* actions on *Contact* entity present in *Business Solution*, so make sure you have the Business solution installed in your instance, if not then goto:- 
*`Solutions > more actions button [...] > Import Solution > Import From Store > Business Solution Install > Import Solution`*
3. Open Android Studio clone this repository and run `flutter pub get` in the root folder of the project.
4. Configure Flutter SDK and Dart SDK paths in Android Studio *`File > Settings > Languages & Frameworks > Dart/Flutter`*
5. Build and run the code to perform CRUD actions on `Business > Contact` entity.

*You can modify the code to perform these operations on your own entities.*

### Troubleshoot Gradle Issue
For example: `Error "Flutter BUG! exception in phase 'semantic analysis' in source unit '_BuildScript_' Unsupported class file major version (followed by a number)"`
This is because gradle version should be based on the java version installed on the machine.
Find the Java version with the command:
   ```sh
  cd C:\Program Files\Android\Android Studio\jbr\bin
  java -version
   ```
Find corresponding gradle version from the first table at [gradle compatibility matrix](https://docs.gradle.org/current/userguide/compatibility.html)

Update distributionUrl in the file:
`famark-cloud-api-flutter\android\gradle\wrapper\gradle-wrapper.properties`
   ```sh
   distributionUrl=https\://services.gradle.org/distributions/gradle-<gradle-version>-all.zip
   ```
Next modify Android Gradle Plugin (AGP) version referred as "com.android.application" in the file:
`famark-cloud-api-flutter\android\settings.gradle`
   ```sh
   plugins {
     ...
     id "com.android.application" version "<toolchain-version>" apply false
   }
   ```

If Kotlin is required for your project then find the corresponding kotlin version based on gradle version from the **second table** of the same [gradle compatibility matrix](https://docs.gradle.org/current/userguide/compatibility.html).
Add the kotlin plugin to the above mentioned `plugins` block
   ```sh
   plugins {
     ...
     id "com.android.application" version "<toolchain-version>" apply false
     id "org.jetbrains.kotlin.android" version "<kotlin-version>" apply false
   }
   ```
Also ensure that `kotin-android` is added to the plugins block in the file `famark-cloud-api-flutter\app\build.gradle`
   ```sh
   plugins {
     ...
     id "kotlin-android"
   }
   ```

## Output:

### Login Screen &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;Retrieve Contacts Screen

<img alt="ScreenShots/LoginScreen" src="ScreenShots/LoginScreen.png" width="30%">&nbsp; &nbsp; &nbsp; &nbsp;<img alt="ScreenShots/DisplayContactRecordsScreen" src="ScreenShots/DisplayContactRecordsScreen.png" width="30%">

### Create Contact Screen &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; Update Contact Screen

<img alt="ScreenShots/CreateContactScreen" src="ScreenShots/CreateContactScreen.png" width="30%">&nbsp; &nbsp; &nbsp; &nbsp;<img alt="ScreenShots/UpdateContactScreen" src="ScreenShots/UpdateContactScreen.png" width="30%">
