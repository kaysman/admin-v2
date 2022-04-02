import 'models/driver.dart';

List<Driver> driversList = List.generate(25, (index) {
  return Driver(
    id: "#00$index",
    name: "John Cena",
    phone: "+65 253 1524 322",
    address: "12 Broadway Ave, Singapore",
    teams: ["WWE", "West Singapore Team", "Quick Delivery Team"],
  );
});

List<String> columnNames = ['Photo', 'Name', 'Phone', 'Address', 'Teams'];
