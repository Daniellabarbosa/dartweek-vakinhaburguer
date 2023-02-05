import 'package:dw23_delivery_app/app/dto/order_product_dto.dart';
import 'package:dw23_delivery_app/app/models/product_model.dart';
import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

part 'home_state.g.dart';

@match
enum HomeStateStatus { initial, loading, loaded, nothing, error }

class HomeState extends Equatable {
  final HomeStateStatus status;
  final String? errorMessage;
  final List<ProductModel> products;
  final List<OrderProductDto> shoppingBag;

  const HomeState({required this.status, required this.products, required this.shoppingBag, this.errorMessage});

  const HomeState.initial()
      : status = HomeStateStatus.initial,
        products = const [],
        shoppingBag = const [],
        errorMessage = null;

  HomeState copyWith({
    HomeStateStatus? status,
    List<ProductModel>? products,
    List<OrderProductDto>? shoppingBag,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      products: products ?? this.products,
      shoppingBag: shoppingBag ?? this.shoppingBag,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, products, errorMessage, shoppingBag];
}
