import 'package:dio/dio.dart';
import 'package:viacep/src/classes/cep.dart';

class ViaCEPService {
  Future<CEP?> consultarCEP(String cep) async {
    try {
      Response response = await Dio().get(
        'https://viacep.com.br/ws/$cep/json/',
      );

      return CEP.fromMap(response.data);
    } catch (e) {
      return null;
    }
  }
}
