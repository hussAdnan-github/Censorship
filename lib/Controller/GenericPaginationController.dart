import 'package:flutter/material.dart';
import 'package:get/get.dart';

typedef FromJson<T> = T Function(Map<String, dynamic> json);
typedef FetchFunction<T> = Future<PaginatedResponseGeneric<T>> Function({int? page});

class PaginatedResponseGeneric<T> {
  final List<T> items;
  final int? nextPage;

  PaginatedResponseGeneric({required this.items, this.nextPage});
}

class GenericPaginationController<T> extends GetxController {
  final FetchFunction<T> fetchFunction;

  GenericPaginationController({required this.fetchFunction});

  var items = <T>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  var isLoadingMore = false.obs;
  var hasMore = true.obs;
  int? _nextPage;

  late ScrollController scrollController;

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController()..addListener(_scrollListener);
    fetchInitial();
  }

  @override
  void onClose() {
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
    super.onClose();
  }

  Future<void> fetchInitial() async {
    print("object");
    try {
      isLoading(true);
      errorMessage('');
      PaginatedResponseGeneric<T> response = await fetchFunction();

      items.assignAll(response.items);
      _nextPage = response.nextPage;
      hasMore.value = _nextPage != null;
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }

  void fetchMore() async {
    if (isLoadingMore.value || !hasMore.value) return;

    try {
      isLoadingMore(true);
      PaginatedResponseGeneric<T> response = await fetchFunction(page: _nextPage);

      items.addAll(response.items);
      _nextPage = response.nextPage;
      hasMore.value = _nextPage != null;
    } catch (e) {
      print("Error loading more items: $e");
    } finally {
      isLoadingMore(false);
    }
  }

  void _scrollListener() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent * 0.8) {
      fetchMore();
    }
  }
}
