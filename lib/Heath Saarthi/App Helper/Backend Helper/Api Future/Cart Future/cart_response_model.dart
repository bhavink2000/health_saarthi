class CartResponseModel {
  final int status;
  final String message;
  final int count;
  final String amount;

  CartResponseModel(this.status, this.message, this.count, this.amount);
}