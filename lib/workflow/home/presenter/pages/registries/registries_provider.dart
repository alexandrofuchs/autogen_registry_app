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
  String _filterText = '';

  RegistriesProviderStatus _status = RegistriesProviderStatus.loading;
  RegistriesProviderStatus get status => _status;

  List<RegistryModel> get registries => 
    _filterText.isEmpty ?
    (_registries ?? []) :
    (_registries ?? []).where((e) => e.topic.contains(_filterText)).toList();

  String get filterText => _filterText;
  
  set filterText(String value){
    _filterText = value;
    _status = RegistriesProviderStatus.loaded;
    notifyListeners();
  }

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
