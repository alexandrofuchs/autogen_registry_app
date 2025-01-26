import 'package:flutter/cupertino.dart';
import 'package:plain_registry_app/workflow/home/domain/i_repositories/i_registry_repository.dart';
import 'package:plain_registry_app/workflow/home/domain/models/registry_model.dart';

enum RegistriesProviderStatus {
  loading,
  failed,
  loaded,
}

class RegistriesProvider extends ChangeNotifier {
  final IRegistriesRepository _repository;

  List<RegistryModel>? _registries;

  String errorText = '';

  RegistriesProviderStatus _status = RegistriesProviderStatus.loading;
  RegistriesProviderStatus get status => _status;

  List<RegistryModel> get registries => _registries!;

  RegistriesProvider(this._repository);

  Future<void> loadByGroup(String group) async {
    final response = await _repository.loadByGroup(group);

    response.resolve(onFail: (err) {
      errorText = err;
      _status = RegistriesProviderStatus.failed;
    }, onSuccess: (data) {
      _registries = data;
      _status = RegistriesProviderStatus.loaded;
    });
    notifyListeners();
  }
}
