
extension ExtendedIterableMethods<DataType> on Iterable<DataType>? {
  DataType? firstWhereOrNull(bool Function(DataType e) test) {
    try {
      if(this == null) return null;
      final item = this!.firstWhere(test);
      return item;
    } catch (e) {
      return null;
    }
  }

  DataType? firstOrNull() {
    try {
      if(this == null) return null;
      return this!.first;
    } catch (e) {
      return null;
    }
  }

  DataType? lastOrNull() {
    try {
      if(this == null) return null;
      return this!.last;
    } catch (e) {
      return null;
    }
  }

  DataType? lastWhereOrNull(bool Function(DataType e) test) {
    try {
      if(this == null) return null;
      final item = this!.lastWhere(test);
      return item;
    } catch (e) {
      return null;
    }
  }

  int? firstIndexWhereOrNull(bool Function(DataType e) test) {
    try {
      if(this == null) return null;
      final item = this!.firstWhere(test);
      return this!.toList().indexOf(item);      
    } catch (e) {
      return null;
    }
  }

  void removeAll(List<Object> toRemoveList){
    if(this == null) return;
    for (var element in toRemoveList) {
      this!.toList().remove(element);
    }}
}

extension ExtendedListMethods<DataType> on List<DataType> {
  bool? replaceOnIndexWhere(bool Function(DataType) test, DataType item){
    try {
      this[indexWhere(test)] = item;
      return true;
    } catch (e) {
      return false;
    }
  }

}

extension ListObjectExtension on Iterable<Object?> {
  bool isThereAnythingNull() =>
      firstWhereOrNull((element) => element == null) != null;

  bool containsAny(Iterable<Object> toContainList) {
    try {
      bool contained = false;
      for (final item in this) {
        if (toContainList.contains(item)) {
          contained = true;
          break;
        }
      }
      return contained;
    } catch (e) {
      return false;
    }
  }
}
