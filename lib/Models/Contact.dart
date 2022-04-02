class Contact {
  String id;
  String email;
  String userName;
  String urlImage;
  String statut = "Hello WOrld";

  Contact.fromJson(dynamic obj) {
    id = obj["id"];
    email = obj["email"];
    userName = obj["userName"];
    urlImage = obj["urlImage"];
  }
}
