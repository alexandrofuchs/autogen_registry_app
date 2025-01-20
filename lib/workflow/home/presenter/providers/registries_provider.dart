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

  List<CategoryModel<RegistryModel>>? _sourceList;
  String? _errorMessage;

  String _categoryFilter = '';

  RegistriesProvider(this._repository);

  RegistriesProviderStatus get status => _status;
  String? get errorMessage => _errorMessage;
  List<CategoryModel<RegistryModel>>? get categories => _categoryFilter.isEmpty
      ? _sourceList
      : _sourceList
              ?.where((item) => item.name.contains(_categoryFilter))
              .toList() ??
          [];

  set categoryFilter(String value) {
    _categoryFilter = value;
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
