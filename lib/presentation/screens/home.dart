import 'dart:math';
import '../../domain/entity/user.dart';
import '../../routes.dart';
import 'package:provider/provider.dart';
import '../../config/di.dart';
import '../viewmodel/home_viewmodel.dart';
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
  Widget build(BuildContext context) =>
      ChangeNotifierProvider<HomeViewModel>.value(
        value: viewmodel,
        child: Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                Positioned.fill(
                    child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: LayoutBuilder(
                      builder: (context, BoxConstraints contrainst) => Consumer<
                              HomeViewModel>(
                          builder: (context, vm, _) => TinderSwapCard(
                                cardController: viewmodel.cardController,
                                emptyCardBuilder: (BuildContext context) {
                                  if (viewmodel.isFetchingUsers) {
                                    return const Center(
                                      child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Colors.pinkAccent)),
                                    );
                                  }

                                  if (viewmodel.isUserEmpty) {
                                    return Center(
                                      child: Text(
                                        'No user',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3
                                            ?.copyWith(color: Colors.black),
                                      ),
                                    );
                                  }

                                  return Container();
                                },
                                cardBuilder:
                                    (BuildContext context, int index) =>
                                        ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Stack(
                                    children: [
                                      Positioned.fill(
                                          child: Center(
                                              child: Image.network(
                                        vm.users[index].picture,
                                        width: double.infinity,
                                        height: double.infinity,
                                        fit: BoxFit.fitHeight,
                                      ))),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Visibility(
                                          visible: 0 == index,
                                          child: StreamBuilder<double>(
                                              stream: viewmodel.onLikeOpacity,
                                              initialData: 0,
                                              builder: (context, snapshot) =>
                                                  _wrapperInteractionBadge(
                                                    'LIKE',
                                                    Colors.greenAccent,
                                                    Matrix4.identity()
                                                      ..setRotationZ(-pi / 18),
                                                    snapshot.requireData,
                                                  )),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Visibility(
                                          visible: 0 == index,
                                          child: StreamBuilder<double>(
                                              stream:
                                                  viewmodel.onDeclineOpacity,
                                              initialData: 0,
                                              builder: (context, snapshot) =>
                                                  _wrapperInteractionBadge(
                                                    'NOPE',
                                                    Colors.redAccent,
                                                    Matrix4.identity()
                                                      ..setRotationZ(pi / 18),
                                                    snapshot.requireData,
                                                  )),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Visibility(
                                          visible: 0 == index,
                                          child: StreamBuilder<double>(
                                              stream:
                                                  viewmodel.onSuperLikeOpacity,
                                              initialData: 0,
                                              builder: (context, snapshot) =>
                                                  Padding(
                                                    padding:
                                                         EdgeInsets.only(
                                                            bottom:
                                                                65 + 16 + MediaQuery.of(context).size.height * 0.2),
                                                    child:
                                                        _wrapperInteractionBadge(
                                                      'SUPER LIKE',
                                                      Colors.lightBlueAccent,
                                                      Matrix4.identity()
                                                        ..setRotationZ(
                                                            -pi / 18),
                                                      snapshot.requireData,
                                                    ),
                                                  )),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: LayoutBuilder(
                                            builder: (BuildContext context,
                                                    BoxConstraints
                                                        constraints) =>
                                                Container(
                                                  height:
                                                      constraints.maxHeight / 3,
                                                  decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                          begin: Alignment
                                                              .topCenter,
                                                          end: Alignment
                                                              .bottomCenter,
                                                          colors: [
                                                        Colors.black
                                                            .withOpacity(0.01),
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
                                              bottom: 65 + 16 + 60,
                                              left: 16,
                                              right: 16),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Row(
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      vm.users[index].name(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline4!
                                                          .copyWith(
                                                              color:
                                                                  Colors.white),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 8),
                                                    child: StatefulBuilder(
                                                        builder: (context,
                                                            setState) {
                                                      final user =
                                                          vm.users[index];
                                                      if (user.age == null) {
                                                        vm
                                                            .getUserAge(user.id)
                                                            .then((value) {
                                                          setState(() {
                                                            user.age = value;
                                                          });
                                                        });
                                                      }
                                                      return Text(
                                                          user.age ?? '',
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .headline4!
                                                              .copyWith(
                                                                  color: Colors
                                                                      .white));
                                                    }),
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
                                totalNum: vm.users.length,
                                maxWidth: contrainst.maxWidth,
                                minWidth: contrainst.maxWidth * 0.9,
                                maxHeight: contrainst.maxHeight,
                                minHeight: contrainst.maxHeight * 0.9,
                                swipeUp: true,
                                swipeUpdateCallback: (DragUpdateDetails details,
                                    Alignment align) {
                                  /// Get swiping card's alignment

                                  viewmodel
                                    ..onAttemptDecline(align.x)
                                    ..onAttemptLike(align.x)
                                    ..onAttemptSuperLike(align.y);

                                  if (align.y < -0.5) {
                                    //Card is UP swiping
                                    viewmodel
                                      ..onSuperLikeButtonFocus(focus: true)
                                      ..onDeclineButtonFocus()
                                      ..onLikeButtonFocus();
                                    return;
                                  }

                                  if (align.x < 0) {
                                    //Card is LEFT swiping
                                    viewmodel
                                      ..onDeclineButtonFocus(focus:true)
                                      ..onSuperLikeButtonFocus()
                                      ..onLikeButtonFocus();
                                    return;
                                  } else if (align.x > 0) {
                                    //Card is RIGHT swiping
                                    viewmodel
                                      ..onLikeButtonFocus(focus:true)
                                      ..onDeclineButtonFocus()
                                      ..onSuperLikeButtonFocus();
                                    return;
                                  }
                                  viewmodel
                                    ..onLikeButtonFocus()
                                    ..onDeclineButtonFocus()
                                    ..onSuperLikeButtonFocus();
                                },
                                swipeCompleteCallback:
                                    (CardSwipeOrientation orientation,
                                        int index) {
                                  if (orientation !=
                                      CardSwipeOrientation.recover) {
                                    final User user = viewmodel.users[index];
                                    if (orientation ==
                                        CardSwipeOrientation.up) {
                                      viewmodel.onSuperLikeUser(user);
                                    }
                                    if (orientation ==
                                        CardSwipeOrientation.left) {
                                      viewmodel.onDeclineUser(user);
                                    }
                                    if (orientation ==
                                        CardSwipeOrientation.right) {
                                      viewmodel.onLikeUser(user);
                                    }
                                    viewmodel.onUserChosen(user);
                                  }

                                  viewmodel
                                    ..onCurrentIndexCardChanged(orientation ==
                                            CardSwipeOrientation.recover
                                        ? index
                                        : index + 1)
                                    ..onAttemptDecline(0)
                                    ..onAttemptLike(0)
                                    ..onAttemptSuperLike(0)
                                    ..onLikeButtonFocus()
                                    ..onDeclineButtonFocus()
                                    ..onSuperLikeButtonFocus();
                                },
                              ))),
                )),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(bottom: 24, left: 16, right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
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
                                  size: 65, onTap: () {
                            if (viewmodel.users.isNotEmpty) {
                              viewmodel.onDecline(viewmodel.users[0]);
                            }
                          }, isFocus: snapshot.data),
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
                                  Colors.blue, onTap: () {
                            if (viewmodel.users.isNotEmpty) {
                              viewmodel.onSuperLike(viewmodel.users[0]);
                            }
                          }, isFocus: snapshot.data),
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
                                  size: 65, onTap: () {
                            if (viewmodel.users.isNotEmpty) {
                              viewmodel.onLike(viewmodel.users[0]);
                            }
                          }, isFocus: snapshot.data),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigation(
            () {
              Navigator.of(context).pushNamed(RoutePaths.likedListRoute);
            },
            () {
              Navigator.of(context).pushNamed(RoutePaths.secondLookRoute);
            },
          ),
        ),
      );

  Widget _wrapperInteractionBadge(
          String text, Color color, Matrix4? tranform, double opacity) =>
      Opacity(
        opacity: opacity,
        child: Container(
          transform: tranform,
          constraints: const BoxConstraints(minWidth: 80),
          margin: const EdgeInsets.only(top: 32, left: 16),
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
          decoration: BoxDecoration(
              border: Border.all(
                color: color,
                width: 3,
              ),
              borderRadius: BorderRadius.circular(6),
              ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headline4
                ?.copyWith(color: color, fontWeight: FontWeight.bold),
          ),
        ),
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

    detect({bool? isFocus}) {
      buttonSize = isFocus == true ? size - 10 : size;
      backgroundColor = isFocus == true ? color : Colors.transparent;
      border = isFocus == true ? null : Border.all(color: color, width: 1.5);
      buttonIcon = isFocus == true ? highLightIcon : icon;
    }

    detect(isFocus :isFocus);

    return Expanded(
      child: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          onHold() {
            setState(() {
              detect(isFocus :true);
            });
          }

          onRelease() {
            setState(() {
              detect(isFocus : false);
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
            onTapCancel: onRelease,
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
