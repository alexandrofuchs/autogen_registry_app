import 'package:flutter/material.dart';
import 'package:plain_registry_app/workflow/home/domain/i_repositories/i_registry_repository.dart';
import 'package:plain_registry_app/workflow/home/domain/models/registry_model.dart';

enum RegistriesProviderStatus {
  loading,
  failed,
  loaded,
}

class RegistriesProvider extends ChangeNotifier {
  final IRegistriesRepository _repository;

  RegistriesProviderStatus _status = RegistriesProviderStatus.loading;

  List<RegistryModel>? _sourceList;
  String? _errorMessage;

  String _filter = '';

  RegistriesProvider(this._repository);

  RegistriesProviderStatus get status => _status;
  String? get errorMessage => _errorMessage;
  List<RegistryModel>? get items => _filter.isEmpty
      ? _sourceList
      : _sourceList
              ?.where((item) => item.description.contains(_filter))
              .toList() ??
          [];

  set filter(String value) {
    _filter = value;
    notifyListeners();
  }

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
