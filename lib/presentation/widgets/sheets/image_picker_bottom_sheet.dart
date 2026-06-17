import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sendx/app/services/image_service.dart';

class FilePickerBottomSheet extends StatelessWidget {
  const FilePickerBottomSheet({super.key, required this.onImageSelected});
  final ValueChanged<ImageSourceWrapper> onImageSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _PickerItems(onImageSelected: onImageSelected),
        const SizedBox(height: 40),
      ],
    );
  }
}

class _PickerItems extends StatelessWidget {
  const _PickerItems({required this.onImageSelected});
  final ValueChanged<ImageSourceWrapper> onImageSelected;

  @override
  Widget build(BuildContext context) {
    final items = [
      _PickerModel(
        iconURL: 'assets/svgs/ic_gallery.svg',
        title: 'Choose From Gallery',
        imageSourceWrapper: ImageSourceWrapper.gallery,
      ),
      _PickerModel(
        iconURL: 'assets/svgs/ic_camera.svg',
        title: 'Choose From Camera',
        imageSourceWrapper: ImageSourceWrapper.camera,
      ),
    ];
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () => onImageSelected(items[index].imageSourceWrapper),
          child: FilePickerTile(
            title: items[index].title,
            iconURL: items[index].iconURL,
            imageSourceWrapper: items[index].imageSourceWrapper,
          ),
        ),
        separatorBuilder: (context, index) => Divider(
          color: const Color.fromRGBO(3, 2, 15, 0.5).withOpacity(0.2),
          height: 0,
        ),
      ),
    );
  }
}

class FilePickerTile extends StatelessWidget {
  const FilePickerTile({
    super.key,
    required this.title,
    required this.iconURL,
    required this.imageSourceWrapper,
  });
  final String title;
  final String iconURL;
  final ImageSourceWrapper imageSourceWrapper;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 19, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              textAlign: TextAlign.start,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
          ),
          Flexible(
            child: SvgPicture.asset(
              iconURL,
              fit: BoxFit.cover,
              height: 23,
              width: 23,
            ),
          ),
        ],
      ),
    );
  }
}

class _PickerModel {
  _PickerModel({
    required this.title,
    required this.iconURL,
    required this.imageSourceWrapper,
  });

  final String title;
  final String iconURL;
  final ImageSourceWrapper imageSourceWrapper;
}
