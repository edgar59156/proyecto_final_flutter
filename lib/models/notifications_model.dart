class NotificationsModel {
  String? descripcion;
  String? fecha;
  String? instructor;
  String? mensaje;
  String? taller;
  String? titulo;
  String? to_email;

  NotificationsModel({
    this.descripcion,
    this.fecha,
    this.mensaje,
    this.instructor,
    this.taller,
    this.titulo,
    this.to_email,
  });

  Map<String, dynamic> toMap() {
    return {
      'descripcion': this.descripcion,
      'fecha': this.fecha,
      'instructor': this.instructor,
      'mensaje': this.mensaje,
      'taller': this.taller,
      'titulo': this.titulo,
      'to_email': this.to_email,
    };
  }
}
