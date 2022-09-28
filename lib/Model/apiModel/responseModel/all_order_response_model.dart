// To parse this JSON data, do
//
//     final allOrderResponseModel = allOrderResponseModelFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators, prefer_null_aware_operators

import 'dart:convert';

AllOrderResponseModel allOrderResponseModelFromJson(String str) =>
    AllOrderResponseModel.fromJson(json.decode(str));

String allOrderResponseModelToJson(AllOrderResponseModel data) =>
    json.encode(data.toJson());

class AllOrderResponseModel {
  AllOrderResponseModel({
    this.success,
    this.data,
    this.message,
  });

  final bool? success;
  final List<Datum>? data;
  final String? message;

  factory AllOrderResponseModel.fromJson(Map<String, dynamic> json) =>
      AllOrderResponseModel(
        success: json["success"] == null ? true : json["success"],
        data: json["success"] == false
            ? []
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message == null ? null : message,
      };
}

class Datum {
  Datum({
    this.invoiceId,
    this.paymentMethod,
    this.id,
    this.date,
    this.timeSlot,
    this.total,
    this.driverTip,
    this.customerId,
    this.status,
    this.driverId,
    this.cancelReason,
    this.addressBookId,
    this.createdAt,
    this.updatedAt,
    this.customer,
    this.orderId,
    this.driver,
    this.orderHistory,
    this.payment,
    this.address,
  });

  final int? id;

  final DateTime? date;
  final String? timeSlot;
  final int? total;
  final int? driverTip;
  final int? customerId;
  final String? status;
  final int? driverId;
  final int? addressBookId;
  final dynamic cancelReason;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? invoiceId;
  final String? orderId;
  final String? paymentMethod;
  final Customer? customer;
  final Driver? driver;
  final List<OrderHistory>? orderHistory;
  final dynamic payment;
  final Address? address;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        timeSlot: json["time_slot"] == null ? null : json["time_slot"],
        total: json["total"] == null ? null : json["total"],
        driverTip: json["driver_tip"] == null ? null : json["driver_tip"],
        customerId: json["customer_id"] == null ? null : json["customer_id"],
        status: json["status"] == null ? null : json["status"],
        driverId: json["driver_id"] == null ? null : json["driver_id"],
        orderId: json["order_invoice"] == null ? null : json["order_invoice"],
        addressBookId:
            json["address_book_id"] == null ? null : json["address_book_id"],
        cancelReason: json["cancel_reason"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        invoiceId: json["invoice_id"] == null ? null : json["invoice_id"],
        paymentMethod:
            json["payment_method"] == null ? null : json["payment_method"],
        customer: json["customer"] == null
            ? null
            : Customer.fromJson(json["customer"]),
        driver: json["driver"] == null ? null : Driver.fromJson(json["driver"]),
        orderHistory: json["order_history"] == null
            ? null
            : List<OrderHistory>.from(
                json["order_history"].map((x) => OrderHistory.fromJson(x))),
        payment: json["payment"],
        address:
            json["address"] == null ? null : Address.fromJson(json["address"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "date": date == null
            ? null
            : "${date?.year.toString().padLeft(4, '0')}-${date?.month.toString().padLeft(2, '0')}-${date?.day.toString().padLeft(2, '0')}",
        "time_slot": timeSlot == null ? null : timeSlot,
        "total": total == null ? null : total,
        "driver_tip": driverTip == null ? null : driverTip,
        "customer_id": customerId == null ? null : customerId,
        "status": status == null ? null : status,
        "driver_id": driverId == null ? null : driverId,
        "order_invoice": orderId == null ? null : orderId,
        "address_book_id": addressBookId == null ? null : addressBookId,
        "cancel_reason": cancelReason,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "invoice_id": invoiceId == null ? null : invoiceId,
        "payment_method": paymentMethod == null ? null : paymentMethod,
        "customer": customer == null ? null : customer?.toJson(),
        "driver": driver == null ? null : driver?.toJson(),
        "order_history": orderHistory == null
            ? null
            : List<dynamic>.from(orderHistory!.map((x) => x.toJson())),
        "payment": payment,
        "address": address == null ? null : address?.toJson(),
      };
}

class Address {
  Address({
    this.id,
    this.location,
    this.latitude,
    this.longitude,
    this.customerId,
    this.createdAt,
    this.updatedAt,
    this.addressType,
  });

  final int? id;
  final String? location;
  final String? latitude;
  final String? longitude;
  final int? customerId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic addressType;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"] == null ? null : json["id"],
        location: json["location"] == null ? null : json["location"],
        latitude: json["latitude"] == null ? null : json["latitude"],
        longitude: json["longitude"] == null ? null : json["longitude"],
        customerId: json["customer_id"] == null ? null : json["customer_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        addressType: json["address_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "location": location == null ? null : location,
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
        "customer_id": customerId == null ? null : customerId,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "address_type": addressType,
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
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        paymentCustomerId: json["payment_customer_id"] == null
            ? null
            : json["payment_customer_id"],
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
        "payment_customer_id":
            paymentCustomerId == null ? null : paymentCustomerId,
        "email": email == null ? null : email,
      };
}

class Driver {
  Driver({
    this.id,
    this.name,
    this.mobile,
    this.email,
    this.licenceNo,
    this.vehicleNo,
    this.status,
    this.deviceToken,
    this.deviceType,
    this.createdAt,
    this.updatedAt,
    this.latitude,
    this.longitude,
  });

  final int? id;
  final String? name;
  final String? mobile;
  final String? email;
  final String? licenceNo;
  final String? vehicleNo;
  final String? status;
  final dynamic deviceToken;
  final dynamic deviceType;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic latitude;
  final dynamic longitude;

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        mobile: json["mobile"] == null ? null : json["mobile"],
        email: json["email"] == null ? null : json["email"],
        licenceNo: json["licence_no"] == null ? null : json["licence_no"],
        vehicleNo: json["vehicle_no"] == null ? null : json["vehicle_no"],
        status: json["status"] == null ? null : json["status"],
        deviceToken: json["device_token"],
        deviceType: json["device_type"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "mobile": mobile == null ? null : mobile,
        "email": email == null ? null : email,
        "licence_no": licenceNo == null ? null : licenceNo,
        "vehicle_no": vehicleNo == null ? null : vehicleNo,
        "status": status == null ? null : status,
        "device_token": deviceToken,
        "device_type": deviceType,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "latitude": latitude,
        "longitude": longitude,
      };
}

class OrderHistory {
  OrderHistory({
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

  factory OrderHistory.fromJson(Map<String, dynamic> json) => OrderHistory(
        id: json["id"] == null ? null : json["id"],
        quantity: json["quantity"] == null ? null : json["quantity"],
        type: json["type"] == null ? null : json["type"],
        productId: json["product_id"] == null ? null : json["product_id"],
        orderId: json["order_id"] == null ? null : json["order_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        product:
            json["product"] == null ? null : Product.fromJson(json["product"]),
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
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        imageUrl: json["image_url"] == null ? null : json["image_url"],
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
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
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "category": category == null ? null : category,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
      };
}
