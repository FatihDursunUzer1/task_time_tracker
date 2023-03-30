import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:task_time_tracker/core/application/constants/page_constants.dart';
import 'package:task_time_tracker/presentatiton/views/add/add_task_view.dart';
import 'package:task_time_tracker/presentatiton/views/home/home_view_model.dart';
import 'package:task_time_tracker/presentatiton/views/statistics/statistics_view.dart';
import 'package:task_time_tracker/presentatiton/widgets/functional_app_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black38, spreadRadius: 0, blurRadius: 10),
              ],
            ),
            child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
                child: BottomNavigationBar(
                  onTap: (value) {
                    context.read<HomeViewModel>().setCurrentNavBarIndex(value);
                  },
                  currentIndex:
                      context.watch<HomeViewModel>().currentNavBarIndex,
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Icons.access_time_rounded),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.add_rounded),
                      label: 'Add Task',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.pie_chart_rounded),
                      label: 'Statistics',
                    ),
                  ],
                ))),
        appBar: FunctionalAppBar(
          title: 'Ana Sayfa',
        ),
        body: HomeWidget());
  }

  Widget HomeWidget() {
    if (context.watch<HomeViewModel>().currentNavBarIndex == 0) {
      return Text('Home');
    } else if (context.watch<HomeViewModel>().currentNavBarIndex == 1) {
      return AddTask();
    } else if (context.watch<HomeViewModel>().currentNavBarIndex == 2)
      return StatisticsView();
    else
      return Text('Home');
  }
}
