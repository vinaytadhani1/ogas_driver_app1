class CancelOrderRequestModel {
  String? status;
  String? orderId;
  String? cancelReason;

  CancelOrderRequestModel({
    this.status,
    this.orderId,
    this.cancelReason,
  });
  Map<String, dynamic> toJson() {
    return {
      'order_id': orderId,
      'status': status,
      'cancel_reason': cancelReason,
    };
  }
}
