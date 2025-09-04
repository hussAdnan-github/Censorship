 


// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/Service/serviceApi.dart';
// import 'package:flutter_application_1/model/Merchant.dart';
// import 'package:get/get.dart';
// class MerchantController extends GetxController {
//   var merchants = <Merchant>[].obs;
//   var isLoading = true.obs;
//   var errorMessage = ''.obs;

//   var isLoadingMore = false.obs;
//   var hasMore = true.obs;
//   int? _nextPage;  

//   late ScrollController scrollController;

//   @override
//   void onInit() {
//     super.onInit();
//     scrollController = ScrollController()..addListener(_scrollListener);
//     fetchInitialMerchants();
//   }

//   @override
//   void onClose() {
//     scrollController.removeListener(_scrollListener);
//     scrollController.dispose();
//     super.onClose();
//   }

//   void fetchInitialMerchants() async {
//     try {
//       isLoading(true);
//       errorMessage('');
//       var response = await ApiService.fetchMerchants();

//       merchants.assignAll(response.merchants);
//       _nextPage = response.nextPage;
//       hasMore.value = _nextPage != null;

//     } catch (e) {
//       errorMessage(e.toString());
//     } finally {
//       isLoading(false);
//     }
//   }

//   void fetchMoreMerchants() async {
//     if (isLoadingMore.value || !hasMore.value) return;

//     try {
//       isLoadingMore(true);
//       var response = await ApiService.fetchMerchants(page: _nextPage);

//       merchants.addAll(response.merchants);
//       _nextPage = response.nextPage;
//       hasMore.value = _nextPage != null;

//     } catch (e) {
//       print("Error loading more merchants: $e");
//     } finally {
//       isLoadingMore(false);
//     }
//   }

//   void _scrollListener() {
//     if (scrollController.position.pixels >= scrollController.position.maxScrollExtent * 0.8) {
//       fetchMoreMerchants();
//     }
//   }
// }