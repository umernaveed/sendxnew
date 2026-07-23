import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sendx/app/core/assets/drawables.dart';
import 'package:sendx/app/extensions/string_ext.dart';
import 'package:sendx/data/models/news/news.dart';
import 'package:sendx/presentation/base_screen.dart';
import 'package:sendx/presentation/news/news_controller.dart';
import 'package:sendx/presentation/widgets/shimmer_widget.dart';
import 'package:sizer/sizer.dart';

class NewsScreen extends GetView<NewsController> {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      showGradients: false,
      value: SystemUiOverlayStyle.dark,
      backgroundColor: const Color(0xFFF8FBFF),
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _NewsHeader(),
            Padding(
              padding: EdgeInsets.fromLTRB(4.w, .8.h, 4.w, 1.6.h),
              child: Text(
                'News & Updates',
                style: TextStyle(
                  color: const Color(0xFF07132D),
                  fontSize: 15.5.sp,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                color: const Color(0xFF176DF2),
                onRefresh: () => Future.sync(
                  () => controller.pagingController.refresh(),
                ),
                child: PagedListView<int, News>.separated(
                  pagingController: controller.pagingController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(3.8.w, 0, 3.8.w, 2.5.h),
                  builderDelegate: PagedChildBuilderDelegate<News>(
                    animateTransitions: true,
                    transitionDuration: 350.milliseconds,
                    firstPageProgressIndicatorBuilder: (_) =>
                        const _ShimmerListView(),
                    newPageProgressIndicatorBuilder: (_) =>
                        const _ShimmerListView(itemCount: 1),
                    noItemsFoundIndicatorBuilder: (_) => const _EmptyNews(),
                    itemBuilder: (context, item, index) {
                      return _NewsCard(news: item);
                    },
                  ),
                  separatorBuilder: (context, index) => SizedBox(height: 2.h),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NewsHeader extends StatelessWidget {
  const _NewsHeader();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 10.h,
      child: Center(
        child: SvgPicture.asset(
          'assets/svgs/app_logo_sendx.svg',
          width: 23.w,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class _NewsCard extends StatefulWidget {
  const _NewsCard({required this.news});

  final News news;

  @override
  State<_NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends State<_NewsCard> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    final news = widget.news;
    final plainDescription = _plainText(news.newsDescription);
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: const Color(0xFFEEF3FA)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12092341),
            blurRadius: 20,
            offset: Offset(0, 9),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(1.8.w, 1.3.h, 1.8.w, 0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(13),
              child: CachedNetworkImage(
                imageUrl: news.image,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 32.h,
                placeholder: (context, url) => Image.asset(
                  Drawables.emptyImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 32.h,
                ),
                errorWidget: (context, url, error) => Image.asset(
                  Drawables.emptyImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 32.h,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(4.w, 2.2.h, 4.w, 0),
            child: Text(
              news.title,
              maxLines: expanded ? null : 3,
              overflow: expanded ? TextOverflow.visible : TextOverflow.ellipsis,
              style: TextStyle(
                color: const Color(0xFF07132D),
                fontSize: 17.sp,
                fontWeight: FontWeight.w900,
                height: 1.2,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(4.w, 2.h, 4.w, 0),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_month_outlined,
                  color: const Color(0xFF07132D),
                  size: 2.5.h,
                ),
                SizedBox(width: 2.w),
                Text(
                  news.createdAt.toDDMMYYYY,
                  style: TextStyle(
                    color: const Color(0xFF6B7280),
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(4.w, 2.h, 4.w, 0),
            child: Text(
              plainDescription,
              maxLines: expanded ? null : 7,
              overflow: expanded ? TextOverflow.visible : TextOverflow.ellipsis,
              style: TextStyle(
                color: const Color(0xFF111827),
                fontSize: 12.7.sp,
                fontWeight: FontWeight.w500,
                height: 1.45,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(4.w, 2.h, 4.w, 0),
            child: const Divider(color: Color(0xFFE5EBF4), height: 1),
          ),
          TextButton(
            onPressed: () => setState(() => expanded = !expanded),
            style: TextButton.styleFrom(
              minimumSize: Size(double.infinity, 6.5.h),
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              foregroundColor: const Color(0xFF176DF2),
              shape: const RoundedRectangleBorder(),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.description_outlined,
                  color: const Color(0xFF176DF2),
                  size: 2.8.h,
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: Text(
                    expanded ? 'Show Less' : 'Read Full Announcement',
                    style: TextStyle(
                      color: const Color(0xFF176DF2),
                      fontSize: 11.5.sp,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Icon(
                  expanded
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.chevron_right_rounded,
                  color: const Color(0xFF176DF2),
                  size: 3.2.h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ShimmerListView extends StatelessWidget {
  const _ShimmerListView({this.itemCount = 2});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: itemCount,
      shrinkWrap: true,
      padding: EdgeInsets.fromLTRB(3.8.w, 0, 3.8.w, 2.5.h),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return ShimmerWidget(
          height: 62.h,
          radius: BorderRadius.circular(17),
          child: const SizedBox.shrink(),
        );
      },
      separatorBuilder: (context, index) => SizedBox(height: 2.h),
    );
  }
}

class _EmptyNews extends StatelessWidget {
  const _EmptyNews();

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: 20.h),
        Icon(
          Icons.campaign_outlined,
          color: const Color(0xFF9FB7D1),
          size: 8.h,
        ),
        SizedBox(height: 1.5.h),
        Text(
          'No news found',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: const Color(0xFF334155),
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

String _plainText(String html) {
  final withBreaks = html
      .replaceAll(RegExp(r'<br\s*/?>', caseSensitive: false), '\n')
      .replaceAll(RegExp(r'</p\s*>', caseSensitive: false), '\n\n')
      .replaceAll(RegExp(r'</div\s*>', caseSensitive: false), '\n');
  final noTags = withBreaks.replaceAll(RegExp(r'<[^>]*>'), ' ');
  return noTags
      .replaceAll('&nbsp;', ' ')
      .replaceAll('&amp;', '&')
      .replaceAll('&quot;', '"')
      .replaceAll('&#39;', "'")
      .replaceAll(RegExp(r'[ \t]+'), ' ')
      .replaceAll(RegExp(r'\n\s+\n'), '\n\n')
      .trim();
}
