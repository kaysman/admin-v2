import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lng_adminapp/data/models/workflow/flow_step.model.dart';
import 'package:lng_adminapp/data/models/workflow/workflow.model.dart';
import 'package:lng_adminapp/data/services/workflow.service.dart';
import 'package:lng_adminapp/shared.dart';

import 'flow_bloc.dart';

class OperationalFlowDetailScreen extends StatefulWidget {
  static const String routeName = 'operational-flow-detail';
  const OperationalFlowDetailScreen({
    Key? key,
    required this.workflowEntity,
  }) : super(key: key);

  final WorkflowEntity workflowEntity;

  @override
  State<OperationalFlowDetailScreen> createState() =>
      _OperationalFlowDetailScreenState();
}

class _OperationalFlowDetailScreenState
    extends State<OperationalFlowDetailScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late WorkflowBloc workflowBloc;

  @override
  void initState() {
    workflowBloc = BlocProvider.of<WorkflowBloc>(context);
    super.initState();
  }

  Decoration get _backgroundDecoration {
    return BoxDecoration(
      color: Color(0xffF6F5FA),
      image: DecorationImage(
        fit: BoxFit.cover,
        image: AssetImage(AppIcons.dots),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _backgroundDecoration,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: buildNodes(
                  widget.workflowEntity.workflowAndWorkflowStep ?? []),
            ),
          ],
        ),
      ),
    );
  }

  _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          SmallCircleButton(
            child: AppIcons.svgAsset(AppIcons.back_android),
            onTap: () => Navigator.of(context).pop(),
          ),
          SizedBox(width: Spacings.kSpaceSmall),
          Text(widget.workflowEntity.name ?? '',
              style: Theme.of(context).textTheme.headline1),
          SizedBox(width: Spacings.kSpaceSmall),
          Text("Viewing Screen", style: Theme.of(context).textTheme.caption),
          // SizedBox(width: Spacings.kSpaceSmall),
          // InkWell(
          //   child: AppIcons.svgAsset(AppIcons.edit2),
          //   onTap: () async {
          //     final WorkflowEntity? res =
          //         await showWhiteDialog<WorkflowEntity?>(
          //       context,
          //       _UpdateDetails(
          //         name: WorkflowService.selectedWorkflow.value?.name ?? "",
          //         description:
          //             WorkflowService.selectedWorkflow.value?.description ?? "",
          //       ),
          //       true,
          //     );
          //     if (res != null) {
          //       workflowBloc.updateFlowDetails(
          //         widget.selectedType,
          //         name: res.name,
          //         description: res.description,
          //       );
          //     }
          //   },
          // ),
        ],
      ),
    );
  }

  buildNodes(List<FlowStepEntity> nodeSteps) {
    nodeSteps.sort((a, b) => a.sequence!.compareTo(b.sequence!));
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: nodeSteps.length,
      itemBuilder: (context, index) {
        var node = nodeSteps[index];
        bool hasNext = node != nodeSteps.last;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (node.workflowStep != null)
              Container(
                width: 160,
                padding: EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: kPrimaryColor),
                ),
                child: Center(
                  child: Text(
                    node.workflowStep?.name ?? '',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            if (hasNext) AppIcons.svgAsset(AppIcons.halfCircle),
            if (hasNext)
              Container(
                width: 24,
                child: SizedBox(
                  height: 50,
                  child: VerticalDivider(
                    indent: 0,
                    endIndent: 0,
                    thickness: 1.8,
                    color: Color(0xff828282),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  String getCompulsoryButtonText(bool e) {
    switch (e) {
      case false:
        return 'No';
      case true:
        return 'Yes';
      default:
        return 'No';
    }
  }
}

class _UpdateDetails extends StatefulWidget {
  const _UpdateDetails({
    Key? key,
    required this.name,
    required this.description,
  }) : super(key: key);

  final String name;
  final String description;

  @override
  State<_UpdateDetails> createState() => _UpdateDetailsState();
}

class _UpdateDetailsState extends State<_UpdateDetails> {
  final flowNameController = TextEditingController();
  final flowDescController = TextEditingController();

  @override
  void initState() {
    flowNameController.addListener(() {
      setState(() {});
    });

    flowDescController.addListener(() {
      setState(() {});
    });

    flowNameController.text = widget.name;
    flowDescController.text = widget.description;
    super.initState();
  }

  @override
  void dispose() {
    flowNameController.dispose();
    flowDescController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    bool nameChanged = flowNameController.text != widget.name;
    bool descChanged = flowDescController.text != widget.description;
    bool hasChanged = nameChanged || descChanged;

    return Container(
      width: size.width * 0.3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LabeledInput(
              label: "Operational Flow Name",
              hintText: "Name",
              controller: flowNameController,
            ),
            const SizedBox(height: 16.0),
            LabeledInput(
              label: "Operational Flow Description",
              hintText: "Description",
              controller: flowDescController,
              maxLine: 5,
            ),
            const SizedBox(height: 16.0),
            RowOfTwoChildren(
              child1: Button(
                text: "Cancel",
                elevation: 0.5,
                primary: kWhite,
                textColor: kPrimaryColor,
                onPressed: () => Navigator.of(context).pop(),
              ),
              child2: Button(
                text: "Update",
                primary: kPrimaryColor,
                textColor: kWhite,
                onPressed: !hasChanged
                    ? null
                    : () {
                        WorkflowService.selectedWorkflow.value =
                            WorkflowService.selectedWorkflow.value!.copyWith(
                                name: nameChanged
                                    ? flowNameController.text
                                    : null,
                                description: descChanged
                                    ? flowDescController.text
                                    : null);
                        Navigator.of(context).pop(WorkflowEntity(
                          name: nameChanged ? flowNameController.text : null,
                          description:
                              descChanged ? flowDescController.text : null,
                        ));
                      },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
