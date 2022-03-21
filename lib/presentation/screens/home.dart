import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.replay, color: Colors.yellow),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.close, color: Colors.red),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.star, color: Colors.blue),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.favorite, color: Colors.green),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.flash_on, color: Colors.purple),
                      ),
                    ],
                  ),
              )
            ],
          ),
        ),


        bottomNavigationBar: Container(
          color: Colors.white,
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewPadding.bottom),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                child: SizedBox(
                  height: 65,
                  width: 65,
                  child: Stack(
                    children: [
                      Positioned(
                          top: 4,
                          right: 4,
                          child: Container(
                            height: 18,
                            width: 18,
                            child: Center(
                                child: Text(
                              '12',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10),
                            )),
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.amberAccent),
                          )),
                      Center(
                          child: Icon(
                        Icons.favorite,
                        color: Colors.grey,
                        size: 25,
                      ))
                    ],
                  ),
                ),
              ),

              GestureDetector(
                child: SizedBox(
                  height: 65,
                  width: 65,
                  child: Center(
                      child: Icon(
                        Icons.favorite_border,
                        color: Colors.grey,
                        size: 25,
                      )),
                ),
              )
            ],
          ),
        ),
      );
}
