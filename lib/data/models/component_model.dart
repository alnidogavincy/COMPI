/// Model untuk komponen perangkat keras komputer.
class ComponentModel {
  final String id;
  final String name;
  final String shortDescription;
  final String fullDescription;
  final String category;
  final String modelPath;
  bool get hasModel => modelPath.isNotEmpty;
  String get imagePath => 'assets/images/hardware_$id.png';
  final List<HotspotModel> hotspots;
  final Map<String, String>? specs; // Menambahkan spesifikasi hardware

  const ComponentModel({
    required this.id,
    required this.name,
    required this.shortDescription,
    required this.fullDescription,
    required this.category,
    required this.modelPath,
    this.hotspots = const [],
    this.specs,
  });

  ComponentModel copyWith({
    String? id,
    String? name,
    String? shortDescription,
    String? fullDescription,
    String? category,
    String? modelPath,
    List<HotspotModel>? hotspots,
  }) {
    return ComponentModel(
      id: id ?? this.id,
      name: name ?? this.name,
      shortDescription: shortDescription ?? this.shortDescription,
      fullDescription: fullDescription ?? this.fullDescription,
      category: category ?? this.category,
      modelPath: modelPath ?? this.modelPath,
      hotspots: hotspots ?? this.hotspots,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'shortDescription': shortDescription,
      'fullDescription': fullDescription,
      'category': category,
      'modelPath': modelPath,
      'hotspots': hotspots.map((h) => h.toJson()).toList(),
    };
  }

  factory ComponentModel.fromJson(Map<String, dynamic> json) {
    return ComponentModel(
      id: json['id'] as String,
      name: json['name'] as String,
      shortDescription: json['shortDescription'] as String,
      fullDescription: json['fullDescription'] as String,
      category: json['category'] as String,
      modelPath: json['modelPath'] as String,
      hotspots:
          (json['hotspots'] as List<dynamic>?)
              ?.map((h) => HotspotModel.fromJson(h as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

/// Model untuk titik interaktif pada model 3D.
class HotspotModel {
  final String id;
  final String label;
  final String description;
  final double positionX;
  final double positionY;
  final double positionZ;

  const HotspotModel({
    required this.id,
    required this.label,
    required this.description,
    required this.positionX,
    required this.positionY,
    required this.positionZ,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'label': label,
      'description': description,
      'positionX': positionX,
      'positionY': positionY,
      'positionZ': positionZ,
    };
  }

  factory HotspotModel.fromJson(Map<String, dynamic> json) {
    return HotspotModel(
      id: json['id'] as String,
      label: json['label'] as String,
      description: json['description'] as String,
      positionX: (json['positionX'] as num).toDouble(),
      positionY: (json['positionY'] as num).toDouble(),
      positionZ: (json['positionZ'] as num).toDouble(),
    );
  }
}
