import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                        child: const  Center(
                            child: Text(
                              '12',
                              style:
                              TextStyle(color: Colors.white, fontSize: 10),
                            )),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.amberAccent),
                      )),
                  const Center(
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
            child: const SizedBox(
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
    );
  }
}