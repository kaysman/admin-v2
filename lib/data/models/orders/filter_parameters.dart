class OrderFilterParameters {
  const OrderFilterParameters({
    this.page,
    this.limit,
    this.sortOrder,
    this.sortBy,
    this.searchFilter,
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
  });

  final String? page;
  final String? limit;
  final String? sortOrder;
  final String? sortBy;
  final String? searchFilter;
  final String? startDate;
  final String? endDate;
  final String? specificFilterStatus;
  final String? specificFilterTenantId;
  final String? specificFilterMerchantId;
  final String? specificFilterCreatedById;
  final String? specificFilterWorkflowId;
  final String? specificFilterServiceType;
  final String? specificFilterServiceLevel;
  final String? specificFilterDeliveryDateBasedOnUpload;
  final String? specificFilterDeliveryDateBasedOnPickUp;
  final String? specificFilterAllowWeekendDelivery;
  final String? specificFilterPickUpRequested;
  final String? specificFilterRequestedDeliveryTimeSlotType;
  final String? specificFilterRequestedDeliveryTimeSlotStart;
  final String? specificFilterRequestedDeliveryTimeSlotEnd;
  final String? specificFilterCashOnDeliveryRequested;
  final String? specificFilterCashOnDeliveryAmount;
  final String? specificFilterCashOnDeliveryCurrency;
  final String? specificFilterInsuredAmount;
  final String? specificFilterInsuredAmountCurrency;
  final String? specificFilterTypeOfWorkflowStep;
  final String? specificFilterStatusOfChosenTypeOfWorkflowStep;

  factory OrderFilterParameters.fromJson(Map<String, String?> json) =>
      OrderFilterParameters(
        page: json['page'],
        limit: json['limit'],
        sortOrder: json['sortOrder'],
        sortBy: json['sortBy'],
        searchFilter: json['searchFilter'],
        startDate: json['startDate'],
        endDate: json['endDate'],
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

  Map<String, String?> toJson() => <String, String?>{
        'page': this.page,
        'limit': this.limit,
        'sortOrder': this.sortOrder,
        'sortBy': this.sortBy,
        'searchFilter': this.searchFilter,
        'startDate': this.startDate,
        'endDate': this.endDate,
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
            this.specificFilterAllowWeekendDelivery,
        'specificFilterPickUpRequested': this.specificFilterPickUpRequested,
        'specificFilterRequestedDeliveryTimeSlotType':
            this.specificFilterRequestedDeliveryTimeSlotType,
        'specificFilterRequestedDeliveryTimeSlotStart':
            this.specificFilterRequestedDeliveryTimeSlotStart,
        'specificFilterRequestedDeliveryTimeSlotEnd':
            this.specificFilterRequestedDeliveryTimeSlotEnd,
        'specificFilterCashOnDeliveryRequested':
            this.specificFilterCashOnDeliveryRequested,
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
      };
}
