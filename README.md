Project might require for you to upgrade/downgrade the gradle plugin.
You can upgrade/downgrade the the android gradle plugin by right clicking on the android folder and  selecting open in android studio.

Application might require for you to change your android ndk version. Android ndk version can be changed in the build.gradle file locateed at the app folder of the project

example
android {
    namespace = "com.example.hivetest1"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973" <= change ndk version here

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }
