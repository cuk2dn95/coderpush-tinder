import 'package:coderpush_tinder/config/di.dart';
import 'package:coderpush_tinder/presentation/viewmodel/home_viewmodel.dart';
import 'package:flutter/material.dart';
import '../widget/bottom_navigation_widget.dart';
import '../widget/tinder_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeViewModel viewmodel = Injector.homeViewModel();

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Positioned.fill(
                  child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: LayoutBuilder(
                    builder: (context, BoxConstraints contrainst) {
                  return TinderSwapCard(
                    cardBuilder: (BuildContext context, int index) => ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Stack(
                        children: [
                          Positioned.fill(
                              child: Container(
                            decoration: const BoxDecoration(
                                color: Colors.lightBlueAccent),
                          )),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: LayoutBuilder(
                                builder: (BuildContext context,
                                        BoxConstraints constraints) =>
                                    Container(
                                      height: constraints.maxHeight / 3,
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                            Colors.black.withOpacity(0.01),
                                            Colors.black
                                          ],
                                              stops: const <double>[
                                            0,
                                            0.6
                                          ])),
                                    )),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              //total of height of bottom icon + padding (60)
                              padding: const EdgeInsets.only(
                                  bottom: 65 + 16 + 60, left: 16, right: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          'Ha XuNa',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline3!
                                              .copyWith(color: Colors.white),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Text('24',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline3!
                                                .copyWith(color: Colors.white)),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    totalNum: 15,
                    maxWidth: contrainst.maxWidth,
                    minWidth: contrainst.maxWidth * 0.9,
                    maxHeight: contrainst.maxHeight,
                    minHeight: contrainst.maxHeight * 0.9,
                    swipeUp: true,
                    swipeUpdateCallback:
                        (DragUpdateDetails details, Alignment align) {
                      /// Get swiping card's alignment

                      if (align.y < 0) {
                        viewmodel.onSuperLikeButtonFocus(true);
                        viewmodel.onDeclineButtonFocus(false);
                        viewmodel.onLikeButtonFocus(false);
                        return;
                      }

                      if (align.x < 0) {
                        viewmodel.onDeclineButtonFocus(true);
                        viewmodel.onSuperLikeButtonFocus(false);
                        viewmodel.onLikeButtonFocus(false);
                        return;
                      } else if (align.x > 0) {
                        //Card is RIGHT swiping
                        viewmodel.onLikeButtonFocus(true);
                        viewmodel.onDeclineButtonFocus(false);
                        viewmodel.onSuperLikeButtonFocus(false);
                        return;
                      }
                      viewmodel.onLikeButtonFocus(false);
                      viewmodel.onDeclineButtonFocus(false);
                      viewmodel.onSuperLikeButtonFocus(false);
                    },
                    swipeCompleteCallback:
                        (CardSwipeOrientation orientation, int index) {
                      viewmodel.onLikeButtonFocus(false);
                      viewmodel.onDeclineButtonFocus(false);
                      viewmodel.onSuperLikeButtonFocus(false);
                    },
                  );
                }),
              )),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding:
                      const EdgeInsets.only(bottom: 24, left: 16, right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _wrapperInteractionIcon(
                          const Icon(
                            Icons.replay,
                            color: Colors.yellow,
                          ),
                          const Icon(
                            Icons.replay,
                            color: Colors.white,
                          ),
                          Colors.yellow,
                          onTap: () {}),
                      StreamBuilder<bool>(
                        stream: viewmodel.declineButtonFocusStream,
                        initialData: false,
                        builder: (_, AsyncSnapshot<bool> snapshot) =>
                            _wrapperInteractionIcon(
                                const Icon(
                                  Icons.close,
                                  color: Colors.red,
                                  size: 30,
                                ),
                                const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                Colors.red,
                                size: 65,
                                onTap: () {},
                                isFocus: snapshot.data),
                      ),
                      StreamBuilder<bool>(
                        stream: viewmodel.superLikeButtonFocusStream,
                        initialData: false,
                        builder: (_, AsyncSnapshot<bool> snapshot) =>
                            _wrapperInteractionIcon(
                                const Icon(
                                  Icons.star,
                                  color: Colors.blue,
                                ),
                                const Icon(
                                  Icons.star,
                                  color: Colors.white,
                                ),
                                Colors.blue,
                                onTap: () {},
                                isFocus: snapshot.data),
                      ),
                      StreamBuilder<bool>(
                        stream: viewmodel.likeButtonFocusStream,
                        initialData: false,
                        builder: (_, AsyncSnapshot<bool> snapshot) =>
                            _wrapperInteractionIcon(
                                const Icon(
                                  Icons.favorite,
                                  color: Colors.green,
                                  size: 28,
                                ),
                                const Icon(
                                  Icons.favorite,
                                  color: Colors.white,
                                  size: 28,
                                ),
                                Colors.green,
                                size: 65,
                                onTap: () {},
                                isFocus: snapshot.data),
                      ),
                      _wrapperInteractionIcon(
                          const Icon(
                            Icons.flash_on,
                            color: Colors.purple,
                          ),
                          const Icon(
                            Icons.flash_on,
                            color: Colors.white,
                          ),
                          Colors.purple,
                          onTap: () {}),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: const BottomNavigation(),
      );

  Widget _wrapperInteractionIcon(
    Icon icon,
    Icon highLightIcon,
    Color color, {
    bool? isFocus = false,
    double size = 45,
    GestureTapCallback? onTap,
  }) {
    var buttonSize = size;
    var backgroundColor = Colors.transparent;
    BoxBorder? border = Border.all(color: color, width: 1.5);
    var buttonIcon = icon;

    detect(bool? isFocus) {
      buttonSize = isFocus == true ? size - 10 : size;
      backgroundColor = isFocus == true ? color : Colors.transparent;
      border = isFocus == true ? null : Border.all(color: color, width: 1.5);
      buttonIcon = isFocus == true ? highLightIcon : icon;
    }

    detect(isFocus);

    return Expanded(
      child: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          onHold() {
            setState(() {
              detect(true);
            });
          }

          onRelease() {
            setState(() {
              detect(false);
            });
          }

          return GestureDetector(
            onTap: onTap,
            behavior: HitTestBehavior.opaque,
            onTapDown: (_) {
              onHold();
            },
            onTapUp: (_) {
              onRelease();
            },
            onTapCancel: () {
              onRelease();
            },
            child: Container(
              height: buttonSize,
              width: buttonSize,
              decoration: BoxDecoration(
                  border: border,
                  color: backgroundColor,
                  shape: BoxShape.circle),
              child: Center(
                child: buttonIcon,
              ),
            ),
          );
        },
      ),
    );
  }
}
