// To parse this JSON data, do
//
//     final acceptOrderResponseModel = acceptOrderResponseModelFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators, prefer_null_aware_operators

import 'dart:convert';

AcceptOrderResponseModel acceptOrderResponseModelFromJson(String str) => AcceptOrderResponseModel.fromJson(json.decode(str));

String acceptOrderResponseModelToJson(AcceptOrderResponseModel data) => json.encode(data.toJson());

class AcceptOrderResponseModel {
  AcceptOrderResponseModel({
    this.success,
    this.data,
    this.message,
  });

  final bool? success;
  final Data? data;
  final String? message;

  factory AcceptOrderResponseModel.fromJson(Map<String, dynamic> json) => AcceptOrderResponseModel(
        success: json["success"] == null ? true : json["success"],
        data: json["success"] == false ? Data() : Data.fromJson(json["data"]),
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "data": data == null ? null : data?.toJson(),
        "message": message == null ? null : message,
      };
}

class Data {
  Data({
    this.id,
    this.location,
    this.latitude,
    this.longitude,
    this.date,
    this.timeSlot,
    this.total,
    this.driverTip,
    this.customerId,
    this.status,
    this.driverId,
    this.cancelReason,
    this.createdAt,
    this.updatedAt,
    this.customer,
    this.driver,
    this.orderHistory,
    this.payment,
  });

  final int? id;
  final String? location;
  final String? latitude;
  final String? longitude;
  final DateTime? date;
  final String? timeSlot;
  final int? total;
  final int? driverTip;
  final int? customerId;
  final String? status;
  final int? driverId;
  final dynamic cancelReason;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Customer? customer;
  final dynamic driver;
  final List<AcceptOrderHistory>? orderHistory;
  final dynamic payment;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] == null ? null : json["id"],
        location: json["location"] == null ? null : json["location"],
        latitude: json["latitude"] == null ? null : json["latitude"],
        longitude: json["longitude"] == null ? null : json["longitude"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        timeSlot: json["time_slot"] == null ? null : json["time_slot"],
        total: json["total"] == null ? null : json["total"],
        driverTip: json["driver_tip"] == null ? null : json["driver_tip"],
        customerId: json["customer_id"] == null ? null : json["customer_id"],
        status: json["status"] == null ? null : json["status"],
        driverId: json["driver_id"] == null ? null : json["driver_id"],
        cancelReason: json["cancel_reason"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        customer: json["customer"] == null ? null : Customer.fromJson(json["customer"]),
        driver: json["driver"],
        orderHistory: json["order_history"] == null ? null : List<AcceptOrderHistory>.from(json["order_history"].map((x) => AcceptOrderHistory.fromJson(x))),
        payment: json["payment"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "location": location == null ? null : location,
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
        "date": date == null ? null : "${date?.year.toString().padLeft(4, '0')}-${date?.month.toString().padLeft(2, '0')}-${date?.day.toString().padLeft(2, '0')}",
        "time_slot": timeSlot == null ? null : timeSlot,
        "total": total == null ? null : total,
        "driver_tip": driverTip == null ? null : driverTip,
        "customer_id": customerId == null ? null : customerId,
        "status": status == null ? null : status,
        "driver_id": driverId == null ? null : driverId,
        "cancel_reason": cancelReason,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "customer": customer == null ? null : customer?.toJson(),
        "driver": driver,
        "order_history": orderHistory == null ? null : List<dynamic>.from(orderHistory!.map((x) => x.toJson())),
        "payment": payment,
      };
}

class Customer {
  Customer({
    this.id,
    this.name,
    this.mobile,
    this.address,
    this.deviceToken,
    this.deviceType,
    this.createdAt,
    this.updatedAt,
    this.paymentCustomerId,
    this.email,
  });

  final int? id;
  final String? name;
  final String? mobile;
  final dynamic address;
  final dynamic deviceToken;
  final dynamic deviceType;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? paymentCustomerId;
  final String? email;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        mobile: json["mobile"] == null ? null : json["mobile"],
        address: json["address"],
        deviceToken: json["device_token"],
        deviceType: json["device_type"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        paymentCustomerId: json["payment_customer_id"] == null ? null : json["payment_customer_id"],
        email: json["email"] == null ? null : json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "mobile": mobile == null ? null : mobile,
        "address": address,
        "device_token": deviceToken,
        "device_type": deviceType,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "payment_customer_id": paymentCustomerId == null ? null : paymentCustomerId,
        "email": email == null ? null : email,
      };
}

class AcceptOrderHistory {
  AcceptOrderHistory({
    this.id,
    this.quantity,
    this.type,
    this.productId,
    this.orderId,
    this.createdAt,
    this.updatedAt,
    this.product,
  });

  final int? id;
  final int? quantity;
  final String? type;
  final int? productId;
  final int? orderId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Product? product;

  factory AcceptOrderHistory.fromJson(Map<String, dynamic> json) => AcceptOrderHistory(
        id: json["id"] == null ? null : json["id"],
        quantity: json["quantity"] == null ? null : json["quantity"],
        type: json["type"] == null ? null : json["type"],
        productId: json["product_id"] == null ? null : json["product_id"],
        orderId: json["order_id"] == null ? null : json["order_id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        product: json["product"] == null ? null : Product.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "quantity": quantity == null ? null : quantity,
        "type": type == null ? null : type,
        "product_id": productId == null ? null : productId,
        "order_id": orderId == null ? null : orderId,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "product": product == null ? null : product?.toJson(),
      };
}

class Product {
  Product({
    this.id,
    this.productName,
    this.refillPrice,
    this.newPrice,
    this.categoryId,
    this.createdAt,
    this.updatedAt,
    this.imageUrl,
    this.category,
  });

  final int? id;
  final String? productName;
  final String? refillPrice;
  final String? newPrice;
  final int? categoryId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? imageUrl;
  final Category? category;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"] == null ? null : json["id"],
        productName: json["product_name"] == null ? null : json["product_name"],
        refillPrice: json["refill_price"] == null ? null : json["refill_price"],
        newPrice: json["new_price"] == null ? null : json["new_price"],
        categoryId: json["category_id"] == null ? null : json["category_id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        imageUrl: json["image_url"] == null ? null : json["image_url"],
        category: json["category"] == null ? null : Category.fromJson(json["category"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "product_name": productName == null ? null : productName,
        "refill_price": refillPrice == null ? null : refillPrice,
        "new_price": newPrice == null ? null : newPrice,
        "category_id": categoryId == null ? null : categoryId,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "image_url": imageUrl == null ? null : imageUrl,
        "category": category == null ? null : category?.toJson(),
      };
}

class Category {
  Category({
    this.id,
    this.category,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final String? category;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"] == null ? null : json["id"],
        category: json["category"] == null ? null : json["category"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "category": category == null ? null : category,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
      };
}
