import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sendx/app/core/assets/drawables.dart';
import 'package:sendx/data/models/news/news.dart';
import 'package:sendx/presentation/auth/widgets/auth_app_bar.dart';
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
      backgroundColor: const Color(0xFFFAF4F2).withOpacity(0.4),
      appBar: const AuthCustomAppBar.withSmallAppLogo(backButtonVisible: false),
      body: RefreshIndicator(
        onRefresh: () => Future.sync(
          () => controller.pagingController.refresh(),
        ),
        child: PagedListView<int, News>.separated(
          padding: EdgeInsets.only(top: 1.h, bottom: 3.h),
          physics: const AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          pagingController: controller.pagingController,
          scrollDirection: Axis.vertical,
          builderDelegate: PagedChildBuilderDelegate(
            animateTransitions: true,
            transitionDuration: 500.milliseconds,
            firstPageProgressIndicatorBuilder: (context) {
              return const _ShimmmerListView();
            },
            newPageProgressIndicatorBuilder: (context) {
              return const _ShimmmerListView();
            },
            itemBuilder: (context, item, index) {
              return _NewsItem(news: item);
            },
          ),
          separatorBuilder: (context, index) => SizedBox(height: 3.h),
        ),
      ),
    );
  }
}

class _NewsItem extends StatelessWidget {
  const _NewsItem({required this.news});
  final News news;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 0.5.h),
      width: context.width,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: news.image,
              fit: BoxFit.cover,
              width: context.width,
              height: 30.h,
              placeholder: (context, url) => Image.asset(
                Drawables.emptyImage,
                fit: BoxFit.cover,
                width: context.width,
                height: 30.h,
              ),
              errorWidget: (context, url, error) => Image.asset(
                Drawables.emptyImage,
                fit: BoxFit.fill,
                width: context.width,
                height: 30.h,
              ),
            ),
          ),
          SizedBox(height: 1.h),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              news.title,
              textAlign: TextAlign.justify,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.bodyLarge?.copyWith(
                color: Colors.black,
                fontSize: 16.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(
            width: context.width,
            child: Html(
              data: news.newsDescription,
              shrinkWrap: true,
            ),
          ),
          // SizedBox(height: 1.h),
        ],
      ),
    );
  }
}

class _ShimmmerListView extends StatelessWidget {
  const _ShimmmerListView();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 4,
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0.5.h),
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return ShimmerWidget(
          height: 45.h,
          radius: BorderRadius.circular(10),
          child: const SizedBox.shrink(),
        );
      },
      separatorBuilder: (context, index) => SizedBox(height: 3.h),
    );
  }
}
