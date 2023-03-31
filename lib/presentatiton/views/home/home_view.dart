import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:task_time_tracker/core/application/constants/color_constants.dart';
import 'package:task_time_tracker/core/application/constants/page_constants.dart';
import 'package:task_time_tracker/core/application/navigation/navigation_service.dart';
import 'package:task_time_tracker/core/domain/entities/Tasks/task.dart';
import 'package:task_time_tracker/core/domain/entities/Tasks/task_tags.dart';
import 'package:task_time_tracker/presentatiton/utility/enums/TaskIcons.dart';
import 'package:task_time_tracker/presentatiton/views/add/add_task_view.dart';
import 'package:task_time_tracker/presentatiton/views/home/home_view_model.dart';
import 'package:task_time_tracker/presentatiton/views/settings/settings_view.dart';
import 'package:task_time_tracker/presentatiton/views/statistics/statistics_view.dart';
import 'package:task_time_tracker/presentatiton/views/tasks/task_view_model.dart';
import 'package:task_time_tracker/presentatiton/widgets/functional_app_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<Task>? _currentTasks;
  @override
  void initState() {
    super.initState();
    _currentTasks = List.filled(
        5,
        Task(
            icon: 'test',
            title: 'test',
            description: 'test',
            id: 'test',
            duration: Duration(minutes: 10),
            isCompleted: false,
            tags: List.filled(1, TaskTags.work)));
  }

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
                child: HomeBottomNavigationBar(context))),
        appBar: FunctionalAppBar(
          title: 'Ana Sayfa',
        ),
        body: HomeWidget());
  }

  BottomNavigationBar HomeBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: true,
      fixedColor: ColorConstants.customPurple.color,
      type: BottomNavigationBarType.fixed,
      onTap: (value) {
        context.read<HomeViewModel>().setCurrentNavBarIndex(value);
      },
      currentIndex: context.watch<HomeViewModel>().currentNavBarIndex,
      items: BottomNavigationBarItems,
    );
  }

  List<BottomNavigationBarItem> get BottomNavigationBarItems {
    return const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: FaIcon(FontAwesomeIcons.clock),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: FaIcon(FontAwesomeIcons.plus),
        label: 'Add Task',
      ),
      BottomNavigationBarItem(
        icon: FaIcon(FontAwesomeIcons.chartBar),
        label: 'Statistics',
      ),
      BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.cog), label: 'Settings')
    ];
  }

  Widget HomeWidget() {
    if (context.watch<HomeViewModel>().currentNavBarIndex == 0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClickableText('Today', 'All'),
              FilterClickableText('See All', 'See Today')
            ],
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: _currentTasks!.length,
                  itemBuilder: (context, index) {
                    return ClickableListTile(context, index);
                  }))
        ],
      );
    } else if (context.watch<HomeViewModel>().currentNavBarIndex == 1) {
      return AddTask();
    } else if (context.watch<HomeViewModel>().currentNavBarIndex == 2) {
      return StatisticsView();
    } else if (context.watch<HomeViewModel>().currentNavBarIndex == 3) {
      return SettingsView();
    } else {
      return const Placeholder();
    }
  }

  FilterClickableText(String condition1, String condition2) {
    return InkWell(
      onTap: () {
        context.read<HomeViewModel>().setTaskFilterDay(
            context.read<HomeViewModel>().taskFilterDay == TaskFilterDay.today
                ? TaskFilterDay.all
                : TaskFilterDay.today);
      },
      child: ClickableText(condition1, condition2),
    );
  }

  Text ClickableText(String condition1, String condition2) {
    return Text(
        context.watch<HomeViewModel>().taskFilterDay == TaskFilterDay.today
            ? condition1
            : condition2,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
  }

  InkWell ClickableListTile(BuildContext context, int index) {
    return InkWell(
        onTap: () {
          debugPrint('tapped');
          context.read<TaskViewModel>().currentTask = _currentTasks![index];
          NavigationService.instance.navigateToPage(path: PageConstants.task);
        },
        child: ListTileTask(index));
  }

  ListTile ListTileTask(int index) {
    var task = _currentTasks![index];
    return ListTile(
      trailing: ListTileTrailing(task),
      subtitle: task.tags!.isNotEmpty
          ? Text(task.tags![0].name)
          : const Text('No tags'),
      leading: ListTileLeading(task.tags![0]),
      title: Text(task.title),
    );
  }

  Column ListTileTrailing(Task task) {
    return Column(children: [
      Text(task.duration!.inHours.toString()),
      task.isCompleted
          ? const FaIcon(FontAwesomeIcons.checkSquare)
          : const FaIcon(FontAwesomeIcons.play)
    ]);
  }

  TaskIcon ListTileLeading(TaskTags taskTags) {
    return TaskIcon(taskTag: taskTags);
  }
}
