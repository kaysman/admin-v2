import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lng_adminapp/data/enums/status.enum.dart';
import 'package:lng_adminapp/presentation/screens/manage_flow/create_flow.dart';
import 'package:lng_adminapp/presentation/screens/operational_flow_list/flow_bloc.dart';
import 'package:lng_adminapp/shared.dart';

import 'active_flow_card/active-flow-card.dart';

class OperationalFlowList extends StatefulWidget {
  static const String routeName = "operational-flows";
  @override
  State<OperationalFlowList> createState() => _OperationalFlowListState();
}

class _OperationalFlowListState extends State<OperationalFlowList> {
  late WorkflowBloc workflowBloc;

  @override
  void initState() {
    workflowBloc = BlocProvider.of<WorkflowBloc>(context);
    workflowBloc.loadWorkflows();

    if (workflowBloc.state.standards == null) {
      workflowBloc.getWorkflowStandardNames();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: Spacings.kSpaceLittleBig,
        top: Spacings.kSpaceLittleBig,
        right: Spacings.kSpaceLittleBig,
      ),
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

          if ((state.flowListStatus == FlowListStatus.idle &&
                  state.workflows == null) ||
              state.workflows!.isEmpty) {
            return emptyContent(context, state);
          }

          return Column(
            children: [
              _header(state),
              const SizedBox(height: 32),
              Expanded(
                flex: 1,
                child: Container(
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
                      Container(
                        // margin: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                        padding:
                            EdgeInsets.symmetric(vertical: 24, horizontal: 32),
                        child: Text(
                          'Active Flows',
                          style: GoogleFonts.inter(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: kText1Color,
                          ),
                        ),
                      ),
                      // List of active flows
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.only(bottom: 32.0),
                          itemCount: state.workflows?.length ?? 0,
                          itemBuilder: (context, index) {
                            var data = state.workflows![index];
                            return ActiveFlowCard(
                              workflowEntity: data,
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
        Row(
          children: [
            Text(
              'Operational Flow',
              style: GoogleFonts.inter(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        Row(
          children: [
            AppIcons.svgAsset(AppIcons.help),
            SizedBox(
              width: 26,
            ),
            ElevatedButton(
              onPressed: () =>
                  showWorkflowTypesDialog(context, state.standards?.data ?? []),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
                padding: EdgeInsets.symmetric(
                  vertical: 9,
                  horizontal: 16,
                ),
              ),
              child: Text(
                'Create New Flow',
                style: GoogleFonts.inter(
                    fontSize: 18.sp, fontWeight: FontWeight.w500),
              ),
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
                  onPressed: () => showWorkflowTypesDialog(
                    context,
                    state.standards?.data ?? [],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  showWorkflowTypesDialog(
      BuildContext context, List<StandardWorkflowType> standards) async {
    var res = await showWhiteDialog<StandardWorkflowType?>(
      context,
      _StandardWorkflowOptions(types: standards),
      true,
    );
    if (res != null) {
      Navigator.of(context).pushNamed(
        CreateOperationalFlowScreen.routeName,
        arguments: res,
      );
    }
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
          ...types.map((e) => optionItem(context, e)).toList(),
        ],
      ),
    );
  }

  Widget optionItem(BuildContext context, StandardWorkflowType type) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop(type);
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
