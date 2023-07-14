import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:task_time_tracker/core/application/constants/color_constants.dart';
import 'package:task_time_tracker/core/application/constants/page_constants.dart';
import 'package:task_time_tracker/core/application/navigation/navigation_service.dart';
import 'package:task_time_tracker/core/domain/entities/Tasks/task.dart';
import 'package:task_time_tracker/core/domain/entities/Tasks/task_tags.dart';
import 'package:task_time_tracker/presentation/generated/locale_keys.g.dart';
import 'package:task_time_tracker/presentation/utility/enums/TaskIcons.dart';
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
  late Future<List<Task>?> _futureTasks;
  @override
  void initState() {
    super.initState();
    _currentTasks = [];
    _futureTasks = getTasks();
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
      fixedColor: ColorConstants.customPurple,
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
        icon: const FaIcon(FontAwesomeIcons.clock),
        label: LocaleKeys.home_page.tr(),
      ),
      BottomNavigationBarItem(
        icon: const FaIcon(FontAwesomeIcons.plus),
        label: LocaleKeys.add_task.tr(),
      ),
      /*BottomNavigationBarItem(
        icon: const FaIcon(FontAwesomeIcons.chartBar),
        label: LocaleKeys.statiscs.tr(),
      ), this feature not available currently*/
      BottomNavigationBarItem(
          icon: const FaIcon(FontAwesomeIcons.cog),
          label: LocaleKeys.settings.tr())
    ];
  }

  HomeWidget() {
    if (context.watch<HomeViewModel>().currentNavBarIndex == 0) {
      return TasksHomeWidget();
    } else if (context.watch<HomeViewModel>().currentNavBarIndex == 1) {
      return const AddTask();
    } /*else if (context.watch<HomeViewModel>().currentNavBarIndex == 2) {
      return const StatisticsView(); //StatisticsView(); normally but this page not available for this section.
    }  */
    else if (context.watch<HomeViewModel>().currentNavBarIndex == 2) {
      return const SettingsView();
    } else {
      return const Placeholder();
    }
  }

  //Update dialog
  AlertDialog updateDialog() {
    return AlertDialog(
      title: const Text('Update'),
      content:
          const Text('There is a new version of the app. Please update it.'),
      actions: [
        TextButton(
            onPressed: () {
              //SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              exit(1);
              //SystemNavigator.pop();
            },
            child: Text(LocaleKeys.cancel.tr())),
        TextButton(
            onPressed: () {
              NavigationService.instance
                  .navigateToPage(path: PageConstants.profile);
            },
            child: Text(LocaleKeys.update.tr()))
      ],
    );
  }

  TasksHomeWidget() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32.0),
                child: WelcomeArea(),
              ),
              FilterOptionsRow(),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: TasksFutureBuilder(),
          ),
        ],
      ),
    );
  }

  FutureBuilder<List<Task>?> TasksFutureBuilder() {
    return FutureBuilder(
      future: _futureTasks,
      builder: (context, AsyncSnapshot<List<Task>?> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ClickableListTile(context, index);
                });
          } else {
            return NoDataInformation();
          }
        } else {
          return const Center(
              child: CircularProgressIndicator(
            color: ColorConstants.customPurple,
          ));
        }
      },
    );
  }

  Padding NoDataInformation() {
    return Padding(
      padding: const EdgeInsets.all(48.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            LocaleKeys.no_data.tr(),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            LocaleKeys.add_new_task_button.tr(),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  SizedBox WelcomeArea() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${LocaleKeys.hello.tr()},',
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          Text('${context.watch<HomeViewModel>().currentUser.displayName}',
              style:
                  const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        ],
      ),
    );
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
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
  }

  Card ClickableListTile(BuildContext context, int index) {
    return ListTileTask(index);
  }

  ListTileTask(int index) {
    var task = _currentTasks![index];

    return Card(
      color: task.isCompleted == true
          ? ColorConstants.timerCardDark
          : ColorConstants.customPurpleRadial,
      child: SlidableFeature(task, index),
    );
  }

  Slidable SlidableFeature(Task task, int index) {
    return Slidable(
      // Specify a key if the Slidable is dismissible.
      key: UniqueKey(),

      // The start action pane is the one at the left or the top side.
      startActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
        motion: const ScrollMotion(),

        // A pane can dismiss the Slidable.
        dismissible: DismissiblePane(onDismissed: () async {
          await context.read<HomeViewModel>().deleteTask(task);
        }),

        // All actions are defined in the children parameter.
        children: [
          // A SlidableAction can have an icon and/or a label.
          DeleteAction(task),
          ShareAction(),
        ],
      ),

      // The end action pane is the one at the right or the bottom side.
      endActionPane: UpdateAction(task),
      child: ListTile(
        onTap: () {
          context.read<TaskViewModel>().currentTask = _currentTasks![index];
          NavigationService.instance.navigateToPage(path: PageConstants.task);
        },
        textColor: ColorConstants.timerCardLight,
        trailing: const FaIcon(FontAwesomeIcons.chevronRight),
        subtitle: Text(
          task.description.length > 20
              ? '${task.description.substring(0, 20)}...'
              : task.description,
        ),
        leading: ListTileLeading(task.tags![0]),
        title: Text(
          task.title,
        ),
      ),
    );
  }

  ActionPane UpdateAction(Task task) {
    return ActionPane(
      motion: const ScrollMotion(),
      children: [
        SlidableAction(
          onPressed: (context) {
            context.read<HomeViewModel>().updateTask(task);
          },
          backgroundColor: ColorConstants.customBlue,
          foregroundColor: Colors.white,
          icon: Icons.save,
          label: 'Save',
        ),
      ],
    );
  }

  SlidableAction ShareAction() {
    return SlidableAction(
      onPressed: (_) {},
      backgroundColor: ColorConstants.customPurple,
      foregroundColor: Colors.white,
      icon: Icons.share,
      label: 'Share',
    );
  }

  SlidableAction DeleteAction(Task task) {
    return SlidableAction(
      onPressed: (context) async {
        await context.read<HomeViewModel>().deleteTask(task);
      },
      backgroundColor: ColorConstants.customPink,
      foregroundColor: Colors.white,
      icon: Icons.delete,
      label: 'Delete',
    );
  }

  TaskIcon ListTileLeading(TaskTags taskTags) {
    return TaskIcon(taskTag: taskTags);
  }

  Future<List<Task>?> getTasks() async {
    _currentTasks = await context.read<HomeViewModel>().getTasks();
    return _currentTasks;
  }
}
