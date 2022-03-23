import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/di.dart';
import '../viewmodel/second_look_viewmodel.dart';

class SecondLookScreen extends StatefulWidget {
  const SecondLookScreen({Key? key}) : super(key: key);

  @override
  _SecondLookScreenState createState() => _SecondLookScreenState();
}

class _SecondLookScreenState extends State<SecondLookScreen> {
  final SecondLookViewModel viewmodel = Injector.secondLookViewModel();

  @override
  Widget build(BuildContext context) =>
      ChangeNotifierProvider<SecondLookViewModel>.value(
          value: viewmodel,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Second Look'),
            ),
            body: SafeArea(
              child: SafeArea(
                child: Consumer<SecondLookViewModel>(
                  builder: (context, vm, _) {
                    if (vm.secondLookUsers.isEmpty) {
                      return Center(
                        child: Text(
                          'No user recent',
                          style: Theme.of(context).textTheme.headline3,
                          textAlign: TextAlign.center,
                        ),
                      );
                    } else {
                      return ListView.separated(
                        itemBuilder: (BuildContext context, int index) =>
                            ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(vm.secondLookUsers[index].picture),
                            radius: 50,
                          ),
                          title: Text(
                            vm.secondLookUsers[index].name(),
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                        separatorBuilder: (_, __) => const SizedBox(
                          height: 10,
                        ),
                        itemCount: vm.secondLookUsers.length,
                      );
                    }
                  },
                ),
              ),
            ),
          ));
}
