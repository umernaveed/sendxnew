import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sendx/app/util/flush_snackbar.dart';
import 'package:sendx/presentation/dashboard/controllers/dashboard_address_controller.dart';
import 'package:sendx/presentation/widgets/shimmer_widget.dart';
import 'package:sizer/sizer.dart';

class Address extends GetView<DashboardAddressController> {
  const Address({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: controller.refreshData,
      color: const Color(0xFF176DF2),
      child: controller.obx(
        onLoading: const _ShimmerLoading(),
        onEmpty: const _EmptyState(
          message: 'No address data found',
          icon: Icons.location_off_outlined,
        ),
        onError: (error) => const _EmptyState(
          message: 'Something went wrong. Please try again later.',
          icon: Icons.error_outline_rounded,
        ),
        (state) {
          if (state == null) {
            return const _EmptyState(
              message: 'No address data found',
              icon: Icons.location_off_outlined,
            );
          }

          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.fromLTRB(4.w, 0.8.h, 4.w, 2.5.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _AddressHero(),
                SizedBox(height: 2.h),
                AddressItemWidget(
                  title: 'Air Shipping Address',
                  caption: 'Use this address for regular air freight.',
                  icon: Icons.flight_takeoff_rounded,
                  accentColor: const Color(0xFF176DF2),
                  name: state.userInfo.userName,
                  address1: state.setting.packageShippingAddress1,
                  address2: state.userInfo.addressLine2,
                  city: state.setting.city,
                  country: state.setting.country,
                  zipCode: state.setting.zip,
                  state: state.setting.state,
                ),
                SizedBox(height: 1.6.h),
                AddressItemWidget(
                  title: 'Sea Shipping Address',
                  caption: 'Use this address for sea cargo shipments.',
                  icon: Icons.directions_boat_filled_outlined,
                  accentColor: const Color(0xFF12AEDD),
                  name: state.userInfo.userName,
                  address1: state.setting.seaShippingAddress1,
                  address2: state.setting.seaShippingAddress2,
                  city: state.setting.seaCity,
                  country: state.setting.seaCountry,
                  zipCode: state.setting.seaZip,
                  state: state.setting.seaState,
                ),
                SizedBox(height: 1.6.h),
                AddressItemWidget(
                  title: 'Air Express Shipping Address',
                  caption: 'Use this address for express shipments.',
                  icon: Icons.local_shipping_outlined,
                  accentColor: const Color(0xFFFF315B),
                  name: state.userInfo.userName,
                  address1: state.setting.expressShippingAddress1,
                  address2: state.setting.expressShippingAddress2,
                  city: state.setting.expressCity,
                  country: state.setting.expressCountry,
                  zipCode: state.setting.expressZip,
                  state: state.setting.expressState,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _AddressHero extends StatelessWidget {
  const _AddressHero();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.4.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF176DF2),
            Color(0xFF8F45C8),
            Color(0xFFFF315B),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x26176DF2),
            blurRadius: 24,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 13.w,
            height: 13.w,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.16),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.white.withOpacity(0.22)),
            ),
            child: Icon(
              Icons.location_on_outlined,
              color: Colors.white,
              size: 7.w,
            ),
          ),
          SizedBox(width: 4.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Shipping Addresses',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 0.6.h),
                Text(
                  'Copy the correct warehouse address for each shipping method.',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.86),
                    fontSize: 10.8.sp,
                    fontWeight: FontWeight.w500,
                    height: 1.28,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AddressItemWidget extends StatelessWidget {
  final String title;
  final String caption;
  final IconData icon;
  final Color accentColor;
  final String name;
  final String address1;
  final String address2;
  final String city;
  final String country;
  final String zipCode;
  final String state;

  const AddressItemWidget({
    super.key,
    required this.title,
    required this.caption,
    required this.icon,
    required this.accentColor,
    required this.name,
    required this.address1,
    required this.address2,
    required this.city,
    required this.country,
    required this.zipCode,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final fields = <_AddressField>[
      _AddressField('Name', name, Icons.person_outline_rounded),
      _AddressField('Address Line 1', address1, Icons.home_work_outlined),
      _AddressField('Address Line 2', address2, Icons.apartment_outlined),
      _AddressField('City', city, Icons.location_city_outlined),
      if (state.trim().isNotEmpty)
        _AddressField('State', state, Icons.map_outlined),
      _AddressField('Country', country, Icons.public_outlined),
      _AddressField('Zip Code', zipCode, Icons.markunread_mailbox_outlined),
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFEAF0FA)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1200133B),
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _IconTile(
                icon: icon,
                color: accentColor,
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: const Color(0xFF07132D),
                        fontSize: 14.5.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 0.35.h),
                    Text(
                      caption,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: const Color(0xFF7B8599),
                        fontSize: 9.8.sp,
                        fontWeight: FontWeight.w500,
                        height: 1.22,
                      ),
                    ),
                  ],
                ),
              ),
              _CopyButton(
                color: accentColor,
                onTap: () => _copyText(_fullAddress(fields)),
              ),
            ],
          ),
          SizedBox(height: 1.8.h),
          ...List.generate(fields.length, (index) {
            final field = fields[index];
            return Padding(
              padding: EdgeInsets.only(bottom: index == fields.length - 1 ? 0 : 0.9.h),
              child: _AddressFieldRow(
                field: field,
                accentColor: accentColor,
              ),
            );
          }),
          SizedBox(height: 1.5.h),
          SizedBox(
            width: double.infinity,
            height: 5.6.h,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: accentColor,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: () => _copyText(_fullAddress(fields)),
              icon: Icon(Icons.copy_rounded, size: 2.2.h),
              label: Text(
                'Copy Full Address',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static String _fullAddress(List<_AddressField> fields) {
    return fields
        .where((field) => field.value.trim().isNotEmpty)
        .map((field) => '${field.label}: ${field.value.trim()}')
        .join('\n');
  }

  static Future<void> _copyText(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    FlushSnackbar.showSnackBar('Copied to Clipboard');
  }
}

class _AddressField {
  final String label;
  final String value;
  final IconData icon;

  const _AddressField(this.label, this.value, this.icon);
}

class _AddressFieldRow extends StatelessWidget {
  final _AddressField field;
  final Color accentColor;

  const _AddressFieldRow({
    required this.field,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.2.w, vertical: 1.15.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF7FAFF),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFEAF0FA)),
      ),
      child: Row(
        children: [
          Icon(
            field.icon,
            color: accentColor,
            size: 2.25.h,
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  field.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: const Color(0xFF7B8599),
                    fontSize: 9.5.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 0.25.h),
                Text(
                  field.value.trim().isEmpty ? '-' : field.value,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: const Color(0xFF07132D),
                    fontSize: 11.4.sp,
                    fontWeight: FontWeight.w800,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 2.w),
          _CopyButton(
            color: accentColor,
            onTap: () => AddressItemWidget._copyText(field.value),
          ),
        ],
      ),
    );
  }
}

class _IconTile extends StatelessWidget {
  final IconData icon;
  final Color color;

  const _IconTile({
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12.w,
      height: 12.w,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Icon(
        icon,
        color: color,
        size: 6.w,
      ),
    );
  }
}

class _CopyButton extends StatelessWidget {
  final Color color;
  final VoidCallback onTap;

  const _CopyButton({
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(13),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(13),
        child: SizedBox(
          width: 10.w,
          height: 10.w,
          child: Icon(
            Icons.copy_rounded,
            color: color,
            size: 2.2.h,
          ),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final String message;
  final IconData icon;

  const _EmptyState({
    required this.message,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(4.w, 8.h, 4.w, 2.h),
      child: Center(
        child: Column(
          children: [
            Container(
              width: 18.w,
              height: 18.w,
              decoration: BoxDecoration(
                color: const Color(0xFFEAF3FF),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Icon(
                icon,
                color: const Color(0xFF176DF2),
                size: 8.w,
              ),
            ),
            SizedBox(height: 1.6.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF07132D),
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ShimmerLoading extends StatelessWidget {
  const _ShimmerLoading();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(4.w, 0.8.h, 4.w, 2.5.h),
      child: Column(
        children: [
          ShimmerWidget(
            radius: BorderRadius.circular(22),
            width: double.infinity,
            height: 13.h,
            child: const SizedBox.shrink(),
          ),
          SizedBox(height: 2.h),
          const ShimmerAddressItemWidget(),
          SizedBox(height: 1.6.h),
          const ShimmerAddressItemWidget(),
          SizedBox(height: 1.6.h),
          const ShimmerAddressItemWidget(),
        ],
      ),
    );
  }
}

class ShimmerAddressItemWidget extends StatelessWidget {
  const ShimmerAddressItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFEAF0FA)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1200133B),
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              ShimmerWidget(
                radius: BorderRadius.circular(15),
                width: 12.w,
                height: 12.w,
                child: const SizedBox.shrink(),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerWidget(
                      radius: BorderRadius.circular(8),
                      width: 46.w,
                      height: 2.4.h,
                      child: const SizedBox.shrink(),
                    ),
                    SizedBox(height: 0.8.h),
                    ShimmerWidget(
                      radius: BorderRadius.circular(8),
                      width: 58.w,
                      height: 1.6.h,
                      child: const SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 1.8.h),
          ...List.generate(5, (index) {
            return Padding(
              padding: EdgeInsets.only(bottom: index == 4 ? 0 : 0.9.h),
              child: ShimmerWidget(
                radius: BorderRadius.circular(14),
                width: double.infinity,
                height: 6.8.h,
                child: const SizedBox.shrink(),
              ),
            );
          }),
        ],
      ),
    );
  }
}
