import 'package:fonofy/Api_Service/SellService/RepairColorModelService/RepairServicesTableService.dart';
import 'package:fonofy/models/RepairServicesTableModel/RepairServicesTableModel.dart';
import 'package:get/get.dart';

class RepairControllerTable extends GetxController {
  var isRepairTableLoading = true.obs;
  var _appRepairTableData;

  RepairServicesTableModel? get tableRepairData => _appRepairTableData;

  Future<void> getTableRepairData(String bid, String pid, String cid) async {
    await RepairTableService.fetchRepairTableData(bid, pid, cid)
        .then((response) {
      isRepairTableLoading(true);
      _appRepairTableData = response;
      update();
    }).catchError((err) {
      // debugPrint('Options Deatils Error: $err');
    }).whenComplete(() => isRepairTableLoading(false));
  }
}
