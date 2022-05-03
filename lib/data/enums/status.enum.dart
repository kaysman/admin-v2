import 'package:json_annotation/json_annotation.dart';

enum Status {
  ORDER_CREATED,
  AWB_PRINTED,
  SHIPPING_LABEL_PRINTED,
  READY_FOR_PICK_UP,
  PICK_UP_CONFIRMED,
  ON_VEHICLE_TO_WAREHOUSE_FOR_SORTING,
  IN_WAREHOUSE_FOR_SORTING,
  ON_VEHICLE_TO_DISPATCH_POINT_FOR_DELIVERY_DISPATCH,
  ON_VEHICLE_FOR_DELIVERY,
  ORDER_COMPLETED,
  FAILED_PICK_UP,
  DELIVERY_FAILED_ON_VEHICLE_FOR_DELIVERY_REATTEMPT,
  DELIVERY_FAILED_ON_VEHICLE_TO_WAREHOUSE_FOR_SORTING_BEFORE_DELIVERY_REATTEMPT,
  DELIVERY_FAILED_ON_VEHICLE_TO_WAREHOUSE_FOR_SORTING_BEFORE_RETURN_TO_SENDER,
  DELIVERY_FAILED_IN_WAREHOUSE_FOR_SORTING_BEFORE_DELIVERY_REATTEMPT,
  DELIVERY_FAILED_IN_WAREHOUSE_FOR_SORTING_BEFORE_RETURN_TO_SENDER,
  DELIVERY_FAILED_ON_VEHICLE_TO_RETURN_TO_SENDER,
  DELIVERY_ENDED_RETURNED_TO_SENDER,
  CUSTOM,
}

extension StatusName on Status {
  String get text {
    switch (this) {
      case Status.SHIPPING_LABEL_PRINTED:
        return "SHIPPING_LABEL_PRINTED";
      case Status.READY_FOR_PICK_UP:
        return "PICKUP_READY";
      case Status.PICK_UP_CONFIRMED:
        return "PICK_UP_CONFIRMED";
      case Status.IN_WAREHOUSE_FOR_SORTING:
        return "IN_WAREHOUSE_FOR_SORTING";
      case Status.ON_VEHICLE_TO_DISPATCH_POINT_FOR_DELIVERY_DISPATCH:
        return "ON_VEHICLE_TO_DISPATCH_POINT";
      case Status.ON_VEHICLE_FOR_DELIVERY:
        return "ON_VEHICLE_FOR_DELIVERY";
      case Status.ORDER_COMPLETED:
        return "ORDER_COMPLETED";
      default:
        return "ORDER_CREATED";
    }
  }
}

extension StatusSplitName on Status {
  String get splitName {
    switch (this) {
      case Status.SHIPPING_LABEL_PRINTED:
        return "Shipping label printed";
      case Status.READY_FOR_PICK_UP:
        return "Pickup ready";
      case Status.PICK_UP_CONFIRMED:
        return "Pick up confirmed";
      case Status.IN_WAREHOUSE_FOR_SORTING:
        return "In warehouse for sorting";
      case Status.ON_VEHICLE_TO_DISPATCH_POINT_FOR_DELIVERY_DISPATCH:
        return "On vehicle to dispatch point";
      case Status.ON_VEHICLE_FOR_DELIVERY:
        return "On vehicle for delivery";
      case Status.ORDER_COMPLETED:
        return "Order completed";
      default:
        return "Order created";
    }
  }
}

enum PermissionType {
  // 1. address
  @JsonValue('create-address')
  CREATE_ADDRESS,
  @JsonValue('read-address')
  READ_ADDRESS,
  @JsonValue('update-address')
  UPDATE_ADDRESS,
  @JsonValue('delete-address')
  DELETE_ADDRESS,

  // 2. audit
  @JsonValue('create-audit-log')
  CREATE_AUDIT_LOG,
  @JsonValue('read-audit-log')
  READ_AUDIT_LOG,

  // 3. auth
  @JsonValue('log-in')
  LOG_IN,
  @JsonValue('change-password')
  CHANGE_PASSWORD,

  // 4. Customer

  // 5. Driver
  @JsonValue('create-driver')
  CREATE_DRIVER,
  @JsonValue('read-driver')
  READ_DRIVER,
  @JsonValue('update-driver')
  UPDATE_DRIVER,
  @JsonValue('delete-driver')
  DELETE_DRIVER,

  // 6. MERCHANT
  @JsonValue('create-merchant')
  CREATE_MERCHANT,
  @JsonValue('read-merchant')
  READ_MERCHANT,
  @JsonValue('update-merchant')
  UPDATE_MERCHANT,
  @JsonValue('delete-merchant')
  DELETE_MERCHANT,

  // 7. MODULE
  @JsonValue('create-module')
  CREATE_MODULE,
  @JsonValue('read-module')
  READ_MODULE,
  @JsonValue('update-module')
  UPDATE_MODULE,
  @JsonValue('delete-module')
  DELETE_MODULE,

  // 8. ORDER
  @JsonValue('create-order')
  CREATE_ORDER,
  @JsonValue('read-order')
  READ_ORDER,
  @JsonValue('update-order')
  UPDATE_ORDER,
  @JsonValue('delete-order')
  DELETE_ORDER,

  // 9. ORDER TIMELINE
  @JsonValue('create-order-timeline')
  CREATE_ORDER_TIMELINE,
  @JsonValue('read-order-timeline')
  READ_ORDER_TIMELINE,

  // 10. ORDER UPLOAD
  @JsonValue('create-order-upload')
  CREATE_ORDER_UPLOAD,
  @JsonValue('read-order-upload')
  READ_ORDER_UPLOAD,

  // 11. PERMISSION
  @JsonValue('create-permission')
  CREATE_PERMISSION,
  @JsonValue('read-permission')
  READ_PERMISSION,

  // 12. PROOF OF DELIVERY
  @JsonValue('create-proof-of-delivery')
  CREATE_PROOF_OF_DELIVERY,

  // 13. REQUEST
  @JsonValue('create-request')
  CREATE_REQUEST,
  @JsonValue('read-request')
  READ_REQUEST,
  @JsonValue('update-request')
  UPDATE_REQUEST,
  @JsonValue('delete-request')
  DELETE_REQUEST,

  // 14. ROLE
  @JsonValue('create-role')
  CREATE_ROLE,
  @JsonValue('read-role')
  READ_ROLE,
  @JsonValue('update-role')
  UPDATE_ROLE,
  @JsonValue('delete-role')
  DELETE_ROLE,

  // 15. TASK
  @JsonValue('create-task')
  CREATE_TASK,
  @JsonValue('read-task')
  READ_TASK,
  @JsonValue('update-task')
  UPDATE_TASK,
  @JsonValue('delete-task')
  DELETE_TASK,

  // 16. TEAM
  @JsonValue('create-team')
  CREATE_TEAM,
  @JsonValue('read-team')
  READ_TEAM,
  @JsonValue('update-team')
  UPDATE_TEAM,
  @JsonValue('delete-team')
  DELETE_TEAM,

  // 17. TENANT
  @JsonValue('create-tenant')
  CREATE_TENANT,
  @JsonValue('read-tenant')
  READ_TENANT,
  @JsonValue('update-tenant')
  UPDATE_TENANT,
  @JsonValue('delete-tenant')
  DELETE_TENANT,

  // 18. UPLOAD
  @JsonValue('create-upload')
  CREATE_UPLOAD,

  // 19. USER
  @JsonValue('create-user')
  CREATE_USER,
  @JsonValue('read-user')
  READ_USER,
  @JsonValue('update-user')
  UPDATE_USER,
  @JsonValue('delete-user')
  DELETE_USER,

  // 20. VEHICLE DETAILS

  // 21. WAREHOUSE
  @JsonValue('create-warehouse')
  CREATE_WAREHOUSE,
  @JsonValue('read-warehouse')
  READ_WAREHOUSE,
  @JsonValue('update-warehouse')
  UPDATE_WAREHOUSE,
  @JsonValue('delete-warehouse')
  DELETE_WAREHOUSE,

  // 22. WORKFLOW
  @JsonValue('create-workflow')
  CREATE_WORKFLOW,
  @JsonValue('read-workflow')
  READ_WORKFLOW,
  @JsonValue('update-workflow')
  UPDATE_WORKFLOW,
  @JsonValue('delete-workflow')
  DELETE_WORKFLOW,

  // WORKFLOW WAREHOUSE
  @JsonValue('create-workflow-warehouse')
  CREATE_WORKFLOW_WAREHOUSE,
  @JsonValue('read-workflow-warehouse')
  READ_WORKFLOW_WAREHOUSE,

  // WORKFLOW STEP
  @JsonValue('create-workflow-step')
  CREATE_WORKFLOW_STEP,
  @JsonValue('read-workflow-step')
  READ_WORKFLOW_STEP,
  @JsonValue('update-workflow-step')
  UPDATE_WORKFLOW_STEP,
  @JsonValue('delete-workflow-step')
  DELETE_WORKFLOW_STEP,

  // NEW
  @JsonValue("only-load-and-go-tech")
  ONLY_LOAD_AND_GO_TECH,

  // TASK SEQUENCING
  @JsonValue("create-task-sequencing")
  CREATE_TASK_SEQUENCING,
  @JsonValue("read-task-sequencing")
  READ_TASK_SEQUENCING,
  @JsonValue("update-task-sequencing")
  UPDATE_TASK_SEQUENCING,
  @JsonValue("delete-task-sequencing")
  DELETE_TASK_SEQUENCING,

  @JsonValue("read-vehicle-detail")
  READ_VEHICLE_DETAIL,

  // CREATE WORKFLOW AND WORKFLOW STEP
  @JsonValue("create-workflow-and-workflow-step")
  CREATE_WORKFLOW_AND_WORKFLOW_STEP,
  @JsonValue("read-workflow-and-workflow-step")
  READ_WORKFLOW_AND_WORKFLOW_STEP,
  @JsonValue("update-workflow-and-workflow-step")
  UPDATE_WORKFLOW_AND_WORKFLOW_STEP,
  @JsonValue("delete-workflow-and-workflow-step")
  DELETE_WORKFLOW_AND_WORKFLOW_STEP,
}

enum RoleType {
  LOAD_AND_GO,
  TENANT,
  MERCHANT,
  DRIVER,
  RECEIVER,
}

extension AddOns on RoleType {
  String get text {
    switch (this) {
      case RoleType.LOAD_AND_GO:
        return "LnG Super Admin";
      case RoleType.TENANT:
        return "Tenant";
      case RoleType.MERCHANT:
        return "Merchant";
      case RoleType.DRIVER:
        return "Driver";
      case RoleType.RECEIVER:
        return "Receiver";
      default:
        return "LnG Super Admin";
    }
  }
}

RoleType getRoleType(String name) {
  switch (name) {
    case "LnG Super Admin":
      return RoleType.LOAD_AND_GO;
    case "Tenant":
      return RoleType.TENANT;
    case "Merchant":
      return RoleType.MERCHANT;
    case "Driver":
      return RoleType.DRIVER;
    case "Receiver":
      return RoleType.RECEIVER;
    default:
      return RoleType.LOAD_AND_GO;
  }
}

enum StandardWorkflowType {
  @JsonValue("Pick_up_and_drop_off_directly")
  Pick_up_and_drop_off_directly,
  @JsonValue("To_warehouse_before_delivery")
  To_warehouse_before_delivery,
  @JsonValue("To_warehouse_and_dispatch_point_before_delivery")
  To_warehouse_and_dispatch_point_before_delivery,
  @JsonValue("Custom")
  Custom
}

extension Extras on StandardWorkflowType {
  String get text {
    switch (this) {
      case StandardWorkflowType.Pick_up_and_drop_off_directly:
        return "Pickup > Delivery";
      case StandardWorkflowType.To_warehouse_before_delivery:
        return "Pickup > Dispatch > Delivery";
      case StandardWorkflowType.To_warehouse_and_dispatch_point_before_delivery:
        return "Pickup > Warehouse > Dispatch Point > Delivery";
      case StandardWorkflowType.Custom:
        return "Build a customized flow";
      default:
        return "Build a customized flow";
    }
  }
}

enum ServiceType {
  LOCAL_PARCEL_LESSER_THAN_30KG,
  LOCAL_BULKY_30KG_TO_100KG,
  LOCAL_EXTRA_LARGE_MORE_THAN_100KG,
  INTERNATIONAL_PARCEL_LESSER_THAN_30KG,
  INTERNATIONAL_BULKY_MORE_THAN_30KG,

  // remove this
  NEXT_DAY
}

enum ServiceLevel {
  INSTANT_60_MINUTES,
  WITHIN_4_HOURS,
  SAME_DAY_BEFORE_10PM,
  NEXT_DAY,
  STANDARD_1_TO_3_DAY,
  STANDARD_INTERNATIONAL,
  EXPRESS_INTERNATIONAL,
  PRE_ARRANGED,
  // remove this
  LOCAL_PARCEL_LESSER_THAN_30KG,
}

enum DimensionUnitConversion {
  CENTIMETER,
  METER,
  INCHES,
  FOOT,
}

enum WeightUnitConversion {
  GRAM,
  KILOGRAM,
  TONNE,
  POUND,
}

enum TypeOfPackage {
  PARCEL,
  CARTON,
  PALLET,
  OTHER,
}

enum DeliveryTimeSlotType {
  STANDARD,
  TENANT_REQUESTED,
  MERCHANT_REQUESTED,
  RECEIVER_REQUESTED,
  DRIVER_REQUESTED,
  CUSTOM,
}

enum AddressType {
  HOME,
  OFFICE,
  WAREHOUSE,
}

enum SpecificTypeOfUser {
  LOAD_AND_GO,
  TENANT,
  SUB_TENANT,
  MERCHANT,
  SUB_MERCHANT,
  DRIVER,
  NOT_APPLICABLE,
}

enum GenericTypeOfUser {
  LOAD_AND_GO,
  TENANT,
  MERCHANT,
  DRIVER,
  RECEIVER,
  NOT_APPLICABLE,
}

enum DateRangeType {
  custom,
  today,
  yesterday,
  last7days,
  last30days,
  last90days,
  weekToDate,
  monthToDate,
}

extension Prop on DateRangeType {
  String get text {
    switch (this) {
      case DateRangeType.custom:
        return "Custom";
      case DateRangeType.today:
        return "Today";
      case DateRangeType.yesterday:
        return "Yesterday";
      case DateRangeType.last7days:
        return "Last 7 days";
      case DateRangeType.last30days:
        return "Last 30 days";
      case DateRangeType.last90days:
        return "Last 90 days";
      case DateRangeType.weekToDate:
        return "Week to date";
      case DateRangeType.monthToDate:
        return "Month to date";
      default:
        return "Today";
    }
  }
}

enum OrderFilterType {
  startDate,
  endDate,
  specificFilterStatus,
  specificFilterTenantId,
  specificFilterMerchantId,
  specificFilterCreatedById,
  specificFilterWorkflowId,
  specificFilterServiceType,
  specificFilterServiceLevel,
  specificFilterDeliveryDateBasedOnUpload,
  specificFilterDeliveryDateBasedOnPickUp,
  specificFilterAllowWeekendDelivery,
  specificFilterPickUpRequested,
  specificFilterRequestedDeliveryTimeSlotType,
  specificFilterRequestedDeliveryTimeSlotStart,
  specificFilterRequestedDeliveryTimeSlotEnd,
  specificFilterCashOnDeliveryRequested,
  specificFilterCashOnDeliveryAmount,
  specificFilterCashOnDeliveryCurrency,
  specificFilterInsuredAmount,
  specificFilterInsuredAmountCurrency
}

enum SpecificTypeOfLocation {
  LNG_TECH_TEAM_GENERATED,
  TENANT_WAREHOUSE,
  TENANT_DISPATCH_POINT,
  MERCHANT_ANY_LOCATION,
  DRIVER_PROFILE_LOCATION,
  SENDER_ADDRESS,
  RECEIVER_ADDRESS,

  // these are used only during the creation of tasks
  SPECIFIC_FOR_ONE_PICK_UP_TASK,
  SPECIFIC_FOR_ONE_DROP_OFF_TASK,

  // for ad-hoc uses
  CUSTOM_TASK_RELATED,
  CUSTOM_NOT_TASK_RELATED,

  // custom for driver group
  CUSTOM_FOR_DRIVER_DELIVERY_PICK_UP,

  NOT_APPLICABLE,
}

enum TypeOfOtherContactDetail {
  WAREHOUSE,
  DISPATCH_POINT,
  CUSTOM_FOR_DRIVER_DELIVERY_PICK_UP,
  OTHERS,
}

enum TypeOfContactForAddress {
  TENANT,
  MERCHANT,
  WAREHOUSE,
  DISPATCH_POINT,
  DRIVER,
  SENDER,
  RECEIVER,
  OTHER,
  CUSTOM_FOR_DRIVER_DELIVERY_PICK_UP,
}

enum TaskRelatedWorkflowSteps {
  ON_VEHICLE_TO_DISPATCH_POINT_FOR_DELIVERY_DISPATCH,
  ON_VEHICLE_TO_WAREHOUSE_FOR_SORTING,
  ON_VEHICLE_FOR_DELIVERY,

  // for ad-hoc uses
  // only task related required because this is specific to task related statuses
  CUSTOM_TASK_RELATED,
}

enum GenericTypeOfLocation {
  // this enum list is used to simplify task categorisation. only the 3 above are used in the task logic, more can be added down the road

  TENANT_WAREHOUSE,
  TENANT_DISPATCH_POINT,
  RECEIVER_ADDRESS,

  // these are used only during the creation of tasks
  SPECIFIC_FOR_ONE_PICK_UP_TASK,
  SPECIFIC_FOR_ONE_DROP_OFF_TASK,

  // for ad-hoc uses
  // only task related required because this is specific to task related statuses
  CUSTOM_TASK_RELATED,

  // custom for driver group
  CUSTOM_FOR_DRIVER_DELIVERY_PICK_UP,

  OTHERS,
}
