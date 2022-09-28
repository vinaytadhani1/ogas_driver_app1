class AcceptOrderRequestModel {
  String? status;
  String? orderId;

  AcceptOrderRequestModel({
    this.status,
    this.orderId,
  });
  Map<String, dynamic> toJson() {
    return {
      'order_id': orderId,
      'status': status,
    };
  }
}
