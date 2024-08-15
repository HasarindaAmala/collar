import 'dart:async';
import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

late StreamController slideController;
List<double> vibrationData1 = [0, 3, 1.5, 4, 2, 2.5, 3.5];

class AccountScreen extends StatefulWidget {
  final String id;
  final String imageUrl;
  final String name;
  final String age;
  final String breed;
  final String gender;
  const AccountScreen(
      this.id, this.imageUrl, this.name, this.age, this.breed, this.gender,
      {super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {

  List<FlSpot> createSpots(List<double> data) {
    return List.generate(
        data.length, (index) => FlSpot(index.toDouble(), data[index]));
  }
  List<FlSpot> spots = [];
  double xValue = 0;
  Timer? timer;
  Random random = Random();
  
  @override
  void initState() {
    // TODO: implement initState
    slideController = StreamController.broadcast();
    startUpdatingGraph();
    super.initState();
  }
  void startUpdatingGraph() {
    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        xValue += 1;
        double yValue = getRandomYValue();
        spots.add(FlSpot(xValue, yValue));

        // Keep only the last 20 spots to simulate real-time effect
        if (spots.length > 18) {
          spots.removeAt(0);
        }
      });
    });
  }

  double getRandomYValue() {
    // You can replace this with actual real-time data
    double randomInRange = random.nextDouble() * 15;
    return randomInRange;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0.0,
            child: Container(
                width: width,
                height: height * 0.6,
                color: const Color(0xFF304178),
                child: Positioned(
                    child: Stack(
                  children: [
                    Positioned(
                        top: -height * 0.03,
                        left: -width * 0.1,
                        child: SizedBox(
                            width: width * 0.45,
                            child: Image.asset(
                              "images/Ellipse 2 (2).png",
                            ))),
                    Positioned(
                        top: height * 0.15,
                        left: width * 0.16,
                        child: SizedBox(
                            width: width,
                            child: Image.asset(
                              "images/Ellipse 2 (2).png",
                            ))),
                    Positioned(
                        top: height * 0.19,
                        left: width * 0.36,
                        child: SizedBox(
                            width: width * 0.75,
                            child: Image.asset(
                              "images/vector-cow-Png.png",
                            ))),
                    Positioned(
                      top: height * 0.038,
                      left: width * 0.48,
                      child: Text(
                        widget.name,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: width * 0.14,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Positioned(
                      top: height * 0.18,
                      left: width * 0.05,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.age.toUpperCase(),
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: width * 0.11,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          Text(
                            widget.breed.toUpperCase(),
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: width * 0.1,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: height * 0.04,
                          ),
                          Text(
                            widget.gender.toUpperCase(),
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: width * 0.1,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: height * 0.24,
                      left: width * 0.05,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "age",
                            style: TextStyle(
                                color: Colors.white60,
                                fontSize: width * 0.05,
                                fontWeight: FontWeight.normal),
                          ),
                          SizedBox(
                            height: height * 0.07,
                          ),
                          Text(
                            "Breed",
                            style: TextStyle(
                                color: Colors.white60,
                                fontSize: width * 0.05,
                                fontWeight: FontWeight.normal),
                          ),
                          SizedBox(
                            height: height * 0.073,
                          ),
                          Text(
                            "Gender",
                            style: TextStyle(
                                color: Colors.white60,
                                fontSize: width * 0.05,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                        top: height * 0.05,
                        left: width * 0.03,
                        child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: width * 0.09,
                          ),
                        ))
                  ],
                ))),
          ),
          StreamBuilder(
              stream: slideController.stream,
              initialData: false,
              builder: (context, snapshot) {
                if (snapshot.data == true) {
                  return AnimatedPositioned(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    top: 0.0,
                    child: GestureDetector(
                      onVerticalDragUpdate: (details) {
                        if (details.primaryDelta! > 7) {
                          slideController.sink.add(false);
                        }
                        print(details.primaryDelta);
                      },
                      child: Container(
                        width: width,
                        height: height,
                        decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(width * 0.09))),
                        child: Stack(
                          children: [
                            SizedBox(width: width,height: height*0.2,),
                            Positioned(
                                top: height * 0.08,
                                left: width * 0.07,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: width * 0.42,
                                      child:
                                      Image.asset("images/Rectangle 9.png"),
                                    ),
                                    SizedBox(
                                      width: width * 0.04,
                                    ),
                                    SizedBox(
                                      width: width * 0.42,
                                      child:
                                      Image.asset("images/Rectangle 9.png"),
                                    ),
                                  ],
                                )),
                            Positioned(
                                top: height * 0.03,
                                left: width * 0.25,
                                child: SizedBox(
                                    width: width * 0.35,
                                    child: Image.asset(
                                        "images/human-heart-poster.png"))),
                            Positioned(
                                top: height * 0.047,
                                left: width * 0.75,
                                child: SizedBox(
                                    width: width * 0.28,
                                    child: Image.asset("images/2387835.png"))),
                            Positioned(
                                top: height * 0.09,
                                left: width * 0.1,
                                child: SizedBox(
                                    width: width * 0.35,
                                    child: Text(
                                      "88",
                                      style: TextStyle(
                                          color: Colors.white60,
                                          fontSize: width * 0.2,
                                          fontWeight: FontWeight.bold),
                                    ))),
                            Positioned(
                                top: height * 0.19,
                                left: width * 0.1,
                                child: SizedBox(
                                    width: width * 0.35,
                                    child: Text(
                                      "BPM",
                                      style: TextStyle(
                                          color: Colors.white60,
                                          fontSize: width * 0.12,
                                          fontWeight: FontWeight.bold),
                                    ))),
                            Positioned(
                                top: height * 0.047,
                                left: width * 0.75,
                                child: SizedBox(
                                    width: width * 0.28,
                                    child: Image.asset("images/2387835.png"))),
                            Positioned(
                                top: height * 0.12,
                                left: width * 0.57,
                                child: SizedBox(
                                    width: width * 0.35,
                                    child: Text(
                                      "312",
                                      style: TextStyle(
                                          color: Colors.white60,
                                          fontSize: width * 0.13,
                                          fontWeight: FontWeight.bold),
                                    ))),
                            Positioned(
                                top: height * 0.19,
                                left: width * 0.57,
                                child: SizedBox(
                                    width: width * 0.35,
                                    child: Text(
                                      "K",
                                      style: TextStyle(
                                          color: Colors.white60,
                                          fontSize: width * 0.12,
                                          fontWeight: FontWeight.bold),
                                    ))),
                            Positioned(
                                top: height * 0.32,
                                left: width * 0.07,
                                child: Row(
                                  children: [
                                    Text("Movements:",style: TextStyle(
                                        fontSize: width*0.06,
                                        color: Colors.white
                                    ),),
                                    Text("  Active",style: TextStyle(
                                        fontSize: width*0.06,
                                        color: Colors.lightGreenAccent,
                                        fontWeight: FontWeight.bold
                                    ),),
                                  ],
                                )),
                            Positioned(
                              top: height*0.4,
                                left: width*0.05,

                                child:
                            SizedBox(
                              width: width*0.9,
                              height: height*0.3,
                              child: LineChart(
                                LineChartData(
                                  minY: 0.0,
                                  maxY: 20,
                                  backgroundColor: Colors.transparent,
                                  borderData: FlBorderData(
                                    show: true,
                                    border: Border.all(
                                      color: Colors.white60, // Border color (including axis lines)
                                      width: 2,
                                    ),
                                  ),
                                  gridData: const FlGridData(
                                    show: true
                                  ),
                                  lineBarsData: [

                                    LineChartBarData(
                                      spots: spots,
                                      isCurved: true,
                                      color: Colors.pink,
                                      dotData: const FlDotData(show: true),
                                    ),
                                  ],
                                  titlesData: FlTitlesData(
                                    leftTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        getTitlesWidget: (value, meta) {
                                          return Text(
                                            value.toString(),
                                            style: const TextStyle(
                                              color: Colors.white, // Change the left axis labels to white
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    bottomTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: false,
                                        getTitlesWidget: (value, meta) {
                                          return Text(
                                            value.toString(),
                                            style: const TextStyle(
                                              color: Colors.white, // Change the bottom axis labels to white
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    topTitles: const AxisTitles(
                                      sideTitles: SideTitles(showTitles: false),
                                    ),
                                    rightTitles: const AxisTitles(
                                      sideTitles: SideTitles(showTitles: false),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            ),
                            
                            Positioned(
                              top: height*0.75,
                                left: width*0.05,
                                child: SizedBox(
                                  width: width*0.9,
                                  child: const Center(
                                    child: Text("The average resting heart rate of a cow is typically"
                                        " between 48 to 84 beats per minute (bpm)."
                                        "The average body temperature of a cow is approximately 101.5°F (38.6°C), "
                                        "which is 311.75 K in Kelvin.",style: TextStyle(color: Colors.white),),
                                  ),
                                )
                            ),
                            Positioned(
                                top: height*0.825,
                                left: width*0.32,
                                child: SizedBox(
                                  width: width*0.9,
                                  child:  Center(
                                    child: GestureDetector(
                                      onTap: (){
                                         print("Print report");
                                      },
                                        child: const Text("Print Report",style: TextStyle(color: Color(0xFF304178),fontWeight: FontWeight.bold,decoration: TextDecoration.underline),)),
                                  ),
                                )
                            ),

                            Positioned(
                              top: height*0.88,
                              left: width*0.17,
                              child: Row(
                                children: [
                                  ElevatedButton(onPressed: (){},
                                    style: ElevatedButton.styleFrom(
                                        fixedSize: Size(width*0.32, height*0.04),
                                        backgroundColor: const Color(0xFF6CE04F),
                                        foregroundColor: Colors.white,
                                        elevation: width*0.01
                                    ), child: Row(
                                      children: [
                                        const Icon(Icons.update),
                                        SizedBox(width: width*0.015,),
                                        const Text("Update"),
                                      ],
                                    ),),
                                  SizedBox(
                                    width: width*0.04,
                                  ),
                                  ElevatedButton(onPressed: (){},
                                    style: ElevatedButton.styleFrom(
                                        fixedSize: Size(width*0.32, height*0.055),
                                        backgroundColor: const Color(0xFF304178),
                                        foregroundColor: Colors.white,
                                        elevation: width*0.01
                                    ), child: Row(
                                      children: [
                                        const Icon(Icons.delete),
                                        SizedBox(width: width*0.015,),
                                        const Text("Delete"),
                                      ],
                                    ),),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  );
                } else if (snapshot.data == false) {
                  return AnimatedPositioned(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    top: height * 0.55,
                    child: GestureDetector(
                      onVerticalDragUpdate: (details) {
                        if (details.primaryDelta! < -7) {
                          slideController.sink.add(true);
                        }
                        print(details.primaryDelta);
                      },
                      child: Container(
                        width: width,
                        height: height,
                        decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(width * 0.09))),
                        child: Stack(
                          children: [
                            Positioned(
                                top: height * 0.04,
                                left: width * 0.07,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: width * 0.42,
                                      child:
                                          Image.asset("images/Rectangle 9.png"),
                                    ),
                                    SizedBox(
                                      width: width * 0.04,
                                    ),
                                    SizedBox(
                                      width: width * 0.42,
                                      child:
                                          Image.asset("images/Rectangle 9.png"),
                                    ),
                                  ],
                                )),
                            Positioned(
                                top: -height * 0.01,
                                left: width * 0.25,
                                child: SizedBox(
                                    width: width * 0.35,
                                    child: Image.asset(
                                        "images/human-heart-poster.png"))),
                            Positioned(
                                top: height * 0.007,
                                left: width * 0.75,
                                child: SizedBox(
                                    width: width * 0.28,
                                    child: Image.asset("images/2387835.png"))),
                            Positioned(
                                top: height * 0.05,
                                left: width * 0.1,
                                child: SizedBox(
                                    width: width * 0.35,
                                    child: Text(
                                      "88",
                                      style: TextStyle(
                                          color: Colors.white60,
                                          fontSize: width * 0.2,
                                          fontWeight: FontWeight.bold),
                                    ))),
                            Positioned(
                                top: height * 0.15,
                                left: width * 0.1,
                                child: SizedBox(
                                    width: width * 0.35,
                                    child: Text(
                                      "BPM",
                                      style: TextStyle(
                                          color: Colors.white60,
                                          fontSize: width * 0.12,
                                          fontWeight: FontWeight.bold),
                                    ))),
                            Positioned(
                                top: height * 0.007,
                                left: width * 0.75,
                                child: SizedBox(
                                    width: width * 0.28,
                                    child: Image.asset("images/2387835.png"))),
                            Positioned(
                                top: height * 0.08,
                                left: width * 0.57,
                                child: SizedBox(
                                    width: width * 0.35,
                                    child: Text(
                                      "312",
                                      style: TextStyle(
                                          color: Colors.white60,
                                          fontSize: width * 0.13,
                                          fontWeight: FontWeight.bold),
                                    ))),
                            Positioned(
                                top: height * 0.15,
                                left: width * 0.57,
                                child: SizedBox(
                                    width: width * 0.35,
                                    child: Text(
                                      "K",
                                      style: TextStyle(
                                          color: Colors.white60,
                                          fontSize: width * 0.12,
                                          fontWeight: FontWeight.bold),
                                    ))),
                             Positioned(
                                 top: height * 0.27,
                                 left: width * 0.07,
                                child: Row(
                              children: [
                                Text("Movements:",style: TextStyle(
                                  fontSize: width*0.06,
                                  color: Colors.white
                                ),),
                                Text("  Active",style: TextStyle(
                                    fontSize: width*0.06,
                                  color: Colors.lightGreenAccent,
                                  fontWeight: FontWeight.bold
                                ),),
                              ],
                            )),
                            Positioned(
                              top: height*0.34,
                                left: width*0.17,
                                child: Row(
                                  children: [
                                    ElevatedButton(onPressed: (){},
                                      style: ElevatedButton.styleFrom(
                                        fixedSize: Size(width*0.32, height*0.04),
                                        backgroundColor: const Color(0xFF6CE04F),
                                        foregroundColor: Colors.white,
                                          elevation: width*0.01
                                      ), child: Row(
                                      children: [
                                        const Icon(Icons.update),
                                        SizedBox(width: width*0.015,),
                                        const Text("Update"),
                                      ],
                                    ),),
                                    SizedBox(
                                      width: width*0.04,
                                    ),
                                    ElevatedButton(onPressed: (){},
                                    style: ElevatedButton.styleFrom(
                                      fixedSize: Size(width*0.32, height*0.055),
                                      backgroundColor: const Color(0xFF304178),
                                      foregroundColor: Colors.white,
                                      elevation: width*0.01
                                    ), child: Row(
                                      children: [
                                        const Icon(Icons.delete),
                                        SizedBox(width: width*0.015,),
                                        const Text("Delete"),
                                      ],
                                    ),),
                                  ],
                                ),
                            ),
                            
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return const Text("No Connection");
                }
              }),
        ],
      ),
    );
  }
}
