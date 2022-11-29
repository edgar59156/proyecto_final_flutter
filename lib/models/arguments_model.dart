class ModelArguments {
  String? taller;
  String? mensaje;

  ModelArguments(this.taller, this.mensaje);
  Map<String, dynamic> toMap() {
    return {
      'taller': this.taller,
      'mensaje': this.mensaje,
    };
  }
}
