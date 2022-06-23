import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lng_adminapp/data/enums/status.enum.dart';
import 'package:lng_adminapp/data/models/workflow/flow_step.model.dart';
import 'package:lng_adminapp/data/models/workflow/workflow.model.dart';
import 'package:lng_adminapp/data/services/workflow.service.dart';
import 'package:lng_adminapp/presentation/screens/screens.dart';
import 'package:lng_adminapp/shared.dart';

import '../dialog/enums/dialog.enum.dart';
import '../dialog/response/response-dialog.view.dart';
import 'flow_bloc.dart';

class CreateOperationalFlowScreen extends StatefulWidget {
  static const String routeName = 'operational-flow';
  const CreateOperationalFlowScreen({
    Key? key,
    required this.selectedType,
  }) : super(key: key);

  final StandardWorkflowType selectedType;

  @override
  State<CreateOperationalFlowScreen> createState() =>
      _CreateOperationalFlowScreenState();
}

class _CreateOperationalFlowScreenState
    extends State<CreateOperationalFlowScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late WorkflowBloc workflowBloc;

  @override
  void initState() {
    workflowBloc = BlocProvider.of<WorkflowBloc>(context);
    workflowBloc.getWorkflowByID(widget.selectedType);
    super.initState();
  }

  String get flowTitle =>
      WorkflowService.selectedWorkflow.value?.name ?? "Unnamed";
  WorkflowEntity? get workflowInState =>
      workflowBloc.state.workflowsByID[widget.selectedType];

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
    return BlocConsumer<WorkflowBloc, WorkflowState>(
      listenWhen: (state1, state2) => state1.flowStatus != state2.flowStatus,
      listener: (context, state) {
        if (state.flowStatus == SingleFlowStatus.created) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(IndexScreen.routeName, (route) => false);
        }
        if (state.flowStatus == SingleFlowStatus.createError) {
          showWhiteDialog(
            context,
            ResponseDialog(
              type: DialogType.ERROR,
              message: "${state.createError}",
              onClose: () => {
                workflowBloc.clearErrorsStoredInState(),
                Navigator.of(context).pop(),
              },
            ),
          );
        }
      },
      builder: (context, state) {
        if (state.flowStatus == SingleFlowStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.flowStatus == SingleFlowStatus.error ||
            this.workflowInState == null) {
          return TryAgainButton(
            tryAgain: () async {
              await workflowBloc.getWorkflowByID(widget.selectedType);
            },
          );
        }

        return Container(
          decoration: _backgroundDecoration,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildHeader(state),
                Expanded(
                    child: buildNodes(this.workflowInState?.workFlowIds ?? [])),
              ],
            ),
          ),
        );
      },
    );
  }

  _buildHeader(WorkflowState state) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          SmallCircleButton(
            child: AppIcons.svgAsset(AppIcons.back_android),
            onTap: () => Navigator.of(context).pop(),
          ),
          SizedBox(width: Spacings.kSpaceSmall),
          Text(
            flowTitle,
            style: Theme.of(context).textTheme.headline1!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(width: Spacings.kSpaceSmall),
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
          Spacer(),
          Button(
            text: "Publish flow",
            textColor: kWhite,
            primary: kPrimaryColor,
            icon: AppIcons.svgAsset(AppIcons.lightning),
            isLoading: state.flowStatus == SingleFlowStatus.creating,
            onPressed: () async {
              if (WorkflowService.selectedWorkflow.value != null) {
                await workflowBloc
                    .createWorkflow(WorkflowService.selectedWorkflow.value!);
              }
            },
          ),
        ],
      ),
    );
  }

  buildNodes(List<StandardStep> nodeSteps) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: nodeSteps.length,
      itemBuilder: (context, index) {
        var node = nodeSteps[index];
        bool hasNext = node != nodeSteps.last;
        // bool selectWarehouse = node.;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (node.workflowStepName != null)
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
                    node.workflowStepName!,
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

/// DEPRECATED: MATERIALS TO USE IN CREATING CUSTOM FLOW
/// 
/// SmallCircleButton(child: AppIcons.svgAsset(AppIcons.undo)),
        // SizedBox(width: Spacings.kSpaceSmall),
        // SmallCircleButton(child: AppIcons.svgAsset(AppIcons.redo)),
/// 
/// 
/// // Row buildIsCompulsory(EventNode node) {
  //   return Row(
  //     children: [
  //       Text("Compulsory"),
  //       SizedBox(width: 8),
  //       SizedBox(
  //         width: 85,
  //         child: DropdownButtonFormField<bool>(
  //           value: node.isCompulsory,
  //           decoration: InputDecoration(
  //             isDense: true,
  //             contentPadding: EdgeInsets.symmetric(
  //               vertical: 4,
  //               horizontal: 13,
  //             ),
  //             border: const OutlineInputBorder(
  //               borderSide: const BorderSide(
  //                 color: Colors.white,
  //                 width: 0.0,
  //               ),
  //             ),
  //             enabledBorder: const OutlineInputBorder(
  //               borderSide: const BorderSide(
  //                 color: Colors.white,
  //                 width: 0.0,
  //               ),
  //             ),
  //           ),
  //           items: [true, false].map((e) {
  //             return DropdownMenuItem(
  //               value: e,
  //               child: Text(getCompulsoryButtonText(e)),
  //             );
  //           }).toList(),
  //           onChanged: (v) {},
  //         ),
  //       ),
  //     ],
  //   );
  // }
/// 
/// ElevatedButton(
        //   style: ElevatedButton.styleFrom(
        //     primary: Color(0xffE0E0E0),
        //     onPrimary: Colors.black,
        //   ),
        //   onPressed: () {},
        //   child: Text(
        //     "Preview",
        //     style: GoogleFonts.inter(
        //       fontSize: 14,
        //       fontWeight: FontWeight.bold,
        //     ),
        //   ),
        // ),
/// 
/// buildNodeOptions() {
  //   return Form(
  //     key: _formKey,
  //     child: Column(
  //       children: [
  //         Text("Operational Flow 1",
  //             style: GoogleFonts.inter(
  //               fontSize: 24,
  //               fontWeight: FontWeight.bold,
  //             )),
  //         Spacings.LITTLE_BIG_VERTICAL,
  //         Align(
  //           alignment: Alignment.centerLeft,
  //           child: Text("Steps",
  //               style: GoogleFonts.inter(
  //                 fontSize: 18,
  //                 fontWeight: FontWeight.w600,
  //               )),
  //         ),
  //         Spacings.SMALL_VERTICAL,
  //         ...List.generate(nodeSteps.length, (index) {
  //           var node = nodeSteps[index];
  //           return Padding(
  //             padding: const EdgeInsets.only(bottom: 16),
  //             child: GestureDetector(
  //               onTap: () {
  //                 setState(() {
  //                   nodeSteps.remove(node);
  //                   nodeSteps.insert(index, node.copyWith(isSelected: true));
  //                 });
  //               },
  //               child: Container(
  //                 width: double.infinity,
  //                 padding: EdgeInsets.all(16),
  //                 decoration: BoxDecoration(
  //                   color: Color(0xffEBF7F9),
  //                   borderRadius: BorderRadius.circular(6),
  //                 ),
  //                 child: Column(
  //                   mainAxisSize: MainAxisSize.min,
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(
  //                       node.title,
  //                       style: GoogleFonts.inter(
  //                         fontWeight: FontWeight.w500,
  //                       ),
  //                     ),
  //                     Text(node.description),
  //                     Padding(
  //                       padding: const EdgeInsets.only(
  //                         top: 12.0,
  //                       ),
  //                       child: ElevatedButton(
  //                         onPressed: () {
  //                           setState(() {
  //                             nodeSteps.remove(node);
  //                             nodeSteps.insert(
  //                                 index, node.copyWith(isSelected: true));
  //                           });
  //                         },
  //                         child: Text("Add to flow"),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           );
  //         }),
  //         Spacings.NORMAL_VERTICAL,
  //         Align(
  //           alignment: Alignment.centerLeft,
  //           child: Text("Steps if delivery failed",
  //               style: GoogleFonts.inter(
  //                 fontSize: 18,
  //                 fontWeight: FontWeight.w600,
  //               )),
  //         ),
  //         Spacings.SMALL_VERTICAL,
  //         ...List.generate(nodeFailSteps.length, (index) {
  //           var node = nodeFailSteps[index];
  //           return Padding(
  //             padding: const EdgeInsets.only(bottom: 16),
  //             child: GestureDetector(
  //               onTap: () {
  //                 setState(() {
  //                   nodeFailSteps.remove(node);
  //                   nodeFailSteps.insert(
  //                       index, node.copyWith(isSelected: true));
  //                 });
  //               },
  //               child: Column(mainAxisSize: MainAxisSize.min, children: [
  //                 Container(
  //                   width: double.infinity,
  //                   padding: EdgeInsets.all(16),
  //                   decoration: BoxDecoration(
  //                     color: Color(0xffEBF7F9),
  //                     borderRadius: BorderRadius.circular(6),
  //                   ),
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Text(
  //                         node.title,
  //                         style: GoogleFonts.inter(
  //                           fontWeight: FontWeight.w500,
  //                         ),
  //                       ),
  //                       if (node.isSelected)
  //                         Padding(
  //                           padding:
  //                               const EdgeInsets.only(top: 12.0, bottom: 12.0),
  //                           child: Text(node.description),
  //                         ),
  //                       if (node.isSelected) buildIsCompulsory(node)
  //                     ],
  //                   ),
  //                 ),
  //                 if (node.isSelected)
  //                   Padding(
  //                     padding: const EdgeInsets.only(
  //                       top: 12.0,
  //                     ),
  //                     child: ElevatedButton(
  //                       onPressed: () {
  //                         // if (!nodeSteps.where((e) => e.isSelected).contains(node)) {
  //                         //   nodeSteps.where((e) => e.isSelected).toList().add(node);
  //                         // }
  //                       },
  //                       child: Text("Add to flow"),
  //                     ),
  //                   ),
  //               ]),
  //             ),
  //           );
  //         }),
  //       ],
  //     ),
  //   );
  // }
// Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           width: size.width * 0.25,
//           padding: const EdgeInsets.all(24),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             boxShadow: kBoxShadow,
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: buildNodeOptions(),
//         ),
//         // TODO selected nodes part
//      Expanded(child: buildSelectedNodes()),
//    ],
// );