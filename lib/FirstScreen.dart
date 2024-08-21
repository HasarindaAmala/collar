import 'package:collar/RegisterScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gif/gif.dart';
import 'Account.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> with TickerProviderStateMixin{
   late GifController controller1;

  List<Widget> Cards = [];
@override
  void initState() {
   controller1 = GifController(vsync: this);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: width,
            height: height,
            color: Colors.blue,
          ),
          Positioned(
            top: height * 0.035,
            child: Container(
              width: width,
              height: height,
              child: Image.asset(
                "images/Frame.jpg",
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            top: height * 0.07,
            left: width * 0.8,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF353C7B).withOpacity(0.65),
                  foregroundColor: Colors.white,
                  shape: const CircleBorder()),
              child: const Icon(Icons.notification_add),
            ),
          ),
          Positioned(
            top: height * 0.52,
            left: width * 0.75,
            child: GestureDetector(
                onTap: () {
                  print("pressed");
                },
                child: Text(
                  "See All..",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: width * 0.048,
                      fontWeight: FontWeight.bold),
                )),
          ),
          Positioned(
              top: height * 0.6,
              width: width,
              child: SizedBox(
                child: FutureBuilder<List<Widget>>(
                  future: readAllUserData(width, height),
                  builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return Center(
                        child: Column(
                          children: [
                            Gif(
                              image: AssetImage("images/cow_gif.gif"),
                              controller: controller1, // if duration and fps is null, original gif fps will be used.
                              //fps: 30,
                              //duration: const Duration(seconds: 3),
                              autostart: Autostart.no,
                              placeholder: (context) => const Text('Loading...'),
                              onFetchCompleted: () {
                                controller1.reset();
                                controller1.forward();
                              },
                            ),

                            //Text("Data fetching from the Database...",style: TextStyle(color: Colors.white,fontSize: width*0.04),)
                          ],
                        ),
                      );

                    }
                    else if(snapshot.hasData){
                      return CarouselSlider(
                        items: snapshot.data,

                        options: CarouselOptions(
                          viewportFraction: 0.4,
                          // onPageChanged: (index, reason) {
                          //   setState(() {
                          //     _currentIndex = index;
                          //   });
                          //   print("Current index: $_currentIndex");
                          // },
                          // Set the desired options for the carousel
                          height: height * 0.25,
                          enlargeFactor: 0.3, // Set the height of the carousel
                          autoPlay: false,
                          enlargeCenterPage: true, // Enable auto-play
                          autoPlayCurve: Curves.easeInOut, // Set the auto-play curve
                          autoPlayAnimationDuration: const Duration(
                              milliseconds: 500), // Set the auto-play animation duration
                          // Set the aspect ratio of each item
                          // You can also customize other options such as enlargeCenterPage, enableInfiniteScroll, etc.
                        ),
                      );
                    }else{
                      return Text("no data");
                    }

                  }
                ),
              )),
          Positioned(
              top: height * 0.9,
              child: Container(
                width: width,
                height: height * 0.1,
                color: const Color(0xFF304178),
              )),
          Positioned(
              top: height * 0.87,
              left: width * 0.4,
              child: ElevatedButton(
                onPressed: () async{
                  FirebaseFirestore firestore = FirebaseFirestore.instance;
                  // Check if the username or phone number already exists
                  CollectionReference id_total = await firestore.collection('Account');
                  QuerySnapshot total_num = await id_total.get();
                  DocumentSnapshot last = await total_num.docs.last;
                  String id = last.id;
                  print("pressed");
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> RegisterScreen(id)));
                },
                style: ElevatedButton.styleFrom(
                  overlayColor: Colors.blue,
                  alignment: Alignment.center,
                  side: const BorderSide(width: 5.0, color: Color(0xFF19A3C2)),
                  shape: const CircleBorder(),
                  backgroundColor: const Color(0xFF6CE04F),
                  foregroundColor: Colors.white,
                  fixedSize: Size(width * 0.2, width * 0.2),
                ),
                child: null,
              )),
          Positioned(
              top: height * 0.884,
              left: width * 0.425,
              child: GestureDetector(
                onTap: () async{
                  FirebaseFirestore firestore = FirebaseFirestore.instance;
                  // Check if the username or phone number already exists
                  CollectionReference id_total = await firestore.collection('Account');
                  QuerySnapshot total_num = await id_total.get();
                  DocumentSnapshot last = await total_num.docs.last;
                  String id = last.id;
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> RegisterScreen(id)));
                },
                child: Icon(
                  Icons.add,
                  size: width * 0.15,
                  color: Colors.white,
                ),
              )),
          Positioned(
            top: height*0.92,
              left: width*0.05,
              child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon:  Icon(
                    size: width*0.08,
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  )),
              SizedBox(width: width*0.035,),
              IconButton(
                  onPressed: () {},
                  icon:  Icon(
                    size: width*0.08,
                    Icons.file_copy_outlined,
                    color: Colors.white,
                  )),
              SizedBox(width: width*0.33,),
              IconButton(
                  onPressed: () {},
                  icon:  Icon(
                    Icons.account_circle_rounded,
                    color: Colors.white,
                    size: width*0.09,
                  )),
              SizedBox(width: width*0.04,),
              IconButton(
                  onPressed: () async {
                    // await writeUserData("M02", {
                    //   "name": "John Doe",
                    //   "email": "john.doe@example.com",
                    //   "age": 30,
                    // });
                    print(await readAllUserData(width,height));

                  },
                  icon: Icon(
                    size: width*0.09,
                    Icons.settings,
                    color: Colors.white,
                  )),
            ],
          ))
        ],
      ),
    );
  }
  Future<List<Widget>> readAllUserData(double width,double height) async {
    Cards.clear();
    try {
      // Reference to the Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Get all documents from the 'Account' collection
      QuerySnapshot querySnapshot = await firestore.collection('Account').get();

      for (var doc in querySnapshot.docs) {
        print("Document ID: ${doc.id}");
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        print("data: ${data['Age']}");
        print("data: ${data['Breed']}");

        // Safely retrieve data with fallback values
        String imageUrl = data['Image'] ?? '';
        String name = data['Name'] ?? '';// Provide a fallback if Image is null
        String imageBackUrl = data['Back'] ?? '';
        String age = data['Age'] ?? "0"; // Default to 0 if Age is null
        String breed = data['Breed'] ?? 'Unknown Breed';
        String Gender = data['Gender'] ?? ''; // Default to 'Unknown Breed' if null

        Cards.add(
          SizedBox(
            width: width * 0.35,
            child: GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AccountScreen(doc.id,imageUrl,name,age,breed,Gender)));
              },
              child: Container(
                child: Stack(
                  children: [
                    SizedBox(
                        width: width * 0.35,
                        child: Image.network(imageBackUrl),),
                    Padding(
                      padding: EdgeInsets.only(
                          left: width * 0.03, top: height * 0.015),
                      child: Text(
                        name,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: width * 0.04),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: height * 0.073),
                      child: Image.network(imageUrl),
                      //Image.asset("images/brown.png"),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: height * 0.04, left: width * 0.03),
                      child: Text(
                        "$age yrs $breed Moo",
                        style: const TextStyle(
                            color: Colors.white60,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

        );
       // print(imageUrl);

      }
      // Extract data from each document and add it to a list
      // List<Map<String, dynamic>> allData = querySnapshot.docs.map((doc) {
      //   return doc.data() as Map<String, dynamic>;
      // }).toList();
      //
      // return allData;
      print(Cards.first);
      return Cards;
    } catch (e) {
      print("Error reading data: $e");
      return [];
    }
  }

  Future<void> writeUserData(String userId, Map<String, dynamic> data) async {
    try {
      // Reference to the Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Write data to Firestore under the specific user ID
      await firestore.collection('Account').doc(userId).set(data);

      print("Data written successfully");
    } catch (e) {
      print("Error writing data: $e");
    }
  }
}
