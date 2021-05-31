class FilterModel {
  List<CarManufacturers> carManufacturers;
  List<DataSuppliers> dataSuppliers;
  bool isAmerigo;
  int supplierSelectedDefault;

  FilterModel(
      {this.carManufacturers,
        this.dataSuppliers,
        this.isAmerigo,
        this.supplierSelectedDefault});

  FilterModel.fromJson(Map<String, dynamic> json) {
    if (json['car_manufacturers'] != null) {
      carManufacturers = [];
      json['car_manufacturers'].forEach((v) {
        carManufacturers.add(CarManufacturers.fromJson(v));
      });
    }
    if (json['data_suppliers'] != null) {
      dataSuppliers = [];
      json['data_suppliers'].forEach((v) {
        dataSuppliers.add(DataSuppliers.fromJson(v));
      });
    }
    isAmerigo = json['is_amerigo'];
    supplierSelectedDefault = json['supplier_selected_default'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.carManufacturers != null) {
      data['car_manufacturers'] =
          this.carManufacturers.map((v) => v.toJson()).toList();
    }
    if (this.dataSuppliers != null) {
      data['data_suppliers'] =
          this.dataSuppliers.map((v) => v.toJson()).toList();
    }
    data['is_amerigo'] = this.isAmerigo;
    data['supplier_selected_default'] = this.supplierSelectedDefault;
    return data;
  }
}

class CarManufacturers {
  int id;
  String name;

  CarManufacturers({this.id, this.name});

  CarManufacturers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class DataSuppliers {
  String id;
  String name;
  bool isAmerigo;

  DataSuppliers({this.id, this.name, this.isAmerigo});

  DataSuppliers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isAmerigo = json['is_amerigo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['is_amerigo'] = this.isAmerigo;
    return data;
  }
}