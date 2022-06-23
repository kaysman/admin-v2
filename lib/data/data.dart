export 'data_drivers.dart';
import 'package:lng_adminapp/data/enums/status.enum.dart';

const filterDateTypes = [
  DateRangeType.custom,
  DateRangeType.today,
  DateRangeType.yesterday,
  DateRangeType.last7days,
  DateRangeType.last30days,
  DateRangeType.last90days,
];

/// ---------
/// Hours in 12-hour system
/// ---------
// List<String> hoursIn12HourSystem() {
//   List<String> hours = [];
//   // z -> AM/PM
//   // i -> II:xx
//   // j -> xx:JJ
//   for (int z = 1; z <= 2; z++) {
//     for (int i = 0; i <= 12; i++) {
//       String hour = '';
//       if (i == 0) {
//         hour += "12:";
//       } else {
//         i < 10 ? hour += "0$i:" : hour += "$i:";
//       }
//       for (int j = 1; j <= 2; j++) {
//         var suffix = '';
//         if (j == 1 && i != 12) {
//           suffix = "00";
//           suffix += z == 1 ? " AM" : " PM";
//           hours.add(hour + suffix);
//         } else if ((j != 1 && i != 12)) {
//           suffix = "30";
//           suffix += z == 1 ? " AM" : " PM";
//           hours.add(hour + suffix);
//         }
//       }
//     }
//   }
//   return hours;
// }

List<String> dummyWareHouses = [
  "Warehouse no. 1",
  "Warehouse no. 2",
  "Warehouse no. 3",
  "Warehouse no. 4",
];

List<String> availableCurrencies = ["Singaporean dollar"];
