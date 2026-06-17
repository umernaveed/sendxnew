import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:sendx/app/core/routes/app_pages.dart';
import 'package:sendx/presentation/account/bindings/account_binding.dart';
import 'package:sendx/presentation/account/bindings/add_pre_alert_binding.dart';
import 'package:sendx/presentation/account/bindings/get_all_delivery_packages_binding.dart';
import 'package:sendx/presentation/account/bindings/refferal_users_binding.dart';
import 'package:sendx/presentation/account/bindings/update_profile_biniding.dart';
import 'package:sendx/presentation/account/views/account_screen.dart';
import 'package:sendx/presentation/account/views/account_track_packages.dart';
import 'package:sendx/presentation/account/views/add_pre_alert.dart';
import 'package:sendx/presentation/account/views/refferal_users.dart';
import 'package:sendx/presentation/account/views/update_profile_screen.dart';
import 'package:sendx/presentation/auth/bindings/forget_password_binding.dart';
import 'package:sendx/presentation/auth/bindings/login_binding.dart';
import 'package:sendx/presentation/auth/bindings/reset_password_binding.dart';
import 'package:sendx/presentation/auth/bindings/signup_binding.dart';
import 'package:sendx/presentation/auth/views/forget_password_screen.dart';
import 'package:sendx/presentation/auth/views/login_screen.dart';
import 'package:sendx/presentation/auth/views/reset_password_screen.dart';
import 'package:sendx/presentation/auth/views/signup_screen.dart';
import 'package:sendx/presentation/authorize/bindings/add_authorize_user.dart';
import 'package:sendx/presentation/authorize/bindings/authorize_binding.dart';
import 'package:sendx/presentation/authorize/views/add_authorize_user.dart';
import 'package:sendx/presentation/authorize/views/authorize_screen.dart';
import 'package:sendx/presentation/bottom_nav/bindings/bottom_binding.dart';
import 'package:sendx/presentation/bottom_nav/views/bottom_nav.dart';
import 'package:sendx/presentation/dashboard/bindings/dashboard_binding.dart';
import 'package:sendx/presentation/dashboard/views/dashboard_main_screen.dart';
import 'package:sendx/presentation/delivery/bindings/delivery_binding.dart';
import 'package:sendx/presentation/delivery/bindings/address_search_binding.dart';
import 'package:sendx/presentation/delivery/bindings/manage_pickup_request_binding.dart';
import 'package:sendx/presentation/delivery/views/address_search_screen.dart';
import 'package:sendx/presentation/delivery/views/delivery_screen.dart';
import 'package:sendx/presentation/delivery/views/manage_pickup_request.dart';
import 'package:sendx/presentation/invoices/bindings/invoice_detail_binding.dart';
import 'package:sendx/presentation/invoices/bindings/invoices_binding.dart';
import 'package:sendx/presentation/invoices/views/invoice_details.dart';
import 'package:sendx/presentation/invoices/views/invoices_screen.dart';
import 'package:sendx/presentation/news/news_binding.dart';
import 'package:sendx/presentation/news/news_screen.dart';
import 'package:sendx/presentation/onboarding/bindings/onboarding_binding.dart';
import 'package:sendx/presentation/onboarding/views/splash_screen.dart';
import 'package:sendx/presentation/purchase/bindings/add_purchase_binding.dart';
import 'package:sendx/presentation/purchase/bindings/purchase_binding.dart';
import 'package:sendx/presentation/purchase/views/add_purchase.dart';
import 'package:sendx/presentation/purchase/views/purchase_screen.dart';
import 'package:sendx/presentation/support/bindings/support_binding.dart';
import 'package:sendx/presentation/support/views/support_screen.dart';
import 'package:sendx/presentation/unpaid_invoices/bindings/unpaid_invoices_binding.dart';
import 'package:sendx/presentation/unpaid_invoices/views/payment_web_view.dart';
import 'package:sendx/presentation/unpaid_invoices/views/unpaid_invoices.dart';

class AppRoutes {
  static String initialRoute = AppPages.splash;

  static final routes = [
    GetPage(
      name: AppPages.splash,
      page: () => const SplashScreen(),
      binding: OnBoardingBinding(),
      curve: Curves.ease,
    ),
    GetPage(
      name: AppPages.login,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
      curve: Curves.ease,
    ),
    GetPage(
      name: AppPages.signUp,
      page: () => const SignUpScreen(),
      binding: SignUpBinding(),
      curve: Curves.ease,
    ),
    GetPage(
      name: AppPages.forgetPassword,
      page: () => const ForgetPasswordScreen(),
      binding: ForgetPasswordBinding(),
      curve: Curves.ease,
    ),
    GetPage(
      name: AppPages.resetPassword,
      page: () => const ResetPasswordScreen(),
      binding: ResetPasswordBinding(),
      curve: Curves.ease,
    ),
    GetPage(
      name: AppPages.bottomNav,
      page: () => const BottomNavScreen(),
      binding: BottomNavBinding(),
      curve: Curves.ease,
    ),
    GetPage(
      name: AppPages.dashboard,
      page: () => const DashboardMainScreen(),
      binding: DashboardBinding(),
      curve: Curves.ease,
    ),
    GetPage(
      name: AppPages.authorizeUser,
      page: () => const AuthorizeScreen(),
      binding: AuthorizeBinding(),
      curve: Curves.ease,
    ),
    GetPage(
      name: AppPages.deliveryScreen,
      page: () => const DeliveryScreen(),
      binding: DeliveryBinding(),
      curve: Curves.ease,
    ),
    GetPage(
      name: AppPages.addPurchase,
      page: () => const AddPurchase(),
      binding: AddPurchaseBinding(),
      curve: Curves.ease,
    ),
    GetPage(
      name: AppPages.purchase,
      page: () => const PurchasesScreen(),
      binding: PurchaseBinding(),
      curve: Curves.ease,
    ),
    GetPage(
      name: AppPages.account,
      page: () => const AccountScreen(),
      binding: AccountBinding(),
      curve: Curves.ease,
    ),
    GetPage(
      name: AppPages.addAuthorizeUser,
      page: () => const AddAuthorizeUser(),
      binding: AddAuthorizeUserBinding(),
      curve: Curves.ease,
    ),
    GetPage(
      name: AppPages.addPreAlertScreen,
      page: () => const AddPreAlertScreen(),
      curve: Curves.ease,
      binding: AddPreControllerBinding(),
    ),
    GetPage(
      name: AppPages.trackPackages,
      page: () => const AccountTrackePackages(),
      curve: Curves.ease,
      binding: AllDeliveryPackagesBinding(),
    ),
    GetPage(
      name: AppPages.invoices,
      page: () => const InvoicesScreen(),
      binding: InvoicesBinding(),
      curve: Curves.ease,
    ),
    GetPage(
      name: AppPages.invoiceDetails,
      page: () => const InvoiceDetails(),
      binding: InvoiceDetailsBinding(),
      curve: Curves.ease,
    ),
    GetPage(
      name: AppPages.updateProfile,
      page: () => const UpdateProfileScreen(),
      binding: UpdateProfileBinding(),
      curve: Curves.ease,
    ),
    GetPage(
      name: AppPages.refferalUsers,
      page: () => const RefferralUsers(),
      binding: RefferalUsersBinding(),
      curve: Curves.ease,
    ),
    GetPage(
      name: AppPages.managePickupRequest,
      page: () => const ManagePickupRequest(),
      binding: ManagePickUpRequestBinding(),
      curve: Curves.ease,
    ),
    GetPage(
      name: AppPages.newsScreen,
      page: () => const NewsScreen(),
      binding: NewsBinding(),
      curve: Curves.ease,
    ),
    GetPage(
      name: AppPages.unpaidInvoicesScreen,
      page: () => const UnpaidInvoicesScreen(),
      binding: UnpaidInvoicesBinding(),
      curve: Curves.ease,
    ),
    GetPage(
      name: AppPages.paymentWebView,
      page: () => const PaymentWebView(),
      curve: Curves.ease,
    ),
    GetPage(
      name: AppPages.addressSearch,
      page: () => const AddressSearchScreen(),
      binding: AddressSearchBinding(),
      curve: Curves.ease,
    ),
    GetPage(
      name: AppPages.supportTickets,
      page: () => const SupportScreen(),
      binding: SupportBinding(),
      curve: Curves.ease,
    ),
  ];
}
