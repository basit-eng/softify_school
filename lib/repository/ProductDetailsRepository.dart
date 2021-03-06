import 'package:softify/model/AddToCartResponse.dart';
import 'package:softify/model/BaseResponse.dart';
import 'package:softify/model/SubscriptionStatusResponse.dart';
import 'package:softify/model/FileDownloadResponse.dart';
import 'package:softify/model/FileUploadResponse.dart';
import 'package:softify/model/ProductAttrChangeResponse.dart';
import 'package:softify/model/ProductDetailsResponse.dart';
import 'package:softify/model/SampleDownloadResponse.dart';
import 'package:softify/model/home/BestSellerProductResponse.dart';
import 'package:softify/model/requestbody/FormValuesRequestBody.dart';
import 'package:softify/networking/ApiBaseHelper.dart';
import 'package:softify/networking/Endpoints.dart';
import 'package:softify/utils/AppConstants.dart';
import 'package:softify/utils/FileResponse.dart';
import 'package:softify/utils/utility.dart';

class ProductDetailsRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<ProductDetailsResponse> fetchProductDetails(int productId) async {
    final response =
        await _helper.get('${Endpoints.productDetails}/$productId');
    return ProductDetailsResponse.fromJson(response);
  }

  Future<dynamic> addProductToCart(
      int productId, int cartType, FormValuesRequestBody requestBody) async {
    final response = await _helper.post(
        '${Endpoints.addProductToCart}/$productId/$cartType', requestBody);
    return AddToCartResponse.fromJson(response);
  }

  Future<BestSellerProductResponse> fetchRelatedProducts(int productId) async {
    final response =
        await _helper.get('${Endpoints.relatedProducts}/$productId/300');
    return BestSellerProductResponse.fromJson(response);
  }

  Future<BestSellerProductResponse> fetchCrossSellProducts(
      int productId) async {
    final response =
        await _helper.get('${Endpoints.crossSellProduct}/$productId/300');
    return BestSellerProductResponse.fromJson(response);
  }

  Future<ProductAttrChangeResponse> postSelectedAttributes(
    int productId,
    FormValuesRequestBody requestBody,
  ) async {
    final response = await _helper.post(
        '${Endpoints.productAttributeChange}/$productId', requestBody);
    return ProductAttrChangeResponse.fromJson(response);
  }

  Future<FileUploadResponse> uploadFile(
      String filePath, String attributeId) async {
    final response = await _helper.multipart(
        '${Endpoints.uploadFileProductAttribute}/$attributeId', filePath);
    return FileUploadResponse.fromJson(response);
  }

  Future<FileDownloadResponse> downloadSample(num productId) async {
    final FileResponse response =
        await _helper.getFile('${Endpoints.sampleDownload}/$productId');

    if (response.isFile) {
      return FileDownloadResponse<SampleDownloadResponse>(
        file: await saveFileToDisk(response, showNotification: true),
      );
    } else {
      return FileDownloadResponse<SampleDownloadResponse>(
        jsonResponse: SampleDownloadResponse.fromJson(response.jsonStr),
      );
    }
  }

  Future<SubscriptionStatusResponse> fetchSubscriptionStatus(
      num productId) async {
    final response =
        await _helper.get('${Endpoints.subscriptionStatus}/$productId');
    return SubscriptionStatusResponse.fromJson(response);
  }

  Future<BaseResponse> changeSubscriptionStatus(num productId) async {
    final response = await _helper.post(
        '${Endpoints.subscriptionStatus}/$productId',
        AppConstants.EMPTY_POST_BODY);
    return BaseResponse.fromJson(response);
  }

  Future<ProductDetailsResponse> fetchProductByBarcode(
      String barcodeValue) async {
    final response =
        await _helper.get('${Endpoints.productByBarcode}/$barcodeValue');
    return ProductDetailsResponse.fromJson(response);
  }
}
