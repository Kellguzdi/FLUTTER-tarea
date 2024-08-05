// lib/models/modelo.dart

class Modelo {
  final int id;
  final String nombre;
  final String fabricante;
  final double autonomia;
  final double velocidadMaxima;

  Modelo({
    required this.id,
    required this.nombre,
    required this.fabricante,
    required this.autonomia,
    required this.velocidadMaxima,
  });

  factory Modelo.fromJson(Map<String, dynamic> json) {
    return Modelo(
      id: json['id'],
      nombre: json['nombre'],
      fabricante: json['fabricante'],
      autonomia: json['autonomia'].toDouble(),
      velocidadMaxima: json['velocidadMaxima'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'fabricante': fabricante,
      'autonomia': autonomia,
      'velocidadMaxima': velocidadMaxima,
    };
  }
}
