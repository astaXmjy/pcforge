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
  // Add these methods to the ComponentRepository class

// Laptop CPU methods
  Future<List<LaptopCPU>> getAllLaptopCPUs() async {
    return await _databaseHelper.getLaptopCPUs();
  }

  Future<List<LaptopCPU>> getLaptopCPUsByUseCase(String useCase) async {
    return await _databaseHelper.getLaptopCPUsByUseCase(useCase);
  }

  Future<LaptopCPU?> getLaptopCPUById(int id) async {
    return await _databaseHelper.getLaptopCPUById(id);
  }

// Laptop GPU methods
  Future<List<LaptopGPU>> getAllLaptopGPUs() async {
    return await _databaseHelper.getLaptopGPUs();
  }

  Future<List<LaptopGPU>> getLaptopGPUsByUseCase(String useCase) async {
    return await _databaseHelper.getLaptopGPUsByUseCase(useCase);
  }

  Future<LaptopGPU?> getLaptopGPUById(int id) async {
    return await _databaseHelper.getLaptopGPUById(id);
  }

// Laptop RAM methods
  Future<List<LaptopRAM>> getAllLaptopRAMs() async {
    return await _databaseHelper.getLaptopRAMs();
  }

  Future<List<LaptopRAM>> getLaptopRAMsByUseCase(String useCase) async {
    return await _databaseHelper.getLaptopRAMsByUseCase(useCase);
  }

  Future<LaptopRAM?> getLaptopRAMById(int id) async {
    return await _databaseHelper.getLaptopRAMById(id);
  }

// Laptop Storage methods
  Future<List<LaptopStorage>> getAllLaptopStorages() async {
    return await _databaseHelper.getLaptopStorages();
  }

  Future<List<LaptopStorage>> getLaptopStoragesByUseCase(String useCase) async {
    return await _databaseHelper.getLaptopStoragesByUseCase(useCase);
  }

  Future<LaptopStorage?> getLaptopStorageById(int id) async {
    return await _databaseHelper.getLaptopStorageById(id);
  }

// Laptop Display methods
  Future<List<LaptopDisplay>> getAllLaptopDisplays() async {
    return await _databaseHelper.getLaptopDisplays();
  }

  Future<List<LaptopDisplay>> getLaptopDisplaysByUseCase(String useCase) async {
    return await _databaseHelper.getLaptopDisplaysByUseCase(useCase);
  }

  Future<LaptopDisplay?> getLaptopDisplayById(int id) async {
    return await _databaseHelper.getLaptopDisplayById(id);
  }

// Laptop Battery methods
  Future<List<LaptopBattery>> getAllLaptopBatteries() async {
    return await _databaseHelper.getLaptopBatteries();
  }

  Future<List<LaptopBattery>> getLaptopBatteriesByUseCase(
      String useCase) async {
    return await _databaseHelper.getLaptopBatteriesByUseCase(useCase);
  }

  Future<LaptopBattery?> getLaptopBatteryById(int id) async {
    return await _databaseHelper.getLaptopBatteryById(id);
  }

// Laptop Preset Build methods
  Future<List<LaptopPresetBuild>> getAllLaptopPresetBuilds() async {
    return await _databaseHelper.getLaptopPresetBuilds();
  }

  Future<List<LaptopPresetBuild>> getLaptopPresetBuildsByTypeAndUseCase(
      String type, String useCase) async {
    return await _databaseHelper.getLaptopPresetBuildsByTypeAndUseCase(
        type, useCase);
  }

  Future<LaptopPresetBuild?> getLaptopPresetBuildById(int id) async {
    return await _databaseHelper.getLaptopPresetBuildById(id);
  }

// Calculate battery life for a laptop build
  Future<int> calculateEstimatedBatteryLife({
    required int cpuId,
    required int gpuId,
    int? batteryId,
  }) async {
    int estimatedBatteryLife = 0;

    final cpu = await getLaptopCPUById(cpuId);
    final gpu = await getLaptopGPUById(gpuId);

    // Base calculation on CPU and GPU TDP (higher TDP = lower battery life)
    if (cpu != null && gpu != null) {
      int totalTDP = cpu.tdp + gpu.tdp;

      // Simple inverse relation between TDP and battery life
      estimatedBatteryLife = 10 - (totalTDP ~/ 20);

      // Apply minimum battery life of 2 hours
      estimatedBatteryLife =
          estimatedBatteryLife < 2 ? 2 : estimatedBatteryLife;

      // If we have a specific battery
      if (batteryId != null) {
        final battery = await getLaptopBatteryById(batteryId);
        if (battery != null) {
          // Adjust for specific battery
          estimatedBatteryLife = battery.batteryLife;
        }
      }
    }

    return estimatedBatteryLife;
  }

// Get supported software for a laptop build
  Future<List<String>> getLaptopSupportedSoftware({
    required int cpuId,
    required int gpuId,
  }) async {
    Set<String> supportedSoftware = {};

    final cpu = await getLaptopCPUById(cpuId);
    if (cpu != null) {
      supportedSoftware.addAll(cpu.supportedSoftware);
    }

    final gpu = await getLaptopGPUById(gpuId);
    if (gpu != null) {
      supportedSoftware.addAll(gpu.supportedSoftware);
    }

    return supportedSoftware.toList();
  }
}
