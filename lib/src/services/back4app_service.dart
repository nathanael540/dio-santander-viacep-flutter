import 'package:dio/dio.dart';
import 'package:viacep/src/classes/cep.dart';

class Back4AppService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://parseapi.back4app.com/classes',
      // Headers
      headers: {
        'X-Parse-Application-Id': "fkE4pxnUSo9VNeKwhnHKXZJRJQqPVbSXBqlKjP1O",
        'X-Parse-REST-API-Key': "RmzeHbSXL1TskT7zW9mbf7ILYHl5OmTuMd2Xjejt",
      },
    ),
  );

  Future<bool> addCEP(CEP cep) async {
    try {
      await _dio.post('/CEP', data: cep.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<CEP?> getCEP(String cep) async {
    try {
      Response response = await _dio.get(
        '/CEP',
        queryParameters: {
          'where': {'cep': cep}
        },
      );
      if (response.data['results'].length > 0) {
        return CEP.fromMap(response.data['results'][0]);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<bool> updateCEP(CEP cep) async {
    try {
      await _dio.put('/CEP/${cep.id}', data: cep.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteCEP(String id) async {
    try {
      await _dio.delete('/CEP/$id');
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<CEP>> getAllCEP() async {
    try {
      Response response = await _dio.get('/CEP');

      List<CEP> ceps = [];

      if (response.data['results'] != null &&
          response.data['results'] is List) {
        ceps = response.data['results']
            .map<CEP>(
              (e) => CEP.fromMap(e),
            )
            .toList();
      }

      return ceps;
    } catch (e) {
      return [];
    }
  }
}
