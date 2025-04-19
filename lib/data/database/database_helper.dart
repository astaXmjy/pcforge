import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../models/component_models.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'pc_forge.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Create CPU table
    await db.execute('''
      CREATE TABLE cpus(
        id INTEGER PRIMARY KEY,
        name TEXT,
        brand TEXT,
        cores INTEGER,
        clockSpeed REAL,
        tdp INTEGER,
        benchmarkScore REAL,
        supportedSoftware TEXT,
        useCase TEXT
      )
    ''');

    // Create GPU table
    await db.execute('''
      CREATE TABLE gpus(
        id INTEGER PRIMARY KEY,
        name TEXT,
        brand TEXT,
        vram INTEGER,
        tdp INTEGER,
        benchmarkScore REAL,
        supportedSoftware TEXT,
        useCase TEXT
      )
    ''');

    // Create RAM table
    await db.execute('''
      CREATE TABLE rams(
        id INTEGER PRIMARY KEY,
        name TEXT,
        brand TEXT,
        capacity INTEGER,
        type TEXT,
        speed INTEGER,
        useCase TEXT
      )
    ''');

    // Create Storage table
    await db.execute('''
      CREATE TABLE storages(
        id INTEGER PRIMARY KEY,
        name TEXT,
        brand TEXT,
        capacity INTEGER,
        type TEXT,
        interface TEXT,
        useCase TEXT
      )
    ''');

    // Create Motherboard table
    await db.execute('''
      CREATE TABLE motherboards(
        id INTEGER PRIMARY KEY,
        name TEXT,
        brand TEXT,
        chipset TEXT,
        socketType TEXT,
        formFactor TEXT,
        useCase TEXT
      )
    ''');

    // Create PSU table
    await db.execute('''
      CREATE TABLE psus(
        id INTEGER PRIMARY KEY,
        name TEXT,
        brand TEXT,
        wattage INTEGER,
        certification TEXT,
        useCase TEXT
      )
    ''');

    // Create Preset Builds table
    await db.execute('''
      CREATE TABLE preset_builds(
        id INTEGER PRIMARY KEY,
        name TEXT,
        type TEXT,
        useCase TEXT,
        cpuId INTEGER,
        gpuId INTEGER,
        ramId INTEGER,
        storageId INTEGER,
        motherboardId INTEGER,
        psuId INTEGER
      )
    ''');

    // Load initial data
    await _loadInitialData(db);
  }

  Future<void> _loadInitialData(Database db) async {
    // Load CPUs
    String cpuJson = await rootBundle.loadString('assets/data/cpu.json');
    List<dynamic> cpuList = json.decode(cpuJson);
    for (var cpu in cpuList) {
      await db.insert('cpus', CPU.fromJson(cpu).toMap());
    }

    // Load GPUs
    String gpuJson = await rootBundle.loadString('assets/data/gpu.json');
    List<dynamic> gpuList = json.decode(gpuJson);
    for (var gpu in gpuList) {
      await db.insert('gpus', GPU.fromJson(gpu).toMap());
    }

    // Load RAMs
    String ramJson = await rootBundle.loadString('assets/data/ram.json');
    List<dynamic> ramList = json.decode(ramJson);
    for (var ram in ramList) {
      await db.insert('rams', RAM.fromJson(ram).toMap());
    }

    // Load Storages
    String storageJson =
        await rootBundle.loadString('assets/data/storage.json');
    List<dynamic> storageList = json.decode(storageJson);
    for (var storage in storageList) {
      await db.insert('storages', Storage.fromJson(storage).toMap());
    }

    // Load Motherboards
    String motherboardJson =
        await rootBundle.loadString('assets/data/motherboard.json');
    List<dynamic> motherboardList = json.decode(motherboardJson);
    for (var motherboard in motherboardList) {
      await db.insert(
          'motherboards', Motherboard.fromJson(motherboard).toMap());
    }

    // Load PSUs
    String psuJson = await rootBundle.loadString('assets/data/psu.json');
    List<dynamic> psuList = json.decode(psuJson);
    for (var psu in psuList) {
      await db.insert('psus', PSU.fromJson(psu).toMap());
    }

    // Load Preset Builds
    String presetJson = await rootBundle.loadString('assets/data/presets.json');
    List<dynamic> presetList = json.decode(presetJson);
    for (var preset in presetList) {
      await db.insert('preset_builds', PresetBuild.fromJson(preset).toMap());
    }
  }

  // CPU methods
  Future<List<CPU>> getCPUs() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('cpus');
    return List.generate(maps.length, (i) => CPU.fromMap(maps[i]));
  }

  Future<List<CPU>> getCPUsByUseCase(String useCase) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'cpus',
      where: 'useCase = ?',
      whereArgs: [useCase],
    );
    return List.generate(maps.length, (i) => CPU.fromMap(maps[i]));
  }

  Future<CPU?> getCPUById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'cpus',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return CPU.fromMap(maps.first);
    }
    return null;
  }

  // GPU methods
  Future<List<GPU>> getGPUs() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('gpus');
    return List.generate(maps.length, (i) => GPU.fromMap(maps[i]));
  }

  Future<List<GPU>> getGPUsByUseCase(String useCase) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'gpus',
      where: 'useCase = ?',
      whereArgs: [useCase],
    );
    return List.generate(maps.length, (i) => GPU.fromMap(maps[i]));
  }

  Future<GPU?> getGPUById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'gpus',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return GPU.fromMap(maps.first);
    }
    return null;
  }

  // RAM methods
  Future<List<RAM>> getRAMs() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('rams');
    return List.generate(maps.length, (i) => RAM.fromMap(maps[i]));
  }

  Future<List<RAM>> getRAMsByUseCase(String useCase) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'rams',
      where: 'useCase = ?',
      whereArgs: [useCase],
    );
    return List.generate(maps.length, (i) => RAM.fromMap(maps[i]));
  }

  Future<RAM?> getRAMById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'rams',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return RAM.fromMap(maps.first);
    }
    return null;
  }

  // Storage methods
  Future<List<Storage>> getStorages() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('storages');
    return List.generate(maps.length, (i) => Storage.fromMap(maps[i]));
  }

  Future<List<Storage>> getStoragesByUseCase(String useCase) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'storages',
      where: 'useCase = ?',
      whereArgs: [useCase],
    );
    return List.generate(maps.length, (i) => Storage.fromMap(maps[i]));
  }

  Future<Storage?> getStorageById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'storages',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Storage.fromMap(maps.first);
    }
    return null;
  }

  // Motherboard methods
  Future<List<Motherboard>> getMotherboards() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('motherboards');
    return List.generate(maps.length, (i) => Motherboard.fromMap(maps[i]));
  }

  Future<List<Motherboard>> getMotherboardsByUseCase(String useCase) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'motherboards',
      where: 'useCase = ?',
      whereArgs: [useCase],
    );
    return List.generate(maps.length, (i) => Motherboard.fromMap(maps[i]));
  }

  Future<Motherboard?> getMotherboardById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'motherboards',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Motherboard.fromMap(maps.first);
    }
    return null;
  }

  // PSU methods
  Future<List<PSU>> getPSUs() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('psus');
    return List.generate(maps.length, (i) => PSU.fromMap(maps[i]));
  }

  Future<List<PSU>> getPSUsByUseCase(String useCase) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'psus',
      where: 'useCase = ?',
      whereArgs: [useCase],
    );
    return List.generate(maps.length, (i) => PSU.fromMap(maps[i]));
  }

  Future<PSU?> getPSUById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'psus',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return PSU.fromMap(maps.first);
    }
    return null;
  }

  // Get PSU by wattage requirement
  Future<PSU?> getRecommendedPSU(int requiredWattage) async {
    final db = await database;
    // Add 20% headroom to the required wattage
    int recommendedWattage = (requiredWattage * 1.2).ceil();

    // Find the smallest PSU that can handle the recommended wattage
    final List<Map<String, dynamic>> maps = await db.query(
      'psus',
      where: 'wattage >= ?',
      whereArgs: [recommendedWattage],
      orderBy: 'wattage ASC',
      limit: 1,
    );

    if (maps.isNotEmpty) {
      return PSU.fromMap(maps.first);
    }

    // If no PSU found, return the highest wattage PSU
    final List<Map<String, dynamic>> highestWattageMaps = await db.query(
      'psus',
      orderBy: 'wattage DESC',
      limit: 1,
    );

    if (highestWattageMaps.isNotEmpty) {
      return PSU.fromMap(highestWattageMaps.first);
    }

    return null;
  }

  // Preset Build methods
  Future<List<PresetBuild>> getPresetBuilds() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('preset_builds');
    return List.generate(maps.length, (i) => PresetBuild.fromMap(maps[i]));
  }

  Future<List<PresetBuild>> getPresetBuildsByTypeAndUseCase(
      String type, String useCase) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'preset_builds',
      where: 'type = ? AND useCase = ?',
      whereArgs: [type, useCase],
    );
    return List.generate(maps.length, (i) => PresetBuild.fromMap(maps[i]));
  }

  Future<PresetBuild?> getPresetBuildById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'preset_builds',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return PresetBuild.fromMap(maps.first);
    }
    return null;
  }
}
