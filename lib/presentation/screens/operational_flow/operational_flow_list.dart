import 'package:lng_adminapp/data/models/workflow/workflow.model.dart';
import 'package:lng_adminapp/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lng_adminapp/data/enums/status.enum.dart';
import 'package:lng_adminapp/presentation/screens/operational_flow/create_flow.dart';

import 'active_flow_card/active-flow-card.dart';
import 'flow_bloc.dart';

class OperationalFlowList extends StatefulWidget {
  static const String routeName = "operational-flows";
  @override
  State<OperationalFlowList> createState() => _OperationalFlowListState();
}

class _OperationalFlowListState extends State<OperationalFlowList> {
  late WorkflowBloc workflowBloc;
  List<WorkflowEntity> selectedWorkflows = [];

  @override
  void initState() {
    workflowBloc = BlocProvider.of<WorkflowBloc>(context);
    if (workflowBloc.state.workflows == null) {
      workflowBloc.loadWorkflows();
    }

    if (workflowBloc.state.standards == null) {
      workflowBloc.getWorkflowStandardNames();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kGreyBackground,
      margin: EdgeInsets.all(Spacings.kSpaceLittleBig),
      child: BlocBuilder<WorkflowBloc, WorkflowState>(
        bloc: workflowBloc,
        builder: (context, state) {
          if (state.flowListStatus == FlowListStatus.error) {
            return TryAgainButton(
              tryAgain: () async {
                await workflowBloc.getWorkflowStandardNames();
              },
            );
          }

          if (state.flowListStatus == FlowListStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.workflows != null && state.workflows!.isEmpty) {
            return emptyContent(context, state);
          }

          return Column(
            children: [
              _header(state),
              SizedBox(height: 24),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 32,
                  ),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 45,
                          color: const Color(0xff000000).withOpacity(0.1),
                        ),
                      ],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Active Flows',
                        style: GoogleFonts.inter(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: kText1Color,
                        ),
                      ),
                      SizedBox(height: 24),
                      // List of active flows
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.workflows?.length ?? 0,
                          itemBuilder: (context, index) {
                            var data = state.workflows![index];
                            return ActiveFlowCard(
                              workflowEntity: data,
                              selected: selectedWorkflows.contains(data),
                              onChanged: (newValue) {
                                setState(() {
                                  if (newValue == true &&
                                      !selectedWorkflows.contains(data)) {
                                    selectedWorkflows.add(data);
                                  } else {
                                    selectedWorkflows.remove(data);
                                  }
                                });
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  _header(WorkflowState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Operational Flow',
          style: Theme.of(context).textTheme.headline1,
        ),
        Row(
          children: [
            AppIcons.svgAsset(AppIcons.help),
            SizedBox(width: 24.w),
            Button(
              primary: Theme.of(context).primaryColor,
              text: 'Create New Flow',
              textColor: kWhite,
              permissions: [PermissionType.CREATE_DRIVER],
              onPressed: () async {
                var res = await showWhiteDialog<StandardWorkflowType?>(
                  context,
                  _StandardWorkflowOptions(types: state.standards?.data ?? []),
                  true,
                );
              },
            ),
          ],
        )
      ],
    );
  }

  emptyContent(BuildContext context, WorkflowState state) {
    return Column(
      children: [
        _header(state),
        SizedBox(
          height: 32,
        ),
        Expanded(
          flex: 1,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 45,
                  color: const Color(0xff000000).withOpacity(0.1),
                ),
              ],
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AppIcons.empty_flow),
                const SizedBox(height: 48.0),
                Text("There are no operational flow here"),
                const SizedBox(height: 16.0),
                Text(
                    "Select one from pre-defined opearational flow or build your own. "),
                const SizedBox(height: 24.0),
                Button(
                  text: "Create now",
                  primary: kPrimaryColor,
                  textColor: kWhite,
                  onPressed: () async {
                    var res = await showWhiteDialog<StandardWorkflowType?>(
                      context,
                      _StandardWorkflowOptions(
                          types: state.standards?.data ?? []),
                      true,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _StandardWorkflowOptions extends StatelessWidget {
  _StandardWorkflowOptions({
    Key? key,
    this.types = const [],
  }) : super(key: key);

  final List<StandardWorkflowType> types;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Create operational flow"),
          const SizedBox(height: 24.0),
          ...types.map((e) {
            if (e.name == 'Custom') {
              return SizedBox();
            } else {
              return optionItem(context, e);
            }
          }).toList(),
        ],
      ),
    );
  }

  Widget optionItem(BuildContext context, StandardWorkflowType type) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(
            CreateOperationalFlowScreen.routeName,
            arguments: type,
          );
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            border: Border.all(color: kGrey3Color),
            borderRadius: BorderRadius.all(const Radius.circular(6)),
          ),
          child: Text(type.text),
        ),
      ),
    );
  }
}
