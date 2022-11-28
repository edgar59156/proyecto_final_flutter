class ProfileDAO {
  int? idUsuario;
  String? nombre;
  String? apellidoPaterno;
  String? apellidoMaterno;
  String? email;
  String? telefono;
  String? github;
  String? image;
  String? descripcion;
  String? instructor;

  ProfileDAO(
      {this.idUsuario,
      this.nombre,
      this.apellidoMaterno,
      this.apellidoPaterno,
      this.email,
      this.telefono,
      this.github,
      this.image,
      this.descripcion,
      this.instructor});
  factory ProfileDAO.fromJSON(Map<String, dynamic> mapUsuario) {
    return ProfileDAO(
      idUsuario: mapUsuario['idUsuario'],
      nombre: mapUsuario['nombre'],
      apellidoMaterno: mapUsuario['apellidoMaterno'],
      apellidoPaterno: mapUsuario['apellidoPaterno'],
      email: mapUsuario['email'],
      telefono: mapUsuario['telefono'],
      github: mapUsuario['github'],
      image: mapUsuario['image'],
      descripcion: mapUsuario['descripcion'],
      instructor: mapUsuario['instructor'],
    );
  }
}
