import 'dart:developer';
import 'package:fuodz/constants/api.dart';
import 'package:fuodz/models/api_response.dart';
import 'package:fuodz/models/flash_sale.dart';
import 'package:fuodz/models/product.dart';
import 'package:fuodz/services/http.service.dart';

class FlashSaleRequest extends HttpService {
  Future<List<FlashSale>> getFlashSales({
    Map<String, dynamic> queryParams,
  }) async {
    Map<String, dynamic> params = {
      ...(queryParams != null ? queryParams : {}),
    };

    final apiResult = await get(
      Api.flashSales,
      queryParameters: params,
    );

    final apiResponse = ApiResponse.fromResponse(apiResult);
    log("123getFlashSales ${apiResponse.body}");
    log("123getFlashSales ${apiResponse.body}");
    if (apiResponse.allGood) {
      final data = (apiResponse.body as List)
          .map((jsonObject) => FlashSale.fromJson(jsonObject))
          .toList();
      log("data in flashlist=====> $data");
      return data;
    }

    throw apiResponse.message;
  }

  //
  Future<List<Product>> getProdcuts({
    Map<String, dynamic> queryParams,
    int page = 1,
  }) async {
    Map<String, dynamic> params = {
      ...(queryParams != null ? queryParams : {}),
      "page": "$page",
    };

    final apiResult = await get(
      Api.flashSales,
      queryParameters: params,
    );
    /*
    please check at backend side, I am not getting any response from the backend.
    I am sending the apk to you after checking at my side.
    */
    log("apiResult ${apiResult.data}");
    final apiResponse = ApiResponse.fromResponse(apiResult);
    log("123getProdcuts ${apiResponse.body}");
    log("123getProdcuts ${apiResponse.body.runtimeType}");
    productApi();
    if (apiResponse.allGood) {
      List<Product> prdList = [];
      for (var jsonObject in apiResponse.body) {
        prdList.add(Product.fromJson(jsonObject["item"]));
      }
      // final list = apiResponse.body.map((jsonObject) {
      //   log("========?>  ${jsonObject["item"]}");
      //   return Product.fromJson(jsonObject["item"]);
      // }).toList();
      log("========??>  ${prdList.first.availableQty}");
      return prdList;
    }
    log("========??>  ERRROR");
    throw apiResponse.message;
  }

  Future<List<Product>> productApi() async {
    final response = await get(Api.flashSales);
    log('productApi ${response.statusCode}');
    log('123productApi ${response.data}');

    if (response.statusCode == 200) {
      List result = (response.data);
      return result.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception();
    }
  }
}
