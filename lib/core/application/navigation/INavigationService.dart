abstract class INavigationService {
  navigateToPageClear(String routeName);
  Future<void> navigateToPage({String? path, Object? data});
}
