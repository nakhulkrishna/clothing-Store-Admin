import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:thestyldclubadmin/common/utils/constants/sizes.dart';
import 'package:thestyldclubadmin/common/utils/popups/full_screen_loader.dart';
import 'package:thestyldclubadmin/common/utils/popups/loaders.dart';

abstract class BaseDataController<T> extends GetxController {
  // VERIBLES
  RxBool isLoading = false.obs;
  RxInt sortColoumnIndex = 1.obs;
  RxBool sortAssending = true.obs;
  RxList<T> allItems = <T>[].obs;
  RxList<T> filteredItems = <T>[].obs;
  RxList<bool> selectedRow = <bool>[].obs;
  final searchTextController = TextEditingController();

  @override
  void onInit() {
    fecthData();
    super.onInit();
  }

  Future<List<T>> fecthItems();

  bool containsSeacrhQuery(T item, String query);

  Future<void> deleteItem(T item);

  /// FECTHING FROM BACKEND FUNCTION
  Future<void> fecthData() async {
    try {
      isLoading.value = true;
      List<T> fecthedItems = [];

      if (allItems.isEmpty) {
        fecthedItems = await fecthItems();
      }

      allItems.assignAll(fecthedItems);
      filteredItems.assignAll(allItems);
      selectedRow.assignAll(List.generate(allItems.length, (index) => false));
    } catch (e) {
      isLoading.value = false;
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'oh Snap', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void seacrhQuery(String query) {
    filteredItems.assignAll(
      allItems.where((items) => containsSeacrhQuery(items, query)),
    );
  }

  void sortByProperty(
    int sortColumIndex,
    bool ascending,
    Function(T) property,
  ) {
    sortAssending.value = ascending;
    this.sortColoumnIndex.value = sortColumIndex;
    filteredItems.sort((a, b) {
      if (ascending) {
        return property(a).compareTo(property(b));
      } else {
        return property(b).compreTo(property(a));
      }
    });
  }

  void addItemsToList(T items) {
    allItems.add(items);
    filteredItems.add(items);
    selectedRow.assignAll(List.generate(allItems.length, (index) => false));
  }

  removeItemsFromList(T item) async {
    allItems.remove(item);
    filteredItems.remove(item);
    selectedRow.assignAll(List.generate(allItems.length, (index) => false));
  }

  void updateItemsFromList(T items) {
    final itemindex = allItems.indexWhere((i) => i == items);
    final filteredIndexItem = filteredItems.indexWhere((i) => i == items);

    if (itemindex != -1) allItems[itemindex] = items;

    if (filteredIndexItem != -1) filteredItems[itemindex] = items;
  }

  Future<void> confrimAndDeleteItem(T item) async {
    Get.defaultDialog(
      title: "Delete Item",
      content: Text("Are you sure you want to delete this item ?"),
      cancel: SizedBox(
        width: 60,
        child: ElevatedButton(
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(TSizes.buttonRadius * 5),
            ),
            padding: EdgeInsets.symmetric(vertical: TSizes.buttonHeight / 2),
          ),
          onPressed: () => Get.back(),
          child: Text("Cancel"),
        ),
      ),
      confirm: SizedBox(
        width: 60,
        child: ElevatedButton(
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(TSizes.buttonRadius * 5),
            ),
            padding: EdgeInsets.symmetric(vertical: TSizes.buttonHeight / 2),
          ),
          onPressed: () async => await deleteonConfirm(item),
          child: Text("Ok"),
        ),
      ),
    );
  }

  Future<void> deleteonConfirm(T item) async {
    try {
      TFullScreenLoader.stopLoading();
      TFullScreenLoader.popUpCircular();
      await deleteItem(item);
      removeItemsFromList(item);
      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
        title: "Item Deleted",
        message: "Your Item Has Deleted",
      );
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: "oh Snap", message: e.toString());
    }
  }
}
