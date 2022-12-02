class PeopleModel {
  int? id_persona;
  String? persona;
  String? email;
  String? fotografia;
  String? name;
  String? phone;

  PeopleModel({
    this.id_persona,
    this.persona,
    this.email,
    this.fotografia,
    this.name,
    this.phone,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_persona': this.id_persona,
      'persona': this.persona,
      'email': this.email,
      'fotografia': this.fotografia,
      'name': this.name,
      'phone': this.phone,
    };
  }
}
