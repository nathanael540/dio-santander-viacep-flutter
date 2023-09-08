import 'package:viacep/src/classes/cep.dart';
import 'package:viacep/src/services/back4app_service.dart';
import 'package:viacep/src/services/viacep_service.dart';

class CepController {
  final Back4AppService _back4AppService = Back4AppService();
  final ViaCEPService _viaCEPService = ViaCEPService();

  Future<CEP?> getCEP(String cep) async {
    CEP? back = await _back4AppService.getCEP(cep);

    if (back != null) {
      return back;
    }

    CEP? via = await _viaCEPService.consultarCEP(cep);

    return via;
  }

  Future<bool> addCEP(CEP cep) async {
    return await _back4AppService.addCEP(cep);
  }

  Future<bool> updateCEP(CEP cep) async {
    return await _back4AppService.updateCEP(cep);
  }

  Future<bool> deleteCEP(String id) async {
    return await _back4AppService.deleteCEP(id);
  }

  Future<List<CEP>> getAllCEP() async {
    return await _back4AppService.getAllCEP();
  }
}
