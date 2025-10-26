class AssemblyLine {
  final int? id;
  final String serialNumber;
  final String productType;
  final String status;
  final String operatorName;
  final double speed;
  final String startedAt;

  AssemblyLine({
    this.id,
    required this.serialNumber,
    required this.productType,
    required this.status,
    required this.operatorName,
    required this.speed,
    required this.startedAt,
  });

  AssemblyLine copyWith({
    int? id,
    String? serialNumber,
    String? productType,
    String? status,
    String? operatorName,
    double? speed,
    String? startedAt,
  }) {
    return AssemblyLine(
      id: id ?? this.id,
      serialNumber: serialNumber ?? this.serialNumber,
      productType: productType ?? this.productType,
      status: status ?? this.status,
      operatorName: operatorName ?? this.operatorName,
      speed: speed ?? this.speed,
      startedAt: startedAt ?? this.startedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'serialNumber': serialNumber,
      'productType': productType,
      'status': status,
      'operatorName': operatorName,
      'speed': speed,
      'startedAt': startedAt,
    };
  }

  factory AssemblyLine.fromMap(Map<String, dynamic> map) {
    return AssemblyLine(
      id: map['id'] as int?,
      serialNumber: map['serialNumber'] as String,
      productType: map['productType'] as String,
      status: map['status'] as String,
      operatorName: map['operatorName'] as String,
      speed: (map['speed'] as num).toDouble(),
      startedAt: map['startedAt'] as String,
    );
  }
}