import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task_time_tracker/core/application/constants/color_constants.dart';
import 'package:task_time_tracker/core/domain/entities/Tasks/task_tags.dart';

class TaskIcon extends StatelessWidget {
  final TaskTags taskTag;
  final Color? color;

  const TaskIcon({super.key, required this.taskTag, this.color});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        backgroundColor: color ?? ColorConstants.customPurple.color,
        child: _getIcon());
  }

  Widget _getIcon() {
    switch (taskTag) {
      case TaskTags.work:
        return const FaIcon(FontAwesomeIcons.briefcase);
      case TaskTags.personal:
        return const FaIcon(FontAwesomeIcons.user);
      case TaskTags.other:
        return const FaIcon(FontAwesomeIcons.question);
      case TaskTags.home:
        return const FaIcon(FontAwesomeIcons.home);
      case TaskTags.shopping:
        return const FaIcon(FontAwesomeIcons.shoppingCart);
      default:
        return const FaIcon(FontAwesomeIcons.question);
    }
  }
}
