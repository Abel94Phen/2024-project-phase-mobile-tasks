import 'package:ecommerce_app/core/platform/network_info.dart';
import 'package:ecommerce_app/core/usecase/usecase.dart';
import 'package:ecommerce_app/features/product/data/datasources/product_local_data_sources.dart';
import 'package:ecommerce_app/features/product/data/datasources/product_remote_data_sources.dart';
import 'package:ecommerce_app/features/product/domain/repositories/product_repository.dart';
import 'package:ecommerce_app/features/product/domain/usecases/create_product_usecase.dart';
import 'package:ecommerce_app/features/product/domain/usecases/delete_product_usecase.dart';
import 'package:ecommerce_app/features/product/domain/usecases/get_all_products_usecase.dart';
import 'package:ecommerce_app/features/product/domain/usecases/get_single_product_usecase.dart';
import 'package:ecommerce_app/features/product/domain/usecases/update_product_usecase.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';

@GenerateMocks(
  [
    ProductRepository,
    ProductRemoteDataSource,
    ProductLocalDataSource,
    Usecase,
    GetSingleProductUsecase,
    GetAllProductsUsecase,
    CreateProductUsecase,
    UpdateProductUsecase,
    DeleteProductUsecase,
    SharedPreferences,
    NetworkInfo,
    InternetConnectionChecker,
  ],
  customMocks :[MockSpec<http.Client>(as: #MockHttpClient)],
)

void main(){}