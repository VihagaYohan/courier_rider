// constants
import 'package:courier_rider/models/CourierType.dart';
import 'package:courier_rider/models/PackageType.dart';
import 'package:courier_rider/services/helper_service.dart';
import 'package:courier_rider/utils/utils.dart';

// services
import 'package:courier_rider/utils/utils.dart';

class CourierService {
  static Future<double> calculateCourierCharge(
      // String courierType,
      // String packageType,
      String packageSize,
      String shipmentTypeId,
      String packageTypeId) async {
    double baseCharge = 100;
    double sizeMultiplier = 1.0;
    double typeMultiplier = 1.0;

    // get shipment type
    CourierType courierType =
        await HelperService.getShipmentTypeById(shipmentTypeId);
    print(courierType.name);

    // package type
    PackageType packageType =
        await HelperService.getPackageTypeById(packageTypeId);
    print(packageType.name);

    // base charges
    switch (courierType.name.toLowerCase()) {
      case Constants.express:
        baseCharge = 200;
        break;
      case Constants.standard:
        baseCharge = 100;
        break;
      case Constants.custom:
        baseCharge = 100;
        break;
      default:
        baseCharge = 100;
        break;
    }

    // package size
    switch (packageSize) {
      case Constants.smallPackage:
        sizeMultiplier = 1.0;
        break;
      case Constants.mediumPackage:
        sizeMultiplier = 2.0;
        break;
      case Constants.largePackage:
        sizeMultiplier = 3.0;
        break;
    }

    // package type
    switch (packageType.name.toLowerCase()) {
      case Constants.document:
        typeMultiplier = 1.0;
        break;
      case Constants.electronics:
        typeMultiplier = 2.0;
        break;
      case Constants.fragile:
        typeMultiplier = 3.0;
        break;
    }

    // calculate total courier package total
    double total = baseCharge * sizeMultiplier * typeMultiplier;
    return total;
  }
}
