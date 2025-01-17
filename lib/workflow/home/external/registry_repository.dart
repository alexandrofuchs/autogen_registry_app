import 'package:flutter/material.dart';
import 'package:plain_registry_app/workflow/home/domain/i_repositories/i_registry_repository.dart';

class RegistryRepository implements IRegistryRepository {
  @override
  Future<void> load() async {
    try {} catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Future<void> save() async {
    try {} catch (e) {
      debugPrint(e.toString());
    }
  }
}
