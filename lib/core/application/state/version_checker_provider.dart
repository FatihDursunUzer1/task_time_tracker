import 'package:cloud_firestore/cloud_firestore.dart';

class VersionChecker {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool isUpdate = false;

  static VersionChecker? _instance;

  static VersionChecker get instance {
    _instance ??= VersionChecker._();
    return _instance!;
  }

  VersionChecker._();

  checkVersion(String currentVersion) async {
    var currentVersionList =
        currentVersion.split('.').map((e) => int.parse(e)).toList();
    var firebaseVersion =
        await _firestore.collection('application').doc('version').get();
    var firebaseVersionString = firebaseVersion.data()!['value'].toString();
    var firebaseVersionList= firebaseVersionString.split('.').map((e) => int.parse(e)).toList();
    _checkList(currentVersionList, firebaseVersionList);
  }

  _checkList(List<int> currentVersion, List<int> firebaseVersion) {
    if (currentVersion.length < firebaseVersion.length) {
      _fillListWithZero(currentVersion, firebaseVersion.length - currentVersion.length);
    } else if (currentVersion.length > firebaseVersion.length) {
      _fillListWithZero(firebaseVersion, currentVersion.length - firebaseVersion.length);
    }

    for (int i = 0; i < firebaseVersion.length; i++) {
      if (currentVersion[i] < firebaseVersion[i]) {
        isUpdate = true;
        break;
      } else if (currentVersion[i] > firebaseVersion[i]) {
        isUpdate = false;
        break;
      }
    }
  }

  _fillListWithZero(List<int> fillableList, int zeroLength) {
    for (int i = 0; i < zeroLength; i++) {
      fillableList.add(0);
    }
  }
}
