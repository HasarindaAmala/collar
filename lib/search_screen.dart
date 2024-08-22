import 'dart:async';

import 'package:collar/FirstScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Account.dart';
import 'main.dart';

class searchScreen extends StatefulWidget {
  const searchScreen({super.key});

  @override
  State<searchScreen> createState() => _searchScreenState();
}

class _searchScreenState extends State<searchScreen> {
  TextEditingController SearchController = TextEditingController();
  late StreamController searchController;
  List<Widget> Cards = [];
  String search_term = "";
  String name= "";
  String age = "";
  String breed = "";
  List<String> data_list = [];

  void refresh(){
    setState(() {

    });
  }


  @override
  void initState() {

    // TODO: implement initState
    searchController = StreamController.broadcast();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: width,
        height: height,
        child: Stack(
          children: [
            Positioned(
              child: Container(
                width: width,
                height: height,
                child: Image.asset(
                  "images/Frame (2).png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
                top: height * 0.05,
                left: width*0.02,
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const FirstScreen()));
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ))),
            Positioned(
              top: height * 0.15,
              left: width * 0.05,
              child: Container(
                width: width * 0.9,
                height: height * 0.08,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(width * 0.04),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: width * 0.03,
                    ),
                    SizedBox(
                      width: width * 0.7,
                      child: TextField(
                        controller: SearchController,
                        decoration:
                        const InputDecoration(hintText: "Search Moos Here.."),
                        onChanged: (value){
                          search_term = value;
                          searchController.sink.add(value);
                          print(search_term);
                        },
                      ),
                    ),
                    IconButton(
                        onPressed: () async {
                          //await readAllUserData();
                        }, icon: const Icon(Icons.search)),
                  ],
                ),
              ),
            ),
            Positioned(
              top: height*0.25,
              left: width*0.05,
              width: width*0.9,
              child: SizedBox(
                  width: width,
                  height: height*0.7,
                  child: StreamBuilder(stream: searchController.stream, builder: (context,snap){
                    if(snap.hasData && snap.data != ""){
                      return FutureBuilder(
                        future: readSearchData(width, height, snap.data),
                        builder: (context,snapshot){
                          if(snapshot.connectionState == ConnectionState.waiting){
                            return Center(
                              child: SizedBox(
                                  width: width*0.5,
                                  height: width*0.5,
                                  child: CircularProgressIndicator()),
                            );
                          }else if(snapshot.hasData){
                            return ListView(
                              children:  Cards,
                            );
                          }else{
                            return const Text("Connection error");
                          }
                        },

                      );
                    }else{
                      Cards.clear();
                      return FutureBuilder(
                        future: readAllUserData(width, height),
                        builder: (context,snapshot){
                          if(snapshot.connectionState == ConnectionState.waiting){
                            return Center(
                              child: SizedBox(
                                  width: width*0.5,
                                  height: width*0.5,
                                  child: CircularProgressIndicator()),
                            );
                          }else if(snapshot.hasData){
                            return ListView(
                              children:  Cards,
                            );
                          }else{
                            return const Text("Connection error");
                          }
                        },

                      );
                    }
                  })


              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<List<Widget>> readAllUserData(double width, double height) async {
    Cards.clear();
    int i = 0;
    try {
      // Reference to the Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Get all documents from the 'Account' collection
      QuerySnapshot querySnapshot = await firestore.collection('Account').get();
      Cards.clear();
      for (var doc in querySnapshot.docs) {

        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

          name = data['Name'] ?? '';// Provide a fallback if Image is null
         age = data['Age'] ?? "0"; // Default to 0 if Age is null
         breed = data['Breed'] ?? 'Unknown Breed';




        String imageBackUrl = data['Back'] ?? '';
        String weight = data['Weight'] ?? '';
        String Gender = data['Gender'] ?? '';
        String Dose = data['Dose Number'] ?? '';
        String imageUrl = data['Image'] ?? '';
        String Owner = data['Owner'] ?? '';
        String VaccineName = data['Vaccine Name'] ?? '';
        String VaccineDate = data['Vaccine Date'] ?? '';
        String NextDate = data['Vaccine Next Date'] ?? '';
        String MedicalHistory = data['Medical History'] ?? '';
        // print("data: ${data['Breed']}");



        Cards.add(
          //  ListTile(
          //  title: Text(doc.id,style: const TextStyle(color: Colors.white),),
          //    tileColor: Colors.white,
          // ),
          Column(
            children: [
              GestureDetector(
                onTap: (){
                  data_list = [imageUrl,imageBackUrl,name,breed,age,weight,Gender,Owner,VaccineName,VaccineDate,NextDate,Dose,MedicalHistory];
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AccountScreen(doc.id,imageUrl,name,age,breed,Gender,data_list)));
                  print(doc.id);
                },
                child: Container(
                  width: width*0.9,
                  height: height*0.12,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(width*0.05),
                  ),

                  child: Padding(
                    padding:  EdgeInsets.only(left: width*0.04,top: height*0.01),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${name} ( ${doc.id} )",style: TextStyle(color: Colors.white,fontSize: width*0.05),),

                            Padding(
                              padding: EdgeInsets.only(right: width*0.01,),
                              child: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios_outlined,color: Colors.white,)),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text("Breed: $breed ",style: TextStyle(color: Colors.white60,fontSize: width*0.04),),
                            Text("Age: $age ",style: TextStyle(color: Colors.white60,fontSize: width*0.04),),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height*0.01,

              ),
            ],
          ),


        );


      }
      // Extract data from each document and add it to a list
      // List<Map<String, dynamic>> allData = querySnapshot.docs.map((doc) {
      //   return doc.data() as Map<String, dynamic>;
      // }).toList();
      //
      // return allData;
      //print(Cards.first);
      return Cards;
    } catch (e) {
      print("Error reading data: $e");
      return [];
    }
  }
  Future<List<Widget>> readSearchData(double width, double height, String value) async {
    Cards.clear();
    int i =0;
    try {
      // Reference to the Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Get all documents from the 'Domains' collection
      QuerySnapshot querySnapshot = await firestore.collection('Account').get();

      // Iterate through the documents and filter by the search term (value)
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        name = data['Name'] ?? '';// Provide a fallback if Image is null
        age = data['Age'] ?? "0"; // Default to 0 if Age is null
        breed = data['Breed'] ?? 'Unknown Breed';
        String imageUrl = data['Image'] ?? '';
        String imageBackUrl = data['Back'] ?? '';
        String weight = data['Weight'] ?? '';
        String Gender = data['Gender'] ?? '';
        String Dose = data['Dose Number'] ?? '';
        String Owner = data['Owner'] ?? '';
        String VaccineName = data['Vaccine Name'] ?? '';
        String VaccineDate = data['Vaccine Date'] ?? '';
        String NextDate = data['Vaccine Next Date'] ?? '';
        String MedicalHistory = data['Medical History'] ?? '';
        i++;
        print(i);
        String documentId = name.toLowerCase();  // Convert to lowercase for case-insensitive search
        String searchTerm = value.toLowerCase();   // Ensure search term is also lowercase
        print(documentId);

        // Only add documents that contain the search term
        if (documentId.contains(searchTerm)) {
          Cards.clear();
          Cards.add(
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    data_list = [imageUrl,imageBackUrl,name,breed,age,weight,Gender,Owner,VaccineName,VaccineDate,NextDate,Dose,MedicalHistory];
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AccountScreen(doc.id,imageUrl,name,age,breed,Gender,data_list)));
                    print(doc.id);
                    //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Namescreen(domain: doc.id)));
                  },
                  child: Container(
                    width: width * 0.9,
                    height: height * 0.1,
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(width * 0.05),
                    ),
                    child: Padding(
                      padding:  EdgeInsets.only(left: width*0.04,top: height*0.01),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${name} ( ${doc.id} )",style: TextStyle(color: Colors.white,fontSize: width*0.05),),

                              Padding(
                                padding: EdgeInsets.only(right: width*0.01,),
                                child: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios_outlined,color: Colors.white,)),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text("Breed: $breed   ",style: TextStyle(color: Colors.white60,fontSize: width*0.04),),
                              Text("  Age: $age ",style: TextStyle(color: Colors.white60,fontSize: width*0.04),),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.01),
              ],
            ),
          );
        }
      }

      // If no matches are found, you can add a message or handle it differently
      if (Cards.isEmpty) {
        Cards.add(
          Center(
            child: Text(
              'No results found',
              style: TextStyle(color: Colors.white, fontSize: width * 0.05),
            ),
          ),
        );
      }

      return Cards;
    } catch (e) {
      print("Error reading data: $e");
      return [];
    }
  }



}
