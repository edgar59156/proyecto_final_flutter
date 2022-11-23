class CourseModel {
  int? id_taller;
  String? taller;
  String? hora_inicio;
  String? hora_fin;
  String? descripcion;
  String? fotografia;

  CourseModel({
    this.id_taller,
    this.taller,
    this.hora_fin,
    this.hora_inicio,
    this.descripcion,
    this.fotografia,
  });
  
  Map<String, dynamic> toMap() {
    return {
      'id_taller': this.id_taller,
      'taller': this.taller,
      'hora_inicio': this.hora_inicio,
      'hora_fin': this.hora_fin,
      'descripcion': this.descripcion,
      'fotografia': this.fotografia,
      
    };
  }
}
