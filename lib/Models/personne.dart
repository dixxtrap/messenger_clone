class Personne {
  String _id, _name, _picture, _email, _username,_statut;
  Personne(this._id, this._name, this._picture, this._email, this._username,this._statut);
  get id => _id;
  get name => _name;
  get picture => _picture;
  get statut => _statut;
  get email => _email;
  get username => _username;
  set id(value) => _id = value;
  set name(value) => _name = value;
  set picture(value) => _picture = value;
  set email(value) => _email = value;
  set username(value) => _username = value;
  set statut(value) => _statut = value;
  Personne.fromJson(dynamic obj) {
    id = obj["id"];
    email = obj["email"];
    username = obj["username"];
    picture = obj["imgUrl"];
    statut="salut";
  }

}
