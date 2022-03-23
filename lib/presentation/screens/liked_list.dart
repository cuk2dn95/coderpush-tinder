import '../../config/di.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodel/liked_list_viewmodel.dart';

class LikedListScreen extends StatefulWidget {
  const LikedListScreen({Key? key}) : super(key: key);

  @override
  _LikedListScreenState createState() => _LikedListScreenState();
}

class _LikedListScreenState extends State<LikedListScreen> {
  final LikedListViewModel viewmodel = Injector.likedListViewModel();

  @override
  Widget build(BuildContext context) =>
      ChangeNotifierProvider<LikedListViewModel>.value(
        value: viewmodel,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Liked List'),
          ),
          body: SafeArea(
            child: Consumer<LikedListViewModel>(
              builder: (context, vm, _) {
                if (vm.likedListUsers.isEmpty) {
                  return Center(
                    child: Text(
                      'No liked user recent',
                      style: Theme.of(context).textTheme.headline3,
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  return ListView.separated(
                    itemBuilder: (BuildContext context, int index) => ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(vm.likedListUsers[index].picture),
                        radius: 50,
                      ),
                      title: Text(
                        vm.likedListUsers[index].name(),
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    separatorBuilder: (_, __) => const SizedBox(
                      height: 10,
                    ),
                    itemCount: vm.likedListUsers.length,
                  );
                }
              },
            ),
          ),
        ),
      );
}
