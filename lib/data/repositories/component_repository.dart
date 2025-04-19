import '../database/database_helper.dart';
import '../models/component_models.dart';

class ComponentRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  // CPU methods
  Future<List<CPU>> getAllCPUs() async {
    return await _databaseHelper.getCPUs();
  }

  Future<List<CPU>> getCPUsByUseCase(String useCase) async {
    return await _databaseHelper.getCPUsByUseCase(useCase);
  }

  Future<CPU?> getCPUById(int id) async {
    return await _databaseHelper.getCPUById(id);
  }

  // GPU methods
  Future<List<GPU>> getAllGPUs() async {
    return await _databaseHelper.getGPUs();
  }

  Future<List<GPU>> getGPUsByUseCase(String useCase) async {
    return await _databaseHelper.getGPUsByUseCase(useCase);
  }

  Future<GPU?> getGPUById(int id) async {
    return await _databaseHelper.getGPUById(id);
  }

  // RAM methods
  Future<List<RAM>> getAllRAMs() async {
    return await _databaseHelper.getRAMs();
  }

  Future<List<RAM>> getRAMsByUseCase(String useCase) async {
    return await _databaseHelper.getRAMsByUseCase(useCase);
  }

  Future<RAM?> getRAMById(int id) async {
    return await _databaseHelper.getRAMById(id);
  }

  // Storage methods
  Future<List<Storage>> getAllStorages() async {
    return await _databaseHelper.getStorages();
  }

  Future<List<Storage>> getStoragesByUseCase(String useCase) async {
    return await _databaseHelper.getStoragesByUseCase(useCase);
  }

  Future<Storage?> getStorageById(int id) async {
    return await _databaseHelper.getStorageById(id);
  }

  // Motherboard methods
  Future<List<Motherboard>> getAllMotherboards() async {
    return await _databaseHelper.getMotherboards();
  }

  Future<List<Motherboard>> getMotherboardsByUseCase(String useCase) async {
    return await _databaseHelper.getMotherboardsByUseCase(useCase);
  }

  Future<Motherboard?> getMotherboardById(int id) async {
    return await _databaseHelper.getMotherboardById(id);
  }

  // PSU methods
  Future<List<PSU>> getAllPSUs() async {
    return await _databaseHelper.getPSUs();
  }

  Future<List<PSU>> getPSUsByUseCase(String useCase) async {
    return await _databaseHelper.getPSUsByUseCase(useCase);
  }

  Future<PSU?> getPSUById(int id) async {
    return await _databaseHelper.getPSUById(id);
  }

  Future<PSU?> getRecommendedPSU(int requiredWattage) async {
    return await _databaseHelper.getRecommendedPSU(requiredWattage);
  }

  // Preset Build methods
  Future<List<PresetBuild>> getAllPresetBuilds() async {
    return await _databaseHelper.getPresetBuilds();
  }

  Future<List<PresetBuild>> getPresetBuildsByTypeAndUseCase(
      String type, String useCase) async {
    return await _databaseHelper.getPresetBuildsByTypeAndUseCase(type, useCase);
  }

  Future<PresetBuild?> getPresetBuildById(int id) async {
    return await _databaseHelper.getPresetBuildById(id);
  }

  // Calculate total wattage for a build
  Future<int> calculateTotalWattage({
    required int cpuId,
    required int gpuId,
    int? additionalWattage = 0,
  }) async {
    int totalWattage = additionalWattage ?? 0;

    final cpu = await getCPUById(cpuId);
    if (cpu != null) {
      totalWattage += cpu.tdp;
    }

    final gpu = await getGPUById(gpuId);
    if (gpu != null) {
      totalWattage += gpu.tdp;
    }

    // Add a base wattage for other components (motherboard, RAM, storage, etc.)
    totalWattage += 50;

    return totalWattage;
  }

  // Get supported software for a build
  Future<List<String>> getSupportedSoftware({
    required int cpuId,
    required int gpuId,
  }) async {
    Set<String> supportedSoftware = {};

    final cpu = await getCPUById(cpuId);
    if (cpu != null) {
      supportedSoftware.addAll(cpu.supportedSoftware);
    }

    final gpu = await getGPUById(gpuId);
    if (gpu != null) {
      supportedSoftware.addAll(gpu.supportedSoftware);
    }

    return supportedSoftware.toList();
  }
}
