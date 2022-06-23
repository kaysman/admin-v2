import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lng_adminapp/data/models/api_response.dart';
import 'package:lng_adminapp/data/models/workflow/standard_workflow.model.dart';
import 'package:lng_adminapp/data/models/workflow/workflow.model.dart';
import 'package:lng_adminapp/data/services/workflow.service.dart';

import '../../../data/enums/status.enum.dart';

enum FlowListStatus { idle, loading, error }

enum SingleFlowStatus {
  idle,
  loading,
  refreshing,
  error,
  creating,
  created,
  createError,
  updating,
  updateError,
}

class WorkflowState {
  final FlowListStatus flowListStatus;
  final SingleFlowStatus flowStatus;
  final WorkflowStandard? standards;
  final Map<StandardWorkflowType, WorkflowEntity?> workflowsByID;

  final List<WorkflowEntity>? workflows;
  final dynamic createError;

  const WorkflowState({
    this.flowListStatus = FlowListStatus.idle,
    this.flowStatus = SingleFlowStatus.idle,
    this.standards,
    this.workflows,
    this.createError,
    this.workflowsByID = const {},
  });

  WorkflowState copyWith({
    FlowListStatus? flowListStatus,
    SingleFlowStatus? flowStatus,
    WorkflowStandard? standards,
    List<WorkflowEntity>? workflows,
    dynamic createError,
    Map<StandardWorkflowType, WorkflowEntity?>? workflowsByID,
  }) {
    return WorkflowState(
      flowListStatus: flowListStatus ?? this.flowListStatus,
      flowStatus: flowStatus ?? this.flowStatus,
      standards: standards ?? this.standards,
      workflows: workflows ?? this.workflows,
      workflowsByID: workflowsByID ?? this.workflowsByID,
      createError: createError ?? this.createError,
    );
  }
}

class WorkflowBloc extends Cubit<WorkflowState> {
  WorkflowBloc() : super(WorkflowState());

  // ignore: todo
  // TODO get workflow standard names
  Future<void> getWorkflowStandardNames() async {
    emit(state.copyWith(flowListStatus: FlowListStatus.loading));
    try {
      var res = await WorkflowService.getStandardWorkflows();
      emit(state.copyWith(standards: res, flowListStatus: FlowListStatus.idle));
    } catch (_) {
      emit(state.copyWith(flowListStatus: FlowListStatus.error));
    }
  }

  // ignore: todo
  // TODO get workflow by id
  Future<void> getWorkflowByID(StandardWorkflowType id) async {
    if (state.workflowsByID[id] != null) {
      emit(state.copyWith(flowStatus: SingleFlowStatus.refreshing));
    } else {
      var flowsMap = <StandardWorkflowType, WorkflowEntity?>{};
      flowsMap.addAll(state.workflowsByID);
      flowsMap[id] = null;
      emit(state.copyWith(
        workflowsByID: flowsMap,
        flowStatus: SingleFlowStatus.loading,
      ));
    }
    try {
      var res = await WorkflowService.getWorkflowByID(id.name);
      WorkflowService.selectedWorkflow.value = res;
      var flowsMap = <StandardWorkflowType, WorkflowEntity?>{};
      state.workflowsByID
          .forEach((key, value) => flowsMap[key] = key == id ? res : value);
      emit(state.copyWith(
        workflowsByID: flowsMap,
        flowStatus: SingleFlowStatus.idle,
      ));
    } catch (_) {
      emit(state.copyWith(flowStatus: SingleFlowStatus.error));
    }
  }

  Future<void> createWorkflow(WorkflowEntity data) async {
    emit(state.copyWith(flowStatus: SingleFlowStatus.creating));
    ApiResponse? res;
    try {
      res = await WorkflowService.createWorkflow(data.toJson());
      if (res is ApiResponse && res.success == true) {
        emit(state.copyWith(flowStatus: SingleFlowStatus.created));
        loadWorkflows();
        WorkflowService.selectedWorkflow.value = null;
      }
    } catch (_) {
      emit(state.copyWith(
          flowStatus: SingleFlowStatus.createError,
          createError: "$_, ${res?.message}"));
    }
  }

  Future<void> loadWorkflows() async {
    emit(state.copyWith(flowListStatus: FlowListStatus.loading));
    try {
      var res = await WorkflowService.getWorkflows();
      emit(state.copyWith(workflows: res, flowListStatus: FlowListStatus.idle));
    } catch (_) {
      emit(state.copyWith(flowListStatus: FlowListStatus.error));
    }
  }

  Future<void> updateFlowDetails(StandardWorkflowType id,
      {String? name, String? description}) async {
    if (name == null && description == null) {
      assert(name == null, "name AND description can be NULL together");
    }
    emit(state.copyWith(flowStatus: SingleFlowStatus.updating));
    try {
      var res = await WorkflowService.updateDetails(
        id.name,
        name: name,
        description: description,
      );
      emit(state.copyWith(flowStatus: SingleFlowStatus.idle));
    } catch (_) {
      WorkflowService.selectedWorkflow.value = state.workflowsByID[id];
      emit(state.copyWith(flowStatus: SingleFlowStatus.updateError));
    }
  }

  clearErrorsStoredInState() {
    emit(state.copyWith(
      createError: null,
    ));
  }
}
