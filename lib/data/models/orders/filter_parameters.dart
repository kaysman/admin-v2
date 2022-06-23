import 'package:json_annotation/json_annotation.dart';
import 'package:lng_adminapp/data/enums/status.enum.dart';

@JsonSerializable()
class OrderFilterParameters {
  const OrderFilterParameters({
    this.page = "1",
    this.limit = "10",
    this.sortOrder,
    this.sortBy,
    this.searchFilter,
    this.dateFilterType,
    this.startDate,
    this.endDate,
    this.specificFilterStatus,
    this.specificFilterTenantId,
    this.specificFilterMerchantId,
    this.specificFilterCreatedById,
    this.specificFilterWorkflowId,
    this.specificFilterServiceType,
    this.specificFilterServiceLevel,
    this.specificFilterDeliveryDateBasedOnUpload,
    this.specificFilterDeliveryDateBasedOnPickUp,
    this.specificFilterAllowWeekendDelivery,
    this.specificFilterPickUpRequested,
    this.specificFilterRequestedDeliveryTimeSlotType,
    this.specificFilterRequestedDeliveryTimeSlotStart,
    this.specificFilterRequestedDeliveryTimeSlotEnd,
    this.specificFilterCashOnDeliveryRequested,
    this.specificFilterCashOnDeliveryAmount,
    this.specificFilterCashOnDeliveryCurrency,
    this.specificFilterInsuredAmount,
    this.specificFilterInsuredAmountCurrency,
    this.specificFilterTypeOfWorkflowStep,
    this.specificFilterStatusOfChosenTypeOfWorkflowStep,
    this.requiredColumns,
    this.statusGroup,
  });

  final String? page;
  final String? limit;
  final String? sortOrder;
  final String? sortBy;
  final String? searchFilter;
  final DateFilterType? dateFilterType;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? specificFilterStatus;
  final String? specificFilterTenantId;
  final String? specificFilterMerchantId;
  final String? specificFilterCreatedById;
  final String? specificFilterWorkflowId;
  final String? specificFilterServiceType;
  final String? specificFilterServiceLevel;
  final String? specificFilterDeliveryDateBasedOnUpload;
  final String? specificFilterDeliveryDateBasedOnPickUp;
  final bool? specificFilterAllowWeekendDelivery;
  final bool? specificFilterPickUpRequested;
  final String? specificFilterRequestedDeliveryTimeSlotType;
  final String? specificFilterRequestedDeliveryTimeSlotStart;
  final String? specificFilterRequestedDeliveryTimeSlotEnd;
  final bool? specificFilterCashOnDeliveryRequested;
  final int? specificFilterCashOnDeliveryAmount;
  final String? specificFilterCashOnDeliveryCurrency;
  final int? specificFilterInsuredAmount;
  final String? specificFilterInsuredAmountCurrency;
  final String? specificFilterTypeOfWorkflowStep;
  final String? specificFilterStatusOfChosenTypeOfWorkflowStep;
  final List<String>? requiredColumns;
  final String? statusGroup;

  factory OrderFilterParameters.fromJson(Map<String, dynamic> json) =>
      OrderFilterParameters(
        page: json['page'],
        limit: json['limit'],
        dateFilterType: json['dateFilterType'],
        statusGroup: json['statusGroup'],
        sortOrder: json['sortOrder'],
        sortBy: json['sortBy'],
        searchFilter: json['searchFilter'],
        startDate: json['startDate'] != null
            ? DateTime.tryParse(json['startDate']!)
            : null,
        endDate: json['endDate'] != null
            ? DateTime.tryParse(json['endDate']!)
            : null,
        specificFilterStatus: json['specificFilterStatus'],
        specificFilterTenantId: json['specificFilterTenantId'],
        specificFilterMerchantId: json['specificFilterMerchantId'],
        specificFilterCreatedById: json['specificFilterCreatedById'],
        specificFilterWorkflowId: json['specificFilterWorkflowId'],
        specificFilterServiceType: json['specificFilterServiceType'],
        specificFilterServiceLevel: json['specificFilterServiceLevel'],
        specificFilterDeliveryDateBasedOnUpload:
            json['specificFilterDeliveryDateBasedOnUpload'],
        specificFilterDeliveryDateBasedOnPickUp:
            json['specificFilterDeliveryDateBasedOnPickUp'],
        specificFilterAllowWeekendDelivery:
            json['specificFilterAllowWeekendDelivery'],
        specificFilterPickUpRequested: json['specificFilterPickUpRequested'],
        specificFilterRequestedDeliveryTimeSlotType:
            json['specificFilterRequestedDeliveryTimeSlotType'],
        specificFilterRequestedDeliveryTimeSlotStart:
            json['specificFilterRequestedDeliveryTimeSlotStart'],
        specificFilterRequestedDeliveryTimeSlotEnd:
            json['specificFilterRequestedDeliveryTimeSlotEnd'],
        specificFilterCashOnDeliveryRequested:
            json['specificFilterCashOnDeliveryRequested'],
        specificFilterCashOnDeliveryAmount:
            json['specificFilterCashOnDeliveryAmount'],
        specificFilterCashOnDeliveryCurrency:
            json['specificFilterCashOnDeliveryCurrency'],
        specificFilterInsuredAmount: json['specificFilterInsuredAmount'],
        specificFilterInsuredAmountCurrency:
            json['specificFilterInsuredAmountCurrency'],
        specificFilterTypeOfWorkflowStep:
            json['specificFilterTypeOfWorkflowStep'],
        specificFilterStatusOfChosenTypeOfWorkflowStep:
            json['specificFilterStatusOfChosenTypeOfWorkflowStep'],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'page': this.page,
        'limit': this.limit,
        'sortOrder': this.sortOrder,
        'dateFilterType': this.dateFilterType?.name,
        'sortBy': this.sortBy,
        'searchFilter': this.searchFilter,
        'startDate': this.startDate?.toUtc(),
        'endDate': this.endDate?.toUtc(),
        'specificFilterStatus': this.specificFilterStatus,
        'specificFilterTenantId': this.specificFilterTenantId,
        'specificFilterMerchantId': this.specificFilterMerchantId,
        'specificFilterCreatedById': this.specificFilterCreatedById,
        'specificFilterWorkflowId': this.specificFilterWorkflowId,
        'specificFilterServiceType': this.specificFilterServiceType,
        'specificFilterServiceLevel': this.specificFilterServiceLevel,
        'specificFilterDeliveryDateBasedOnUpload':
            this.specificFilterDeliveryDateBasedOnUpload,
        'specificFilterDeliveryDateBasedOnPickUp':
            this.specificFilterDeliveryDateBasedOnPickUp,
        'specificFilterAllowWeekendDelivery':
            this.specificFilterAllowWeekendDelivery?.toString(),
        'specificFilterPickUpRequested':
            this.specificFilterPickUpRequested?.toString(),
        'specificFilterRequestedDeliveryTimeSlotType':
            this.specificFilterRequestedDeliveryTimeSlotType,
        'specificFilterRequestedDeliveryTimeSlotStart':
            this.specificFilterRequestedDeliveryTimeSlotStart,
        'specificFilterRequestedDeliveryTimeSlotEnd':
            this.specificFilterRequestedDeliveryTimeSlotEnd,
        'specificFilterCashOnDeliveryRequested':
            this.specificFilterCashOnDeliveryRequested?.toString(),
        'specificFilterCashOnDeliveryAmount':
            this.specificFilterCashOnDeliveryAmount,
        'specificFilterCashOnDeliveryCurrency':
            this.specificFilterCashOnDeliveryCurrency,
        'specificFilterInsuredAmount': this.specificFilterInsuredAmount,
        'specificFilterInsuredAmountCurrency':
            this.specificFilterInsuredAmountCurrency,
        'specificFilterTypeOfWorkflowStep':
            this.specificFilterTypeOfWorkflowStep,
        'specificFilterStatusOfChosenTypeOfWorkflowStep':
            this.specificFilterStatusOfChosenTypeOfWorkflowStep,
        'statusGroup': this.statusGroup,
      };
}
