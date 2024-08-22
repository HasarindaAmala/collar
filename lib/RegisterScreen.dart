import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'FirstScreen.dart';


class RegisterScreen extends StatefulWidget {
  String id;
  bool update;
  List<String> data;
  RegisterScreen(this.id,this.update,this.data, {super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late File image;
  bool isImageUploaded = false;
  String downloadUrl = "";
  String backUrl = "";
  bool isLoading = true;
  bool uploading = false;
  String backImage = "";
  Future<bool>? profileUploaded ;
  TextEditingController usernameController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController breedController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController ownerController = TextEditingController();
  TextEditingController vaccinationNameController = TextEditingController();
  TextEditingController vaccinationDateController = TextEditingController();
  TextEditingController vaccinationNextDateController = TextEditingController();
  TextEditingController vaccinationDoseNumberController = TextEditingController();
  TextEditingController medicalHistoryController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    if(widget.update == true){
      idController.text = widget.id;
      usernameController.text = widget.data[2];
      breedController.text = widget.data[3];
      ageController.text = widget.data[4];
      weightController.text = widget.data[5];
      genderController.text = widget.data[6];
      ownerController.text = widget.data[7];
      vaccinationNameController.text = widget.data[8];
      vaccinationDateController.text = widget.data[9];
      vaccinationNextDateController.text = widget.data[10];
      vaccinationDoseNumberController.text = widget.data[11];
      medicalHistoryController.text = widget.data[12];
      downloadUrl = widget.data[0];
      backUrl = widget.data[1];
      isImageUploaded = true;

    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,

      body: Stack(
        children: [
          Container(
            width: width,
            height: height,
            child: Image.asset(
              "images/register.png",
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
              top: height * 0.05,
              left: width * 0.32,
              child: Container(
                width: width * 0.35,
                height: width * 0.35,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white24,
                  image:widget.update == true?
                  DecorationImage(image: NetworkImage(widget.data[0]))
                  :
                  isImageUploaded == true
                      ? DecorationImage(image: FileImage(image),fit: BoxFit.cover)
                      : const DecorationImage(
                    image: AssetImage(
                        "images/gray-user-profile-icon-png-fP8Q1P 1.png"),
                    fit: BoxFit.fitHeight,
                  ),
                ),
                child: isImageUploaded==false && uploading == true?
                Center(child: CircularProgressIndicator(),):Text("")
              )
          ),
          Positioned(
              top: height * 0.15,
              left: width * 0.55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF6CE04F),
                    foregroundColor: Colors.white,
                    shape: const CircleBorder()),
                onPressed: () async {
                  profileUploaded = uploadProfilePic();
                  //await uploadProfilePic();
                },
                child: Icon(Icons.add),
              )),
          Positioned(
              top: height * 0.25,
              left: width * 0.1,
              height: height * 0.6,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: width * 0.8,
                          height: height * 0.1,
                          color: Colors.transparent,
                          child: Image.asset("images/Rectangle 7.png"),
                        ),
                        Positioned(
                          left: width * 0.07,
                          top: height * 0.02,
                          width: width * 0.68,
                          height: height * 0.1,
                          child: TextFormField(
                            controller: usernameController,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                                hintText: "User Name",
                                hintStyle: TextStyle(color: Colors.white60),
                                border: InputBorder.none),
                          ),
                        )
                      ],
                    ),
                    Stack(
                      children: [
                        Container(
                          width: width * 0.8,
                          height: height * 0.1,
                          color: Colors.transparent,
                          child: Image.asset("images/Rectangle 7.png"),
                        ),
                        Positioned(
                          left: width * 0.07,
                          top: height * 0.02,
                          width: width * 0.68,
                          height: height * 0.1,
                          child: widget.update == true?TextFormField(
                            controller: idController,
                            readOnly: false,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                                hintText: "ID ( M01,M02..)",
                                hintStyle: TextStyle(color: Colors.white60),
                                border: InputBorder.none),
                          ):TextFormField(
                            initialValue: getNextId(widget.id),
                            readOnly: true,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                                hintText: "ID ( M01,M02..)",
                                hintStyle: TextStyle(color: Colors.white60),
                                border: InputBorder.none),
                          ),
                        )
                      ],
                    ),
                    Stack(
                      children: [
                        Container(
                          width: width * 0.8,
                          height: height * 0.1,
                          color: Colors.transparent,
                          child: Image.asset("images/Rectangle 7.png"),
                        ),
                        Positioned(
                          left: width * 0.07,
                          top: height * 0.02,
                          width: width * 0.68,
                          height: height * 0.1,
                          child: TextFormField(
                            controller: breedController,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                                hintText: "Breed",
                                hintStyle: TextStyle(color: Colors.white60),
                                border: InputBorder.none),
                          ),
                        )
                      ],
                    ),
                    Stack(
                      children: [
                        Container(
                          width: width * 0.8,
                          height: height * 0.1,
                          color: Colors.transparent,
                          child: Image.asset("images/Rectangle 7.png"),
                        ),
                        Positioned(
                          left: width * 0.07,
                          top: height * 0.02,
                          width: width * 0.68,
                          height: height * 0.1,
                          child: TextFormField(
                            controller: ageController,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                                hintText: "Age",
                                hintStyle: TextStyle(color: Colors.white60),
                                border: InputBorder.none),
                          ),
                        )
                      ],
                    ),
                    Stack(
                      children: [
                        Container(
                          width: width * 0.8,
                          height: height * 0.1,
                          color: Colors.transparent,
                          child: Image.asset("images/Rectangle 7.png"),
                        ),
                        Positioned(
                          left: width * 0.07,
                          top: height * 0.02,
                          width: width * 0.68,
                          height: height * 0.1,
                          child: TextFormField(
                            controller: weightController,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                                hintText: "Weight",
                                hintStyle: TextStyle(color: Colors.white60),
                                border: InputBorder.none),
                          ),
                        )
                      ],
                    ),
                    Stack(
                      children: [
                        Container(
                          width: width * 0.8,
                          height: height * 0.1,
                          color: Colors.transparent,
                          child: Image.asset("images/Rectangle 7.png"),
                        ),
                        Positioned(
                          left: width * 0.07,
                          top: height * 0.02,
                          width: width * 0.68,
                          height: height * 0.1,
                          child: TextFormField(
                            controller: genderController,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                                hintText: "Gender",
                                hintStyle: TextStyle(color: Colors.white60),
                                border: InputBorder.none),
                          ),
                        )
                      ],
                    ),
                    Stack(
                      children: [
                        Container(
                          width: width * 0.8,
                          height: height * 0.1,
                          color: Colors.transparent,
                          child: Image.asset("images/Rectangle 7.png"),
                        ),
                        Positioned(
                          left: width * 0.07,
                          top: height * 0.02,
                          width: width * 0.68,
                          height: height * 0.1,
                          child: TextFormField(
                            controller: ownerController,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                                hintText: "Owner's Name",
                                hintStyle: TextStyle(color: Colors.white60),
                                border: InputBorder.none),
                          ),
                        )
                      ],
                    ),
                    Stack(
                      children: [
                        Container(
                          width: width * 0.8,
                          height: height * 0.5,
                          color: Colors.transparent,
                          child: Image.asset("images/Rectangle 11.png"),
                        ),
                        Positioned(
                          left: width * 0.07,
                          top: height * 0.065,
                          width: width * 0.68,
                          height: height * 0.8,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Vaccination Data :",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: width * 0.04,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: height * 0.03,
                              ),
                              TextFormField(
                                controller: vaccinationNameController,
                                style: const TextStyle(color: Colors.white),
                                decoration: const InputDecoration(
                                    hintText: "Vaccine Name:",
                                    hintStyle: TextStyle(color: Colors.white60),
                                    border: InputBorder.none),
                              ),
                              TextFormField(
                                controller: vaccinationDateController,
                                style: const TextStyle(color: Colors.white),
                                decoration: const InputDecoration(
                                    hintText: "Date of Vaccination:",
                                    hintStyle: TextStyle(color: Colors.white60),
                                    border: InputBorder.none),
                              ),
                              TextFormField(
                                controller: vaccinationNextDateController,
                                style: const TextStyle(color: Colors.white),
                                decoration: const InputDecoration(
                                    hintText: "Next Due Date:",
                                    hintStyle: TextStyle(color: Colors.white60),
                                    border: InputBorder.none),
                              ),
                              TextFormField(
                                controller: vaccinationDoseNumberController,
                                style: const TextStyle(color: Colors.white),
                                decoration: const InputDecoration(
                                    hintText: "Dose Number:",
                                    hintStyle: TextStyle(color: Colors.white60),
                                    border: InputBorder.none),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Stack(
                      children: [
                        Container(
                          width: width * 0.8,
                          height: height * 0.5,
                          color: Colors.transparent,
                          child: Image.asset("images/Rectangle 11.png"),
                        ),
                        Positioned(
                          left: width * 0.07,
                          top: height * 0.065,
                          width: width * 0.68,
                          height: height * 0.8,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Medical History :",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: width * 0.04,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: height * 0.03,
                              ),
                              TextFormField(
                                controller: medicalHistoryController,
                                style: const TextStyle(color: Colors.white),
                                decoration: const InputDecoration(
                                    hintText: "Medical History:",
                                    hintStyle: TextStyle(color: Colors.white60),
                                    border: InputBorder.none),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )),
          Positioned(
              top: height * 0.88,
              left: width * 0.33,
              width: width * 0.3,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 5.0,
                  backgroundColor: Color(0xFF6CE04F),
                  foregroundColor: Colors.white,
                ),
                onPressed: () async {

                  if(usernameController.text != ""  && breedController.text != "" && ageController.text != "" && weightController.text != '' && genderController.text !="" && ownerController.text != "" && vaccinationNameController.text != "" && vaccinationDateController.text != '' && vaccinationDoseNumberController.text !="" && vaccinationNextDateController.text != "" && medicalHistoryController.text != "" && isImageUploaded == true ){
                    if(widget.update == true){
                      await updateUser(idController.text);
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Updated!"),
                            content: Text("Your profile updated !"),
                            actions: [
                              TextButton(onPressed: (){
                                setState(() {
                                  isLoading = true;
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => const FirstScreen()));

                                });
                              }, child: Text("ok"))
                            ],
                          );
                        },
                      );
                    }else{
                      await saveUser();
                      isLoading == false?
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Saved"),
                            content: Text("Your profile saved !"),
                            actions: [
                              TextButton(onPressed: (){
                                setState(() {
                                  isLoading = true;
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => const FirstScreen()));

                                });
                              }, child: Text("ok"))
                            ],
                          );
                        },
                      ): setState(() {

                      });
                    }


                  }else{
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Error"),
                          content: Text("Failed to save data. Fill all the slots!"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text("OK"),
                            ),
                          ],
                        );
                      },
                    );

                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.save),
                    widget.update == false?
                    Text(
                      " Save",
                      style: TextStyle(fontSize: width * 0.04),
                    ):Text("Update",style: TextStyle(fontSize: width * 0.035))
                  ],
                ),
              )),
          Positioned(
              top: height * 0.03,
              left: width * 0.08,
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ))),
        ],
      ),
    );
  }

  Future<bool> uploadProfilePic() async {
    try {
      setState(() {
        uploading = true;
      });
      final _picker = ImagePicker();
      final _storage = FirebaseStorage.instance;

      // Pick image from gallery
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        File imageFile = File(pickedFile.path);
        //
        // // Get current user's UID
        String uid = getNextId(widget.id);
        //
        // // Upload image to Firebase Storage
        TaskSnapshot uploadTask = await _storage
            .ref('profile_pics/$uid')
            .putFile(imageFile);
        //
        // // Get the image URL
         String downloadURL = await uploadTask.ref.getDownloadURL();
        var random = Random();
        int randomNumber = random.nextInt(2);
        if(randomNumber == 0){
           backImage = "Frame 1 (6).png";
        }else{
          backImage = "Frame 2 (3).png";
        }
        Reference ref = FirebaseStorage.instance.ref().child(backImage);

        // Get the download URL
         String fileUrl = await ref.getDownloadURL();
         downloadUrl = downloadURL;
         backUrl = fileUrl;
         print(downloadUrl);
        // // Save the URL to Firestore under the user's document

        // firebase
        //firebase above
        setState(() {
          isImageUploaded = true;
          uploading = false;
          image = File(pickedFile.path);
        });

        print("Profile picture uploaded successfully. $image");
        return true;
      } else {
        isImageUploaded = false;
        print("No image selected.");
      }
    } catch (e) {
      isImageUploaded = false;
      print("Error uploading profile picture: $e");
      return false;
    }
    return true;
  }
  String getNextId(String currentId) {
    // Extract the numeric part of the ID
    String prefix = currentId.substring(0, 1);  // Extract the "M" prefix
    String numberPart = currentId.substring(1); // Extract the numeric part

    // Parse the numeric part and increment it
    int number = int.parse(numberPart) + 1;

    // Format the number part with leading zeros (e.g., 04 instead of 4)
    String nextNumberPart = number.toString().padLeft(numberPart.length, '0');

    // Combine the prefix and the incremented number part
    return "$prefix$nextNumberPart";
  }
  Future<bool> updateUser(String userId) async {
    try {
      Map<String, dynamic> updatedAccountData = {
        'Name': usernameController.text,
        'Breed': breedController.text,
        'Age': ageController.text,
        'Weight': weightController.text,
        'Gender': genderController.text,
        'Owner': ownerController.text,
        'Vaccine Name': vaccinationNameController.text,
        'Vaccine Date': vaccinationDateController.text,
        'Vaccine Next Date': vaccinationNextDateController.text,
        'Dose number': vaccinationDoseNumberController.text,
        'Medical History': medicalHistoryController.text,
        'Image': downloadUrl,
        'Back': backUrl,
      };

      // Reference to the 'Account' collection
      CollectionReference accountCollection = FirebaseFirestore.instance.collection('Account');

      // Update the document with the specified userId
      await accountCollection.doc(userId).update(updatedAccountData);

      print("User updated successfully");
      return true;
    } catch (e) {
      print("Failed to update user: $e");
      return false;
    }
  }

  Future<bool> saveUser() async{

    String userId = getNextId(widget.id);
    Map<String,dynamic> accountData = {
      'Name': usernameController.text,
      'Id': userId,
      'Breed': breedController.text,
      'Age': ageController.text,
      'Weight': weightController.text,
      'Gender': genderController.text,
      'Owner': ownerController.text,
      'Vaccine Name': vaccinationNameController.text,
      'Vaccine Date': vaccinationDateController.text,
      'Vaccine Next Date': vaccinationNextDateController.text,
      'Dose number': vaccinationDoseNumberController.text,
      'Medical History': medicalHistoryController.text,
      'Image':downloadUrl,
      'Back': backUrl,
    };
    await addNewAccount(userId, accountData);
    setState(() {
      isLoading = false;
    });
    print("saved");
    return true;
   }
  Future<void> addNewAccount(String userId, Map<String, dynamic> accountData) async {
    // Reference to the 'account' collection
    CollectionReference accountCollection = FirebaseFirestore.instance.collection('Account');

    // Add a new document with a custom ID (userId) and data (accountData)
    await accountCollection.doc(userId).set(accountData);
  }

}
