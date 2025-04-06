import 'package:get/get.dart';
import 'package:thestyldclubadmin/common/utils/constants/enums.dart';
import 'package:thestyldclubadmin/common/utils/popups/loaders.dart';
import 'package:thestyldclubadmin/data/abstract/base_data_controller.dart';
import 'package:thestyldclubadmin/data/repositorys/order_repository/order_repository.dart';
import 'package:thestyldclubadmin/features/shop/models/orderModel.dart';

class OrderController extends BaseDataController<Ordermodel> {
  static OrderController get instance => Get.find();
  RxBool statusLoader = false.obs;
  var orderStatus = OrderStatus.delivered.obs;
  final _orderRepository = Get.put(OrderRepository());

  @override
  bool containsSeacrhQuery(Ordermodel item, String query) {
    return item.id.toLowerCase().contains(query.toLowerCase());
  }

  @override
  Future<void> deleteItem(Ordermodel item) async {
    await _orderRepository.deleteOrder(item.docId);
  }

  @override
  Future<List<Ordermodel>> fecthItems() async {
    sortAssending.value = false;
    return await _orderRepository.getAllOrders();
  }

  void sortByid(int sortColumnIndex, bool ascending) {
    sortByProperty(
      sortColumnIndex,
      ascending,
      (Ordermodel o) => o.totalAmount.toString(),
    );
  }

  void sortByDate(int sortColumnIndex, bool ascending) {
    sortByProperty(
      sortColumnIndex,
      ascending,
      (Ordermodel o) => o.orderDate.toString(),
    );
  }

  Future<void> updateOrderStatus(
    Ordermodel order,
    OrderStatus newStatus,
  ) async {
    try {
      statusLoader.value = true;
      order.status = newStatus;
      await _orderRepository.updateOrderSpecificValue(order.id, {
        'status': newStatus.toString(),
      });
      updateItemsFromList(order);

      orderStatus.value = newStatus;
      TLoaders.successSnackBar(
        title: "Updated",
        message: "order status updated",
      );
    } catch (e) {
      TLoaders.warningSnackBar(title: "oh snap!", message: e.toString());
    } finally {
      statusLoader.value = false;
    }
  }
}
