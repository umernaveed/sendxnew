import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sendx/data/models/address_prediction/address_prediction.dart';
import 'package:sendx/presentation/base_screen.dart';
import 'package:sendx/presentation/delivery/controllers/address_search_controller.dart';
import 'package:sizer/sizer.dart';

class AddressSearchScreen extends GetView<AddressSearchController> {
  const AddressSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      showGradients: false,
      backgroundColor: Colors.white,
      value: SystemUiOverlayStyle.dark,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(
          color: Colors.black,
          onPressed: () => Get.back(),
        ),
        centerTitle: false,
        title: Text(
          'Search Address',
          style: context.textTheme.bodyLarge?.copyWith(
            color: const Color(0xFF4791CE),
            fontSize: 16.sp,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
              child: TextField(
                controller: controller.searchController,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Search location (e.g. city, street, landmark)',
                  hintStyle: TextStyle(
                    color: const Color(0x337C7C7C),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Color(0xFF4791CE),
                  ),
                  filled: true,
                  fillColor: const Color(0xFFF5F5F5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.grey.withValues(alpha: 0.3),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Color(0xFF4791CE),
                      width: 1.5,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 4.w,
                    vertical: 1.5.h,
                  ),
                ),
                style: const TextStyle(
                  color: Color(0xFF181725),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF4791CE),
                    ),
                  );
                }
                final list = controller.predictions;
                if (list.isEmpty) {
                  return Center(
                    child: Text(
                      controller.searchController.text.trim().isEmpty
                          ? 'Type to search for an address'
                          : 'No results found',
                      style: TextStyle(
                        color: const Color(0xFF7C7C7C),
                        fontSize: 14.sp,
                      ),
                    ),
                  );
                }
                return ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0),
                  itemCount: list.length,
                  separatorBuilder: (_, __) => Divider(
                    height: 1,
                    color: Colors.grey.withValues(alpha: 0.2),
                  ),
                  itemBuilder: (context, index) {
                    final prediction = list[index];
                    return _PredictionTile(
                      prediction: prediction,
                      onTap: () => controller.onSelect(prediction),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class _PredictionTile extends StatelessWidget {
  const _PredictionTile({
    required this.prediction,
    required this.onTap,
  });

  final AddressPrediction prediction;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.location_on_outlined,
              size: 22.sp,
              color: const Color(0xFF4791CE),
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: Text(
                prediction.cityCountryDisplay,
                style: TextStyle(
                  color: const Color(0xFF181725),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
