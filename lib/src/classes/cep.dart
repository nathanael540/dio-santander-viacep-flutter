import 'dart:convert';

class CEP {
  String? id;
  String cep;
  String logradouro;
  String complemento;
  String bairro;
  String localidade;
  String uf;

  String get cepComTraco => "${cep.substring(0, 5)}-${cep.substring(5)}";
  String get endereco {
    String text = "";

    for (String item in [logradouro, complemento, bairro, localidade, uf]) {
      if (item.isNotEmpty) {
        text += "$item, ";
      }
    }

    return text.substring(0, text.length - 2);
  }

  CEP({
    required this.cep,
    required this.logradouro,
    required this.complemento,
    required this.bairro,
    required this.localidade,
    required this.uf,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cep': cep,
      'logradouro': logradouro,
      'complemento': complemento,
      'bairro': bairro,
      'localidade': localidade,
      'uf': uf,
      if (id != null) 'objectId': id ?? 0,
    };
  }

  factory CEP.fromMap(Map<String, dynamic> map) {
    return CEP(
      cep: (map['cep'] as String).replaceAll("-", "").replaceAll(".", ""),
      logradouro: map['logradouro'] as String,
      complemento: map['complemento'] as String,
      bairro: map['bairro'] as String,
      localidade: map['localidade'] as String,
      uf: map['uf'] as String,
      id: map['objectId'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory CEP.fromJson(String source) =>
      CEP.fromMap(json.decode(source) as Map<String, dynamic>);
}
