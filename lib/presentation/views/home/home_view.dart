import 'package:easy_localization/easy_localization.dart';
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
import 'package:task_time_tracker/infrastructure/repositories/task_repository.dart';
import 'package:task_time_tracker/infrastructure/repositories/user_repository.dart';
import 'package:task_time_tracker/presentation/generated/locale_keys.g.dart';
import 'package:task_time_tracker/presentation/utility/enums/TaskIcons.dart';
import 'package:task_time_tracker/presentation/utility/errors/not_available_currently.dart';
import 'package:task_time_tracker/presentation/views/add/add_task_view.dart';
import 'package:task_time_tracker/presentation/views/home/home_view_model.dart';
import 'package:task_time_tracker/presentation/views/settings/settings_view.dart';
import 'package:task_time_tracker/presentation/views/statistics/statistics_view.dart';
import 'package:task_time_tracker/presentation/views/tasks/task_view_model.dart';
import 'package:task_time_tracker/presentation/widgets/functional_app_bar.dart';

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
    _currentTasks = [];
    /*context
        .read<HomeViewModel>()
        .setCurrentUser(UserRepository.instance.getCurrentUser()!); */
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
          title: 'Task Time Tracker',
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
    return <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: FaIcon(FontAwesomeIcons.clock),
        label: LocaleKeys.home.tr(),
      ),
      BottomNavigationBarItem(
        icon: FaIcon(FontAwesomeIcons.plus),
        label: LocaleKeys.add_task.tr(),
      ),
      BottomNavigationBarItem(
        icon: FaIcon(FontAwesomeIcons.chartBar),
        label: LocaleKeys.statiscs.tr(),
      ),
      BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.cog), label: LocaleKeys.settings.tr())
    ];
  }

  Widget HomeWidget() {
    if (context.watch<HomeViewModel>().currentNavBarIndex == 0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            child: Text(
              LocaleKeys.current_task.tr(),
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            height: MediaQuery.of(context).size.height * 0.2,
          ),
          FilterOptionsRow(),
          FutureBuilder(
            future: getTasks(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData)
                  return Expanded(
                      child: ListView.builder(
                          itemCount: _currentTasks!.length,
                          itemBuilder: (context, index) {
                            return ClickableListTile(context, index);
                          }));
                else
                  return const Center(child: Text('No data'));
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          )
        ],
      );
    } else if (context.watch<HomeViewModel>().currentNavBarIndex == 1) {
      return AddTask();
    } else if (context.watch<HomeViewModel>().currentNavBarIndex == 2) {
      return NotAvailable(); //StatisticsView(); normally but this page not available for this section.
    } else if (context.watch<HomeViewModel>().currentNavBarIndex == 3) {
      return SettingsView();
    } else {
      return const Placeholder();
    }
  }

  Row FilterOptionsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ClickableText(LocaleKeys.today.tr(), LocaleKeys.all.tr()),
        FilterClickableText(
            LocaleKeys.see_all_task.tr(), LocaleKeys.see_today.tr())
      ],
    );
  }

  FilterClickableText(String condition1, String condition2) {
    return InkWell(
      onTap: () async {
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

  ListTileTask(int index) {
    var task = _currentTasks![index];
    return Card(
      child: ListTile(
        iconColor: Colors.white,
        textColor: Colors.white,
        trailing: FaIcon(FontAwesomeIcons.chevronRight),
        subtitle: Text(task.description.length > 20
            ? '${task.description.substring(0, 20)}...'
            : task.description),
        leading: ListTileLeading(task.tags![0]),
        title: Text(task.title),
      ),
    );
  }

  TaskIcon ListTileLeading(TaskTags taskTags) {
    return TaskIcon(taskTag: taskTags);
  }

  getTasks() async {
    _currentTasks = await context.read<HomeViewModel>().getTasks();
    return _currentTasks;
  }
}
