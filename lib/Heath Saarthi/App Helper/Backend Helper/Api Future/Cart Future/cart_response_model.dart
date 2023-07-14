class CartResponseModel {
  final int status;
  final String message;
  final dynamic count;
  final dynamic amount;

  CartResponseModel(this.status, this.message, this.count, this.amount);
}