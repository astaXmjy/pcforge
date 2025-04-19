// Add these classes to the component_models.dart file

class LaptopCPU {
  final int id;
  final String name;
  final String brand;
  final int cores;
  final double clockSpeed;
  final int tdp;
  final double benchmarkScore;
  final List<String> supportedSoftware;
  final String useCase;

  LaptopCPU({
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

  factory LaptopCPU.fromJson(Map<String, dynamic> json) {
    return LaptopCPU(
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

  factory LaptopCPU.fromMap(Map<String, dynamic> map) {
    return LaptopCPU(
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

class LaptopGPU {
  final int id;
  final String name;
  final String brand;
  final int vram;
  final int tdp;
  final double benchmarkScore;
  final List<String> supportedSoftware;
  final String useCase;

  LaptopGPU({
    required this.id,
    required this.name,
    required this.brand,
    required this.vram,
    required this.tdp,
    required this.benchmarkScore,
    required this.supportedSoftware,
    required this.useCase,
  });

  factory LaptopGPU.fromJson(Map<String, dynamic> json) {
    return LaptopGPU(
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

  factory LaptopGPU.fromMap(Map<String, dynamic> map) {
    return LaptopGPU(
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

class LaptopRAM {
  final int id;
  final String name;
  final String brand;
  final int capacity;
  final String type;
  final int speed;
  final String useCase;

  LaptopRAM({
    required this.id,
    required this.name,
    required this.brand,
    required this.capacity,
    required this.type,
    required this.speed,
    required this.useCase,
  });

  factory LaptopRAM.fromJson(Map<String, dynamic> json) {
    return LaptopRAM(
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

  factory LaptopRAM.fromMap(Map<String, dynamic> map) {
    return LaptopRAM(
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

class LaptopStorage {
  final int id;
  final String name;
  final String brand;
  final int capacity;
  final String type;
  final String interface;
  final String useCase;

  LaptopStorage({
    required this.id,
    required this.name,
    required this.brand,
    required this.capacity,
    required this.type,
    required this.interface,
    required this.useCase,
  });

  factory LaptopStorage.fromJson(Map<String, dynamic> json) {
    return LaptopStorage(
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

  factory LaptopStorage.fromMap(Map<String, dynamic> map) {
    return LaptopStorage(
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

class LaptopPresetBuild {
  final int id;
  final String name;
  final String type;
  final String useCase;
  final int cpuId;
  final int gpuId;
  final int ramId;
  final int storageId;
  final int displayId;
  final int? batteryId;

  LaptopPresetBuild({
    required this.id,
    required this.name,
    required this.type,
    required this.useCase,
    required this.cpuId,
    required this.gpuId,
    required this.ramId,
    required this.storageId,
    required this.displayId,
    this.batteryId,
  });

  factory LaptopPresetBuild.fromJson(Map<String, dynamic> json) {
    return LaptopPresetBuild(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      useCase: json['useCase'],
      cpuId: json['cpuId'],
      gpuId: json['gpuId'],
      ramId: json['ramId'],
      storageId: json['storageId'],
      displayId: json['displayId'],
      batteryId: json['batteryId'],
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
      'displayId': displayId,
      'batteryId': batteryId,
    };
  }

  factory LaptopPresetBuild.fromMap(Map<String, dynamic> map) {
    return LaptopPresetBuild(
      id: map['id'],
      name: map['name'],
      type: map['type'],
      useCase: map['useCase'],
      cpuId: map['cpuId'],
      gpuId: map['gpuId'],
      ramId: map['ramId'],
      storageId: map['storageId'],
      displayId: map['displayId'],
      batteryId: map['batteryId'],
    );
  }
}

class LaptopDisplay {
  final int id;
  final String name;
  final String resolution;
  final double size;
  final int refreshRate;
  final String panelType;
  final String useCase;

  LaptopDisplay({
    required this.id,
    required this.name,
    required this.resolution,
    required this.size,
    required this.refreshRate,
    required this.panelType,
    required this.useCase,
  });

  factory LaptopDisplay.fromJson(Map<String, dynamic> json) {
    return LaptopDisplay(
      id: json['id'],
      name: json['name'],
      resolution: json['resolution'],
      size: json['size'].toDouble(),
      refreshRate: json['refreshRate'],
      panelType: json['panelType'],
      useCase: json['useCase'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'resolution': resolution,
      'size': size,
      'refreshRate': refreshRate,
      'panelType': panelType,
      'useCase': useCase,
    };
  }

  factory LaptopDisplay.fromMap(Map<String, dynamic> map) {
    return LaptopDisplay(
      id: map['id'],
      name: map['name'],
      resolution: map['resolution'],
      size: map['size'],
      refreshRate: map['refreshRate'],
      panelType: map['panelType'],
      useCase: map['useCase'],
    );
  }
}

class LaptopBattery {
  final int id;
  final String name;
  final int capacity;
  final int batteryLife;
  final String useCase;

  LaptopBattery({
    required this.id,
    required this.name,
    required this.capacity,
    required this.batteryLife,
    required this.useCase,
  });

  factory LaptopBattery.fromJson(Map<String, dynamic> json) {
    return LaptopBattery(
      id: json['id'],
      name: json['name'],
      capacity: json['capacity'],
      batteryLife: json['batteryLife'],
      useCase: json['useCase'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'capacity': capacity,
      'batteryLife': batteryLife,
      'useCase': useCase,
    };
  }

  factory LaptopBattery.fromMap(Map<String, dynamic> map) {
    return LaptopBattery(
      id: map['id'],
      name: map['name'],
      capacity: map['capacity'],
      batteryLife: map['batteryLife'],
      useCase: map['useCase'],
    );
  }
}

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
