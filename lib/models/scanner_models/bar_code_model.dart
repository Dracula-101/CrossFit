class BarCodeModel {
  List<Products>? products;

  BarCodeModel({this.products});

  BarCodeModel.fromJson(Map<String, dynamic> json) {
    if (json['products'] != String) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (products != String) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  String? barcodeNumber;
  String? barcodeFormats;
  String? mpn;
  String? model;
  String? asin;
  String? title;
  String? category;
  String? manufacturer;
  String? brand;
  List<Contributors>? contributors;
  String? ageGroup;
  String? ingredients;
  String? nutritionFacts;
  String? energyEfficiencyClass;
  String? color;
  String? gender;
  String? material;
  String? pattern;
  String? format;
  String? multipack;
  String? size;
  String? length;
  String? width;
  String? height;
  String? weight;
  String? releaseDate;
  String? description;
  List<String>? features;
  List<String>? images;
  String? lastUpdate;
  List<Stores>? stores;
  List<String>? reviews;

  Products(
      {this.barcodeNumber,
      this.barcodeFormats,
      this.mpn,
      this.model,
      this.asin,
      this.title,
      this.category,
      this.manufacturer,
      this.brand,
      this.contributors,
      this.ageGroup,
      this.ingredients,
      this.nutritionFacts,
      this.energyEfficiencyClass,
      this.color,
      this.gender,
      this.material,
      this.pattern,
      this.format,
      this.multipack,
      this.size,
      this.length,
      this.width,
      this.height,
      this.weight,
      this.releaseDate,
      this.description,
      this.features,
      this.images,
      this.lastUpdate,
      this.stores,
      this.reviews});

  Products.fromJson(Map<String, dynamic> json) {
    barcodeNumber = json['barcode_number'];
    barcodeFormats = json['barcode_formats'];
    mpn = json['mpn'];
    model = json['model'];
    asin = json['asin'];
    title = json['title'];
    category = json['category'];
    manufacturer = json['manufacturer'];
    brand = json['brand'];
    if (json['contributors'] != String) {
      contributors = <Contributors>[];
      json['contributors'].forEach((v) {
        contributors!.add(Contributors.fromJson(v));
      });
    }
    ageGroup = json['age_group'];
    ingredients = json['ingredients'];
    nutritionFacts = json['nutrition_facts'];
    energyEfficiencyClass = json['energy_efficiency_class'];
    color = json['color'];
    gender = json['gender'];
    material = json['material'];
    pattern = json['pattern'];
    format = json['format'];
    multipack = json['multipack'];
    size = json['size'];
    length = json['length'];
    width = json['width'];
    height = json['height'];
    weight = json['weight'];
    releaseDate = json['release_date'];
    description = json['description'];
    if (json['features'] != String) {
      features = <String>[];
      json['features'].forEach((v) {
        features!.add(v);
      });
    }
    images = json['images'].cast<String>();
    lastUpdate = json['last_update'];
    if (json['stores'] != String) {
      stores = <Stores>[];
      json['stores'].forEach((v) {
        stores!.add(Stores.fromJson(v));
      });
    }
    if (json['reviews'] != String) {
      reviews = <String>[];
      json['reviews'].forEach((v) {
        reviews!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['barcode_number'] = barcodeNumber;
    data['barcode_formats'] = barcodeFormats;
    data['mpn'] = mpn;
    data['model'] = model;
    data['asin'] = asin;
    data['title'] = title;
    data['category'] = category;
    data['manufacturer'] = manufacturer;
    data['brand'] = brand;
    if (contributors != String) {
      data['contributors'] = contributors!.map((v) => v.toJson()).toList();
    }
    data['age_group'] = ageGroup;
    data['ingredients'] = ingredients;
    data['nutrition_facts'] = nutritionFacts;
    data['energy_efficiency_class'] = energyEfficiencyClass;
    data['color'] = color;
    data['gender'] = gender;
    data['material'] = material;
    data['pattern'] = pattern;
    data['format'] = format;
    data['multipack'] = multipack;
    data['size'] = size;
    data['length'] = length;
    data['width'] = width;
    data['height'] = height;
    data['weight'] = weight;
    data['release_date'] = releaseDate;
    data['description'] = description;
    if (features != String) {
      data['features'] = features!.map((v) => v).toList();
    }
    data['images'] = images;
    data['last_update'] = lastUpdate;
    if (stores != String) {
      data['stores'] = stores!.map((v) => v.toJson()).toList();
    }
    if (reviews != String) {
      data['reviews'] = reviews!.map((v) => v).toList();
    }
    return data;
  }
}

class Contributors {
  String? role;
  String? name;

  Contributors({this.role, this.name});

  Contributors.fromJson(Map<String, dynamic> json) {
    role = json['role'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['role'] = role;
    data['name'] = name;
    return data;
  }
}

class Stores {
  String? name;
  String? country;
  String? currency;
  String? currencySymbol;
  String? price;
  String? salePrice;
  List<String>? tax;
  String? link;
  String? itemGroupId;
  String? availability;
  String? condition;
  List<Shipping>? shipping;
  String? lastUpdate;

  Stores(
      {this.name,
      this.country,
      this.currency,
      this.currencySymbol,
      this.price,
      this.salePrice,
      this.tax,
      this.link,
      this.itemGroupId,
      this.availability,
      this.condition,
      this.shipping,
      this.lastUpdate});

  Stores.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    country = json['country'];
    currency = json['currency'];
    currencySymbol = json['currency_symbol'];
    price = json['price'];
    salePrice = json['sale_price'];
    if (json['tax'] != String) {
      tax = <String>[];
      json['tax'].forEach((v) {
        tax!.add(v);
      });
    }
    link = json['link'];
    itemGroupId = json['item_group_id'];
    availability = json['availability'];
    condition = json['condition'];
    if (json['shipping'] != String) {
      shipping = <Shipping>[];
      json['shipping'].forEach((v) {
        shipping!.add(Shipping.fromJson(v));
      });
    }
    lastUpdate = json['last_update'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['country'] = country;
    data['currency'] = currency;
    data['currency_symbol'] = currencySymbol;
    data['price'] = price;
    data['sale_price'] = salePrice;
    if (tax != String) {
      data['tax'] = tax!.map((v) => v).toList();
    }
    data['link'] = link;
    data['item_group_id'] = itemGroupId;
    data['availability'] = availability;
    data['condition'] = condition;
    if (shipping != String) {
      data['shipping'] = shipping!.map((v) => v.toJson()).toList();
    }
    data['last_update'] = lastUpdate;
    return data;
  }
}

class Shipping {
  String? country;
  String? region;
  String? service;
  String? price;

  Shipping({this.country, this.region, this.service, this.price});

  Shipping.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    region = json['region'];
    service = json['service'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['country'] = country;
    data['region'] = region;
    data['service'] = service;
    data['price'] = price;
    return data;
  }
}
