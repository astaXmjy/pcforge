import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/models/component_models.dart';
import '../data/repositories/component_repository.dart';
import 'component_selection_screen.dart';
import '../widgets/component_info_dialog.dart';

class CustomBuildScreen extends StatefulWidget {
  const CustomBuildScreen({Key? key}) : super(key: key);

  @override
  _CustomBuildScreenState createState() => _CustomBuildScreenState();
}

class _CustomBuildScreenState extends State<CustomBuildScreen> {
  CPU? selectedCPU;
  GPU? selectedGPU;
  RAM? selectedRAM;
  Storage? selectedStorage;
  Motherboard? selectedMotherboard;
  PSU? selectedPSU;
  int totalWattage = 0;
  List<String> supportedSoftware = [];
  String recommendedCooling =
      "Standard Air Cooling"; // Default cooling recommendation

  @override
  Widget build(BuildContext context) {
    final repository = Provider.of<ComponentRepository>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom PC Build'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Components',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildComponentCard(
              title: 'CPU',
              subtitle: selectedCPU?.name ?? 'Select a CPU',
              details: selectedCPU != null
                  ? [
                      'Brand: ${selectedCPU!.brand}',
                      'Cores: ${selectedCPU!.cores}',
                      'Clock Speed: ${selectedCPU!.clockSpeed} GHz',
                      'TDP: ${selectedCPU!.tdp} W',
                    ]
                  : [],
              onTap: () async {
                final result = await Navigator.push<CPU>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ComponentSelectionScreen<CPU>(
                      title: 'Select CPU',
                      getComponents: () => repository.getAllCPUs(),
                      buildItemWidget: (cpu) => ListTile(
                        title: Text(cpu.name),
                        subtitle: Text(
                            '${cpu.brand} - ${cpu.cores} cores - ${cpu.clockSpeed} GHz'),
                        trailing: Text('${cpu.tdp} W'),
                      ),
                    ),
                  ),
                );

                if (result != null) {
                  setState(() {
                    selectedCPU = result;
                    _updateTotalWattage();
                    _updateSupportedSoftware();
                    _updateCoolingRecommendation();
                  });
                }
              },
              onInfoTap: () {
                showDialog(
                  context: context,
                  builder: (context) => ComponentInfoDialog(
                    title: 'CPU (Central Processing Unit)',
                    description:
                        'The CPU is the primary component of a computer that performs most of the processing inside the computer. It handles all instructions it receives from hardware and software running on the computer.\n\n'
                        'Key factors to consider:\n'
                        '• Core Count: More cores allow for better multitasking\n'
                        '• Clock Speed: Higher speeds (GHz) mean faster processing\n'
                        '• TDP: Thermal Design Power indicates heat generation and power consumption',
                    icon: Icons.memory,
                  ),
                );
              },
            ),
            _buildComponentCard(
              title: 'GPU',
              subtitle: selectedGPU?.name ?? 'Select a GPU',
              details: selectedGPU != null
                  ? [
                      'Brand: ${selectedGPU!.brand}',
                      'VRAM: ${selectedGPU!.vram} GB',
                      'TDP: ${selectedGPU!.tdp} W',
                    ]
                  : [],
              onTap: () async {
                final result = await Navigator.push<GPU>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ComponentSelectionScreen<GPU>(
                      title: 'Select GPU',
                      getComponents: () => repository.getAllGPUs(),
                      buildItemWidget: (gpu) => ListTile(
                        title: Text(gpu.name),
                        subtitle: Text('${gpu.brand} - ${gpu.vram} GB VRAM'),
                        trailing: Text('${gpu.tdp} W'),
                      ),
                    ),
                  ),
                );

                if (result != null) {
                  setState(() {
                    selectedGPU = result;
                    _updateTotalWattage();
                    _updateSupportedSoftware();
                    _updateCoolingRecommendation();
                  });
                }
              },
              onInfoTap: () {
                showDialog(
                  context: context,
                  builder: (context) => ComponentInfoDialog(
                    title: 'GPU (Graphics Processing Unit)',
                    description:
                        'The GPU is specialized for display functions and rendering images, animations, and video. It\'s crucial for gaming and graphics-intensive applications.\n\n'
                        'Key factors to consider:\n'
                        '• VRAM: Video memory for storing texture and image data\n'
                        '• Performance: Higher benchmark scores mean better gaming performance\n'
                        '• TDP: Indicates power consumption and heat generation',
                    icon: Icons.videogame_asset,
                  ),
                );
              },
            ),
            // Rest of components...
            _buildComponentCard(
              title: 'RAM',
              subtitle: selectedRAM?.name ?? 'Select RAM',
              details: selectedRAM != null
                  ? [
                      'Brand: ${selectedRAM!.brand}',
                      'Capacity: ${selectedRAM!.capacity} GB',
                      'Type: ${selectedRAM!.type}',
                      'Speed: ${selectedRAM!.speed} MHz',
                    ]
                  : [],
              onTap: () async {
                final result = await Navigator.push<RAM>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ComponentSelectionScreen<RAM>(
                      title: 'Select RAM',
                      getComponents: () => repository.getAllRAMs(),
                      buildItemWidget: (ram) => ListTile(
                        title: Text(ram.name),
                        subtitle: Text(
                            '${ram.brand} - ${ram.capacity} GB ${ram.type}'),
                        trailing: Text('${ram.speed} MHz'),
                      ),
                    ),
                  ),
                );

                if (result != null) {
                  setState(() {
                    selectedRAM = result;
                  });
                }
              },
              onInfoTap: () {
                showDialog(
                  context: context,
                  builder: (context) => ComponentInfoDialog(
                    title: 'RAM (Random Access Memory)',
                    description:
                        'RAM is your computer\'s short-term memory. It temporarily stores data that your CPU needs to access quickly.\n\n'
                        'Key factors to consider:\n'
                        '• Capacity: More GB allows running more programs simultaneously\n'
                        '• Speed: Higher MHz ratings mean faster data access\n'
                        '• Type: DDR4 is the current standard, with DDR5 emerging',
                    icon: Icons.memory_outlined,
                  ),
                );
              },
            ),
            _buildComponentCard(
              title: 'Storage',
              subtitle: selectedStorage?.name ?? 'Select Storage',
              details: selectedStorage != null
                  ? [
                      'Brand: ${selectedStorage!.brand}',
                      'Capacity: ${selectedStorage!.capacity} GB',
                      'Type: ${selectedStorage!.type}',
                      'Interface: ${selectedStorage!.interface}',
                    ]
                  : [],
              onTap: () async {
                final result = await Navigator.push<Storage>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ComponentSelectionScreen<Storage>(
                      title: 'Select Storage',
                      getComponents: () => repository.getAllStorages(),
                      buildItemWidget: (storage) => ListTile(
                        title: Text(storage.name),
                        subtitle: Text(
                            '${storage.brand} - ${storage.capacity} GB ${storage.type}'),
                        trailing: Text(storage.interface),
                      ),
                    ),
                  ),
                );

                if (result != null) {
                  setState(() {
                    selectedStorage = result;
                  });
                }
              },
              onInfoTap: () {
                showDialog(
                  context: context,
                  builder: (context) => ComponentInfoDialog(
                    title: 'Storage',
                    description:
                        'Storage is where all your files, programs, and the operating system are kept when not in use.\n\n'
                        'Key factors to consider:\n'
                        '• Type: SSDs are faster but more expensive than HDDs\n'
                        '• Capacity: Determines how many files you can store\n'
                        '• Interface: NVMe is faster than SATA for SSDs',
                    icon: Icons.storage,
                  ),
                );
              },
            ),
            _buildComponentCard(
              title: 'Motherboard',
              subtitle: selectedMotherboard?.name ?? 'Select Motherboard',
              details: selectedMotherboard != null
                  ? [
                      'Brand: ${selectedMotherboard!.brand}',
                      'Chipset: ${selectedMotherboard!.chipset}',
                      'Socket: ${selectedMotherboard!.socketType}',
                      'Form Factor: ${selectedMotherboard!.formFactor}',
                    ]
                  : [],
              onTap: () async {
                final result = await Navigator.push<Motherboard>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ComponentSelectionScreen<Motherboard>(
                      title: 'Select Motherboard',
                      getComponents: () => repository.getAllMotherboards(),
                      buildItemWidget: (motherboard) => ListTile(
                        title: Text(motherboard.name),
                        subtitle: Text(
                            '${motherboard.brand} - ${motherboard.chipset}'),
                        trailing: Text(motherboard.socketType),
                      ),
                    ),
                  ),
                );

                if (result != null) {
                  setState(() {
                    selectedMotherboard = result;
                  });
                }
              },
              onInfoTap: () {
                showDialog(
                  context: context,
                  builder: (context) => ComponentInfoDialog(
                    title: 'Motherboard',
                    description:
                        'The motherboard is the main circuit board that connects all components together and allows them to communicate.\n\n'
                        'Key factors to consider:\n'
                        '• Socket Type: Must match your CPU\n'
                        '• Chipset: Determines features and compatibility\n'
                        '• Form Factor: Determines the physical size (ATX, Micro-ATX, etc.)',
                    icon: Icons.developer_board,
                  ),
                );
              },
            ),
            _buildComponentCard(
              title: 'Power Supply',
              subtitle: selectedPSU?.name ?? 'Auto-select based on components',
              details: selectedPSU != null
                  ? [
                      'Brand: ${selectedPSU!.brand}',
                      'Wattage: ${selectedPSU!.wattage} W',
                      'Certification: ${selectedPSU!.certification}',
                    ]
                  : [],
              onTap: () async {
                final result = await Navigator.push<PSU>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ComponentSelectionScreen<PSU>(
                      title: 'Select Power Supply',
                      getComponents: () => repository.getAllPSUs(),
                      buildItemWidget: (psu) => ListTile(
                        title: Text(psu.name),
                        subtitle: Text('${psu.brand} - ${psu.certification}'),
                        trailing: Text('${psu.wattage} W'),
                      ),
                    ),
                  ),
                );

                if (result != null) {
                  setState(() {
                    selectedPSU = result;
                  });
                }
              },
              onInfoTap: () {
                showDialog(
                  context: context,
                  builder: (context) => ComponentInfoDialog(
                    title: 'Power Supply Unit (PSU)',
                    description:
                        'The PSU converts mains AC electricity to low-voltage DC power for the components inside the computer.\n\n'
                        'Key factors to consider:\n'
                        '• Wattage: Must be sufficient for all components\n'
                        '• Certification: 80+ ratings (Bronze, Silver, Gold, etc.) indicate efficiency\n'
                        '• Modularity: Modular PSUs allow you to use only the cables you need',
                    icon: Icons.electrical_services,
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Build Summary',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildMetricRow(
                      'Total Power Consumption',
                      '$totalWattage W',
                      Icons.power,
                    ),
                    const SizedBox(height: 12),
                    _buildMetricRow(
                      'Recommended Cooling',
                      recommendedCooling,
                      Icons.ac_unit,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Recommended PSU',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    FutureBuilder<PSU?>(
                      future: totalWattage > 0
                          ? repository.getRecommendedPSU(totalWattage)
                          : Future.value(null),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        final recommendedPSU = snapshot.data;
                        if (recommendedPSU == null) {
                          return const Text(
                              'Select CPU and GPU to get a recommendation');
                        }

                        return ListTile(
                          title: Text(recommendedPSU.name),
                          subtitle: Text(
                              '${recommendedPSU.brand} - ${recommendedPSU.certification}'),
                          trailing: Text('${recommendedPSU.wattage} W'),
                          onTap: () {
                            setState(() {
                              selectedPSU = recommendedPSU;
                            });
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Supported Software',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    supportedSoftware.isEmpty
                        ? const Text(
                            'Select CPU and GPU to see supported software')
                        : Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: supportedSoftware
                                .map((software) => Chip(
                                      label: Text(software),
                                      backgroundColor: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.2),
                                    ))
                                .toList(),
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComponentCard({
    required String title,
    required String subtitle,
    required List<String> details,
    required VoidCallback onTap,
    required VoidCallback onInfoTap,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Use Flexible to prevent text overflow in title
                  Flexible(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.info_outline),
                    onPressed: onInfoTap,
                    tooltip: 'Component Information',
                    color: Colors.blue,
                    constraints: const BoxConstraints(
                      minWidth: 36,
                      minHeight: 36,
                    ),
                    padding: EdgeInsets.zero,
                    iconSize: 20,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Use Flexible for subtitle text to prevent overflow
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 16,
                  color: subtitle.startsWith('Select') ? Colors.grey : null,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              if (details.isNotEmpty) ...[
                const SizedBox(height: 8),
                ...details.map((detail) => Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                      child: Text(
                        detail,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    )),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetricRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Theme.of(context).primaryColor),
        const SizedBox(width: 8),
        // Wrap label in Expanded to prevent overflow
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 16,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 8), // Add spacing between label and value
        // Wrap value in flexible to handle long text
        Flexible(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Future<void> _updateTotalWattage() async {
    if (selectedCPU != null && selectedGPU != null) {
      final repository =
          Provider.of<ComponentRepository>(context, listen: false);
      final wattage = await repository.calculateTotalWattage(
        cpuId: selectedCPU!.id,
        gpuId: selectedGPU!.id,
      );
      setState(() {
        totalWattage = wattage;
      });
    }
  }

  Future<void> _updateSupportedSoftware() async {
    if (selectedCPU != null && selectedGPU != null) {
      final repository =
          Provider.of<ComponentRepository>(context, listen: false);
      final software = await repository.getSupportedSoftware(
        cpuId: selectedCPU!.id,
        gpuId: selectedGPU!.id,
      );
      setState(() {
        supportedSoftware = software;
      });
    }
  }

  void _updateCoolingRecommendation() {
    // Base cooling recommendation on CPU TDP and GPU TDP
    if (selectedCPU != null && selectedGPU != null) {
      int totalTDP = selectedCPU!.tdp + selectedGPU!.tdp;

      // Higher TDP values typically require more robust cooling
      if (totalTDP > 300) {
        setState(() {
          recommendedCooling = "Liquid Cooling Required";
        });
      } else if (totalTDP > 200) {
        setState(() {
          recommendedCooling = "High-Performance Air/AIO";
        });
      } else {
        setState(() {
          recommendedCooling = "Standard Air Cooling";
        });
      }
    }
  }
}
