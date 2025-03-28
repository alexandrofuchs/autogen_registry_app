import 'package:flutter/material.dart';
import 'package:autogen_registry_app/workflow/home/domain/i_repositories/i_registry_groups_repository.dart';

enum RegistryGroupsProviderStatus {
  loading,
  failed,
  loaded,
}

class RegistryGroupsProvider extends ChangeNotifier {
  final IRegistryGroupsRepository _repository;

  RegistryGroupsProviderStatus _status = RegistryGroupsProviderStatus.loading;
  List<String>? _sourceList;
  String? _errorMessage;
  RegistryGroupsProvider(this._repository);

  RegistryGroupsProviderStatus get status => _status;
  String? get errorMessage => _errorMessage;

  List<String> get groups => _sourceList ?? [];

  Future<void> load() async {

    if(_status != RegistryGroupsProviderStatus.loading){
      _status = RegistryGroupsProviderStatus.loading;
      notifyListeners();
    }

    final response = await _repository.load();
    response.resolve(onFail: (message) {
      _errorMessage = message;
      _status = RegistryGroupsProviderStatus.failed;
    }, onSuccess: (data) {
      _status = RegistryGroupsProviderStatus.loaded;
      _sourceList = data;
    });
    notifyListeners();
  }
}
