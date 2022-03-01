class Client {
  int? id;
  String? cpf;
  String? name;
  String? lastName;

  Client(this.id, this.cpf, this.name, this.lastName);
  Client.novo(String name, String lastName, String cpf) {
    this.name = name;
    this.lastName = lastName;
    this.cpf = cpf;
  }
}
