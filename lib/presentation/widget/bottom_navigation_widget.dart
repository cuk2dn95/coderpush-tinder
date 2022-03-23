import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation(
      this._onLikedListTap,
      this._onSecondLookTap,
      {
    Key? key,
  }) : super(key: key);

  final GestureTapCallback _onLikedListTap;
  final GestureTapCallback _onSecondLookTap;

  @override
  Widget build(BuildContext context) => Container(
      color: Colors.white,
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewPadding.bottom),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: _onSecondLookTap,
              child:
          Row(children: const[
            SizedBox(
              height: 65,
              width: 65,
              child:  Center(
                  child: Icon(
                    Icons.favorite_border,
                    color: Colors.grey,
                    size: 25,
                  )),
            ),
            Text('Second Look')
          ],),

            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: _onLikedListTap,
              child:
              Row(children: const[
                 SizedBox(
                  height: 65,
                  width: 65,
                  child: Center(
                      child: Icon(
                        Icons.favorite,
                        color: Colors.grey,
                        size: 25,
                      )),
                ),
                Text('Liked List')
              ],)

            ),
          )
        ],
      ),
    );
}