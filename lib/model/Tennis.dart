class Tennis {
  // Atributos:
  int? _id; // podemos precisar do objeto ainda sem id
  String _modelo;
  String _marca;
  String _tamanho;

  // Construtor para quando o BD ainda não definiu o id.
  Tennis(this._modelo, this._marca, this._tamanho);

  // Construtor para quando já tivermos o id.
  Tennis.withId(this._id, this._modelo, this._marca, this._tamanho);

  // Getters...
  int? get id => _id;
  String get modelo => _modelo;
  String get marca => _marca;
  String get tamanho => _tamanho;

  // Setters...
  set modelo(String newModelo) {
    if (newModelo.length <= 255) {
      _modelo = newModelo;
    }
  }

  set marca(String newMarca) {
    if (newMarca.length <= 255) {
      _marca = newMarca;
    }
  }

  set tamanho(String newTamanho) {
    if (newTamanho.length <= 10) {
      _tamanho = newTamanho;
    }
  }

  // Método que vai retornar um Map com os dados de nosso objeto.
  // Vai ser útil para uso com SQLite.
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["modelo"] = _modelo;
    map["marca"] = _marca;
    map["tamanho"] = _tamanho;
    if (_id != null) {
      map["id"] = _id;
    }
    return map;
  }

  // Outro construtor nomeado que vai fazer o contrário
  // do método acima, isto é, criar um objeto Tennis
  // a partir de um map passado como parâmetro.
  Tennis.fromMap(dynamic o)
      : _id = o["id"],
        _modelo = o["modelo"],
        _marca = o["marca"],
        _tamanho = o["tamanho"];
}