class SearchResultModel {
  int page;
  int perPage;
  int totalPages;
  int totalCount;
  List<Data> data;

  SearchResultModel(
      {this.page, this.perPage, this.totalPages, this.totalCount, this.data});

  SearchResultModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    perPage = json['per_page'];
    totalPages = json['total_pages'];
    totalCount = json['total_count'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['page'] = this.page;
    data['per_page'] = this.perPage;
    data['total_pages'] = this.totalPages;
    data['total_count'] = this.totalCount;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String name;
  String productName;
  //List<Null> packageComponents;
  String manufacturerName;
  int manufacturerId;
  String codFou;
  List<Tags> tags;
  String image;
  bool addToCart;
  String replacementsList;
  int price;
  int available;
  //List<Null> equivalences;
  bool isFavorite;
  List<CarParts> carParts;

  Data(
      {this.name,
        this.productName,
        //this.packageComponents,
        this.manufacturerName,
        this.manufacturerId,
        this.codFou,
        this.tags,
        this.image,
        this.addToCart,
        this.replacementsList,
        this.price,
        this.available,
        //this.equivalences,
        this.isFavorite,
        this.carParts});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    productName = json['product_name'];
/*    if (json['package_components'] != null) {
      packageComponents = List<Null>();
      json['package_components'].forEach((v) {
        packageComponents.add(Null.fromJson(v));
      });
    }*/
    manufacturerName = json['manufacturer_name'];
    manufacturerId = json['manufacturer_id'];
    codFou = json['cod_fou'];
    if (json['tags'] != null) {
      tags = <Tags>[];
      json['tags'].forEach((v) {
        tags.add(Tags.fromJson(v));
      });
    }
    image = json['image'];
    addToCart = json['add_to_cart'];
    replacementsList = json['replacements_list'];
    price = json['price'];
    available = json['available'];
/*    if (json['equivalences'] != null) {
      equivalences = List<Null>();
      json['equivalences'].forEach((v) {
        equivalences.add(Null.fromJson(v));
      });
    }*/
    isFavorite = json['is_favorite'];
    if (json['car_parts'] != null) {
      carParts = <CarParts>[];
      json['car_parts'].forEach((v) {
        carParts.add(CarParts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.name;
    data['product_name'] = this.productName;
/*    if (this.packageComponents != null) {
      data['package_components'] =
          this.packageComponents.map((v) => v.toJson()).toList();
    }*/
    data['manufacturer_name'] = this.manufacturerName;
    data['manufacturer_id'] = this.manufacturerId;
    data['cod_fou'] = this.codFou;
    if (this.tags != null) {
      data['tags'] = this.tags.map((v) => v.toJson()).toList();
    }
    data['image'] = this.image;
    data['add_to_cart'] = this.addToCart;
    data['replacements_list'] = this.replacementsList;
    data['price'] = this.price;
    data['available'] = this.available;
/*    if (this.equivalences != null) {
      data['equivalences'] = this.equivalences.map((v) => v.toJson()).toList();
    }*/
    data['is_favorite'] = this.isFavorite;
    if (this.carParts != null) {
      data['car_parts'] = this.carParts.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tags {
  String name;
  String value;

  Tags({this.name, this.value});

  Tags.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.name;
    data['value'] = this.value;
    return data;
  }
}

class CarParts {
  List<CarManufacturer> carManufacturers;
  DataSupplier dataSupplier;
  //List<Null> packageComponents;
  String dataSupplierReference;
  bool isAmerigo;
  String dataSupplierReferenceOriginal;
  bool addToCart;
  String codFou;
  DataSupplier subcategory;
  String image;
  List<String> replacements;
  String replacementsList;
  List<Tags> tags;
  int price;
  Null promotionPrice;
  int available;
  int quantity;
  String genartnr;
  //List<Null> equivalences;
  bool isFavorite;
  Barcode barcode;

  CarParts(
      {this.carManufacturers,
        this.dataSupplier,
        //this.packageComponents,
        this.dataSupplierReference,
        this.isAmerigo,
        this.dataSupplierReferenceOriginal,
        this.addToCart,
        this.codFou,
        this.subcategory,
        this.image,
        this.replacements,
        this.replacementsList,
        this.tags,
        this.price,
        this.promotionPrice,
        this.available,
        this.quantity,
        this.genartnr,
        //this.equivalences,
        this.isFavorite,
        this.barcode});

  CarParts.fromJson(Map<String, dynamic> json) {
    if (json['car_manufacturers'] != null) {
      carManufacturers = [];
      json['car_manufacturers'].forEach((v) {
        if(json['id'] is int) {
          carManufacturers.add(CarManufacturer.fromJson(v));
        }
      });
    }
    dataSupplier = json['data_supplier'] != null
        ? DataSupplier.fromJson(json['data_supplier'])
        : null;
/*    if (json['package_components'] != null) {
      packageComponents = List<Null>();
      json['package_components'].forEach((v) {
        packageComponents.add(Null.fromJson(v));
      });
    }*/
    dataSupplierReference = json['data_supplier_reference'];
    isAmerigo = json['is_amerigo'];
    dataSupplierReferenceOriginal = json['data_supplier_reference_original'];
    addToCart = json['add_to_cart'];
    codFou = json['cod_fou'];
    subcategory = json['subcategory'] != null
        ? DataSupplier.fromJson(json['subcategory'])
        : null;
    image = json['image'];
    replacements = json['replacements'].cast<String>();
    replacementsList = json['replacements_list'];
    if (json['tags'] != null) {
      tags = <Tags>[];
      json['tags'].forEach((v) {
        tags.add(Tags.fromJson(v));
      });
    }
    price = json['price'];
    promotionPrice = json['promotion_price'];
    available = json['available'];
    quantity = json['quantity'];
    genartnr = json['genartnr'];
/*    if (json['equivalences'] != null) {
      equivalences = List<Null>();
      json['equivalences'].forEach((v) {
        equivalences.add(Null.fromJson(v));
      });
    }*/
    isFavorite = json['is_favorite'];
    barcode =
    json['barcode'] != null ? Barcode.fromJson(json['barcode']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.carManufacturers != null) {
      data['car_manufacturers'] =
          this.carManufacturers.map((v) => v.toJson()).toList();
    }
    if (this.dataSupplier != null) {
      data['data_supplier'] = this.dataSupplier.toJson();
    }
    /*   if (this.packageComponents != null) {
      data['package_components'] =
          this.packageComponents.map((v) => v.toJson()).toList();
    }*/
    data['data_supplier_reference'] = this.dataSupplierReference;
    data['is_amerigo'] = this.isAmerigo;
    data['data_supplier_reference_original'] =
        this.dataSupplierReferenceOriginal;
    data['add_to_cart'] = this.addToCart;
    data['cod_fou'] = this.codFou;
    if (this.subcategory != null) {
      data['subcategory'] = this.subcategory.toJson();
    }
    data['image'] = this.image;
    data['replacements'] = this.replacements;
    data['replacements_list'] = this.replacementsList;
    if (this.tags != null) {
      data['tags'] = this.tags.map((v) => v.toJson()).toList();
    }
    data['price'] = this.price;
    data['promotion_price'] = this.promotionPrice;
    data['available'] = this.available;
    data['quantity'] = this.quantity;
    data['genartnr'] = this.genartnr;
/*    if (this.equivalences != null) {
      data['equivalences'] = this.equivalences.map((v) => v.toJson()).toList();
    }*/
    data['is_favorite'] = this.isFavorite;
    if (this.barcode != null) {
      data['barcode'] = this.barcode.toJson();
    }
    return data;
  }
}

class CarManufacturer {
  String name;
  int id;

  CarManufacturer({this.name, this.id});

  CarManufacturer.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }
}

class DataSupplier {
  String id;
  String name;

  DataSupplier({this.id, this.name});

  DataSupplier.fromJson(Map<String, dynamic> json) {
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

class Barcode {
  String code;
  String image;

  Barcode({this.code, this.image});

  Barcode.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['code'] = this.code;
    data['image'] = this.image;
    return data;
  }
}
