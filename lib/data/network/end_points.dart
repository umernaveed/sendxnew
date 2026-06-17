abstract class EndPoints {
  static const String baseURL = 'https://sendxja.com/tracking';
  static const String registerUser = '/api/RegisterUser';
  static const String loginUser = '/api/loginUser';
  static const String forgotPassword = '/api/ForgotPassword';
  static const String changePassword = '/api/ChangePassword';
  static const String logout = '/api/Logout';
  static const String getProfile = '/api/GetProfile';
  static const String editProfile = '/api/EditProfile';
  static const String getOutlets = '/api/getOutlets';
  static const String getDashboardData = '/api/GetDashboardData';
  static const String getAddressData = '/api/GetAddressData';

  static const String getReadyforPickupPackages = '/api/GetPackagesSearch';
  static const String editAuthorizeUser = '/api/EditAuthorizeUser';
  static const String updateAuthorizeUser = '/api/UpdateAuthorizeUser';
  static const String addAuthorizeUser = '/api/AddAuthorizeUser';
  static const String getAuthorizeUsers = '/api/GetAuthorizeUsers';
  static const String deleteAuthorizeUser = '/api/DeleteAuthorizeUser';
  static const String getAllPackages = '/api/GetPackagesSearch';
  static const String getAllInvoices = '/api/GetInvoicesSearch';
  static const String invoicesDetail = '/api/InvoicesDetail';
  static const String addPurchase = '/api/AddPurchase';
  static const String updatePurchase = '/api/UpdatePurchase';
  static const String getPurchase = '/api/GetPurchase';
  static const String addPreAlert = '/api/AddPreAlert';
  static const String getDeliveryPackages = '/api/GetDeliveryPackages';
  static const String uploadInvoice = '/api/UploadInvoice';
  static const String getMetraAppInformation = '/api/GetMetraAppInformation';
  static const String deleteAccount = '/api/DeleteUser';
  static const String getReferralUsers = '/api/GetReferralUsers';
  static const String getManagePickUpDeliveryMeta = '/api/getAreas';

  static const String getNews = '/api/getNews';
  static const String createDeliveryRequest = '/api/CreateDeliveryRequest';
  static const String getManagers = '/api/getManagers';
  static const String getUnpaidInvoices = '/api/GetUnpaidInvoices';
  static const String lascoSinglePayInvoice = '/api/LascoSinglePayInvoice';
  static const String lascoMassPayInvoice = '/api/LascoMassPayInvoice';
  static const String createSupportTicket = '/api/CreateSupportTicket';
  static const String getSupportTickets = '/api/GetSupportTickets';
  static const String supportTicketDetail = '/api/SupportTicketDetail';
  static const String trackSupportTicket = '/api/TrackSupportTicket';
  static const String supportTicketIssueTypes = '/api/SupportTicketIssueTypes';
}
