import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
                child: Image.asset("images/Ellipse 9.png"),
              )),
          Positioned(
              top: height * 0.15,
              left: width * 0.55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF6CE04F),
                    foregroundColor: Colors.white,
                    shape: const CircleBorder()),
                onPressed: () {},
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
                          child: TextFormField(
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
                              SizedBox(height: height*0.03,),
                              TextFormField(
                                style: const TextStyle(color: Colors.white),
                                decoration: const InputDecoration(

                                    hintText: "Vaccine Name:",
                                    hintStyle: TextStyle(color: Colors.white60),
                                    border: InputBorder.none),
                              ),
                              TextFormField(
                                style: const TextStyle(color: Colors.white),
                                decoration: const InputDecoration(
                                    hintText: "Date of Vaccination:",
                                    hintStyle: TextStyle(color: Colors.white60),
                                    border: InputBorder.none),
                              ),
                              TextFormField(
                                style: const TextStyle(color: Colors.white),
                                decoration: const InputDecoration(
                                    hintText: "Next Due Date:",
                                    hintStyle: TextStyle(color: Colors.white60),
                                    border: InputBorder.none),
                              ),
                              TextFormField(
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
                              SizedBox(height: height*0.03,),
                              TextFormField(
                                maxLines: 5,
                                style: const TextStyle(color: Colors.white),
                                decoration: const InputDecoration(
                                    hintText: "Add medical history here:",
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
            top: height*0.88,
            left: width*0.33,
            width: width*0.3,
              child: ElevatedButton(

                style: ElevatedButton.styleFrom(
                  elevation: 5.0,
                  backgroundColor: Color(0xFF6CE04F),
                  foregroundColor: Colors.white,
                ),
                onPressed: () {},
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.save),
                    Text(" Save",style: TextStyle(fontSize: width*0.04),)
                  ],
                ),
              )),
          Positioned(
              top: height * 0.03,
              left: width * 0.08,
              child: IconButton(onPressed: (){
                Navigator.of(context).pop();
              }, icon: Icon(Icons.arrow_back_ios,color: Colors.white,))),
        ],
      ),
    );
  }
}
