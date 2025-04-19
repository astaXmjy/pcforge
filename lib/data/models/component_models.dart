class CPU {
  final int id;
  final String name;
  final String brand;
  final int cores;
  final double clockSpeed;
  final int tdp; // Thermal Design Power in watts
  final double benchmarkScore;
  final List<String> supportedSoftware;
  final String useCase; // gaming, editing, cad, etc.

  CPU({
    required this.id,
    required this.name,
    required this.brand,
    required this.cores,
    required this.clockSpeed,
    required this.tdp,
    required this.benchmarkScore,
    required this.supportedSoftware,
    required this.useCase,
  });

  factory CPU.fromJson(Map<String, dynamic> json) {
    return CPU(
      id: json['id'],
      name: json['name'],
      brand: json['brand'],
      cores: json['cores'],
      clockSpeed: json['clockSpeed'],
      tdp: json['tdp'],
      benchmarkScore: json['benchmarkScore'].toDouble(),
      supportedSoftware: List<String>.from(json['supportedSoftware']),
      useCase: json['useCase'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'cores': cores,
      'clockSpeed': clockSpeed,
      'tdp': tdp,
      'benchmarkScore': benchmarkScore,
      'supportedSoftware': supportedSoftware,
      'useCase': useCase,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'cores': cores,
      'clockSpeed': clockSpeed,
      'tdp': tdp,
      'benchmarkScore': benchmarkScore,
      'supportedSoftware': supportedSoftware.join(','),
      'useCase': useCase,
    };
  }

  factory CPU.fromMap(Map<String, dynamic> map) {
    return CPU(
      id: map['id'],
      name: map['name'],
      brand: map['brand'],
      cores: map['cores'],
      clockSpeed: map['clockSpeed'],
      tdp: map['tdp'],
      benchmarkScore: map['benchmarkScore'],
      supportedSoftware: map['supportedSoftware'].split(','),
      useCase: map['useCase'],
    );
  }
}

class GPU {
  final int id;
  final String name;
  final String brand;
  final int vram;
  final int tdp;
  final double benchmarkScore;
  final List<String> supportedSoftware;
  final String useCase;

  GPU({
    required this.id,
    required this.name,
    required this.brand,
    required this.vram,
    required this.tdp,
    required this.benchmarkScore,
    required this.supportedSoftware,
    required this.useCase,
  });

  factory GPU.fromJson(Map<String, dynamic> json) {
    return GPU(
      id: json['id'],
      name: json['name'],
      brand: json['brand'],
      vram: json['vram'],
      tdp: json['tdp'],
      benchmarkScore: json['benchmarkScore'].toDouble(),
      supportedSoftware: List<String>.from(json['supportedSoftware']),
      useCase: json['useCase'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'vram': vram,
      'tdp': tdp,
      'benchmarkScore': benchmarkScore,
      'supportedSoftware': supportedSoftware,
      'useCase': useCase,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'vram': vram,
      'tdp': tdp,
      'benchmarkScore': benchmarkScore,
      'supportedSoftware': supportedSoftware.join(','),
      'useCase': useCase,
    };
  }

  factory GPU.fromMap(Map<String, dynamic> map) {
    return GPU(
      id: map['id'],
      name: map['name'],
      brand: map['brand'],
      vram: map['vram'],
      tdp: map['tdp'],
      benchmarkScore: map['benchmarkScore'],
      supportedSoftware: map['supportedSoftware'].split(','),
      useCase: map['useCase'],
    );
  }
}

class RAM {
  final int id;
  final String name;
  final String brand;
  final int capacity;
  final String type; // DDR4, DDR5, etc.
  final int speed;
  final String useCase;

  RAM({
    required this.id,
    required this.name,
    required this.brand,
    required this.capacity,
    required this.type,
    required this.speed,
    required this.useCase,
  });

  factory RAM.fromJson(Map<String, dynamic> json) {
    return RAM(
      id: json['id'],
      name: json['name'],
      brand: json['brand'],
      capacity: json['capacity'],
      type: json['type'],
      speed: json['speed'],
      useCase: json['useCase'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'capacity': capacity,
      'type': type,
      'speed': speed,
      'useCase': useCase,
    };
  }

  factory RAM.fromMap(Map<String, dynamic> map) {
    return RAM(
      id: map['id'],
      name: map['name'],
      brand: map['brand'],
      capacity: map['capacity'],
      type: map['type'],
      speed: map['speed'],
      useCase: map['useCase'],
    );
  }
}

class Storage {
  final int id;
  final String name;
  final String brand;
  final int capacity;
  final String type; // SSD, HDD, etc.
  final String interface; // SATA, NVMe, etc.
  final String useCase;

  Storage({
    required this.id,
    required this.name,
    required this.brand,
    required this.capacity,
    required this.type,
    required this.interface,
    required this.useCase,
  });

  factory Storage.fromJson(Map<String, dynamic> json) {
    return Storage(
      id: json['id'],
      name: json['name'],
      brand: json['brand'],
      capacity: json['capacity'],
      type: json['type'],
      interface: json['interface'],
      useCase: json['useCase'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'capacity': capacity,
      'type': type,
      'interface': interface,
      'useCase': useCase,
    };
  }

  factory Storage.fromMap(Map<String, dynamic> map) {
    return Storage(
      id: map['id'],
      name: map['name'],
      brand: map['brand'],
      capacity: map['capacity'],
      type: map['type'],
      interface: map['interface'],
      useCase: map['useCase'],
    );
  }
}

class Motherboard {
  final int id;
  final String name;
  final String brand;
  final String chipset;
  final String socketType;
  final String formFactor;
  final String useCase;

  Motherboard({
    required this.id,
    required this.name,
    required this.brand,
    required this.chipset,
    required this.socketType,
    required this.formFactor,
    required this.useCase,
  });

  factory Motherboard.fromJson(Map<String, dynamic> json) {
    return Motherboard(
      id: json['id'],
      name: json['name'],
      brand: json['brand'],
      chipset: json['chipset'],
      socketType: json['socketType'],
      formFactor: json['formFactor'],
      useCase: json['useCase'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'chipset': chipset,
      'socketType': socketType,
      'formFactor': formFactor,
      'useCase': useCase,
    };
  }

  factory Motherboard.fromMap(Map<String, dynamic> map) {
    return Motherboard(
      id: map['id'],
      name: map['name'],
      brand: map['brand'],
      chipset: map['chipset'],
      socketType: map['socketType'],
      formFactor: map['formFactor'],
      useCase: map['useCase'],
    );
  }
}

class PSU {
  final int id;
  final String name;
  final String brand;
  final int wattage;
  final String certification; // 80+ Bronze, Gold, etc.
  final String useCase;

  PSU({
    required this.id,
    required this.name,
    required this.brand,
    required this.wattage,
    required this.certification,
    required this.useCase,
  });

  factory PSU.fromJson(Map<String, dynamic> json) {
    return PSU(
      id: json['id'],
      name: json['name'],
      brand: json['brand'],
      wattage: json['wattage'],
      certification: json['certification'],
      useCase: json['useCase'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'wattage': wattage,
      'certification': certification,
      'useCase': useCase,
    };
  }

  factory PSU.fromMap(Map<String, dynamic> map) {
    return PSU(
      id: map['id'],
      name: map['name'],
      brand: map['brand'],
      wattage: map['wattage'],
      certification: map['certification'],
      useCase: map['useCase'],
    );
  }
}

class PresetBuild {
  final int id;
  final String name;
  final String type; // PC or Laptop
  final String useCase; // Gaming, Editing, CAD
  final int cpuId;
  final int gpuId;
  final int ramId;
  final int storageId;
  final int motherboardId;
  final int? psuId; // Optional for laptops

  PresetBuild({
    required this.id,
    required this.name,
    required this.type,
    required this.useCase,
    required this.cpuId,
    required this.gpuId,
    required this.ramId,
    required this.storageId,
    required this.motherboardId,
    this.psuId,
  });

  factory PresetBuild.fromJson(Map<String, dynamic> json) {
    return PresetBuild(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      useCase: json['useCase'],
      cpuId: json['cpuId'],
      gpuId: json['gpuId'],
      ramId: json['ramId'],
      storageId: json['storageId'],
      motherboardId: json['motherboardId'],
      psuId: json['psuId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'useCase': useCase,
      'cpuId': cpuId,
      'gpuId': gpuId,
      'ramId': ramId,
      'storageId': storageId,
      'motherboardId': motherboardId,
      'psuId': psuId,
    };
  }

  factory PresetBuild.fromMap(Map<String, dynamic> map) {
    return PresetBuild(
      id: map['id'],
      name: map['name'],
      type: map['type'],
      useCase: map['useCase'],
      cpuId: map['cpuId'],
      gpuId: map['gpuId'],
      ramId: map['ramId'],
      storageId: map['storageId'],
      motherboardId: map['motherboardId'],
      psuId: map['psuId'],
    );
  }
}
