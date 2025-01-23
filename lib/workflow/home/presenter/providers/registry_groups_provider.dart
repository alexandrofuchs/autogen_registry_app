import 'package:flutter/material.dart';
import 'package:plain_registry_app/workflow/home/domain/i_repositories/i_registry_groups_repository.dart';

enum RegistriesProviderStatus {
  loading,
  failed,
  loaded,
}

class RegistryGroupsProvider extends ChangeNotifier {
  final IRegistryGroupsRepository _repository;

  RegistriesProviderStatus _status = RegistriesProviderStatus.loading;
  List<String>? _sourceList;
  String? _errorMessage;
  RegistryGroupsProvider(this._repository);

  RegistriesProviderStatus get status => _status;
  String? get errorMessage => _errorMessage;

  List<String> get groups => _sourceList ?? [];

  Future<void> load() async {
    final response = await _repository.load();
    response.resolve(onFail: (message) {
      _errorMessage = message;
      _status = RegistriesProviderStatus.failed;
    }, onSuccess: (data) {
      _status = RegistriesProviderStatus.loaded;
      _sourceList = data;
    });
    notifyListeners();
  }
}
