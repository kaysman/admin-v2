import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lng_adminapp/presentation/blocs/auth/auth.bloc.dart';
import 'package:lng_adminapp/presentation/blocs/auth/auth.state.dart';
import 'package:lng_adminapp/presentation/screens/index/index.cubit.dart';
import 'package:lng_adminapp/presentation/screens/login/login.bloc.dart';
import 'package:lng_adminapp/shared.dart';

class CollapsibleSideBar extends StatefulWidget {
  const CollapsibleSideBar({
    Key? key,
    required this.items,
    this.isCollapsed = false,
    this.minWidth = 62,
  }) : super(key: key);

  final List<SideBarItem> items;
  final bool isCollapsed;
  final double minWidth;

  @override
  _CollapsibleSideBarState createState() => _CollapsibleSideBarState();
}

class _CollapsibleSideBarState extends State<CollapsibleSideBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _widthAnimation;
  late CurvedAnimation _curvedAnimation;
  late double tempWidth;
  late IndexCubit indexCubit;
  late LoginBloc loginBloc;
  late AuthBloc authBloc;

  late double _currWidth, _delta, _delta1By4, _delta3by4, _maxOffsetX, _maxOffsetY;

  late int _selectedItemIndex;
  late bool _isCollapsed;

  @override
  void initState() {
    assert(widget.items.isNotEmpty);
    authBloc = BlocProvider.of<AuthBloc>(context);
    loginBloc = LoginBloc(authBloc);
    super.initState();

    tempWidth = 0.25.sw;
    _isCollapsed = widget.isCollapsed;
    _currWidth = _isCollapsed ? widget.minWidth : tempWidth;
    _delta = tempWidth - widget.minWidth;
    _delta1By4 = _delta * 0.25;
    _delta3by4 = _delta * 0.75;
    _maxOffsetX = 6 * 2 + 24;
    _maxOffsetY = 6 * 2 + 24;

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.decelerate,
    );

    _controller.addListener(() {
      _currWidth = _widthAnimation.value;
      if (_controller.isCompleted) _isCollapsed = _currWidth == widget.minWidth;
      setState(() {});
    });

    indexCubit = IndexCubit();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IndexCubit, int>(
      builder: (context, indexState) {
        final lastIndex = widget.items.length - 1;
        final allItemsExceptSettings = widget.items.sublist(0, widget.items.length - 1);
        final settingsSelected = indexState == lastIndex;

        return BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {},
          builder: (context, authState) {
            return GestureDetector(
              onHorizontalDragUpdate: _onHorizontalDragUpdate,
              onHorizontalDragEnd: _onHorizontalDragEnd,
              child: CollapsibleContainer(
                height: double.infinity,
                width: _currWidth,
                borderRadius: 3,
                color: Colors.white,
                sidebarBoxShadow: kBoxShadow,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedSwitcher(
                      duration: Duration(seconds: 1),
                      child: _isCollapsed
                          ? collapsedHeader(context, authState)
                          : _expandedHeader(context, authState),
                    ),
                    Expanded(
                      child: ListView(
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        shrinkWrap: true,
                        children: [
                          ...List.generate(allItemsExceptSettings.length, (index) {
                            final item = allItemsExceptSettings[index];
                            var sideBarItemColor = kGrey1Color;
                            if (index == indexState) {
                              sideBarItemColor = kPrimaryColor;
                            }
                            return CollapsibleItemWidget(
                              offsetX: _offsetX,
                              scale: _fraction,
                              leading: AppIcons.svgAsset(
                                item.icon,
                                color: sideBarItemColor,
                              ),
                              tooltip: item.text,
                              title: Text(
                                item.text,
                                softWrap: false,
                                overflow: TextOverflow.fade,
                                style: Theme.of(context).textTheme.headline2?.copyWith(
                                      color: sideBarItemColor,
                                    ),
                              ),
                              onTap: () {
                                context.read<IndexCubit>().assignPage(index);
                              },
                            );
                          }),
                          // Spacer(),
                          // Settings
                          CollapsibleItemWidget(
                            offsetX: _offsetX,
                            scale: _fraction,
                            leading: AppIcons.svgAsset(
                              widget.items.last.icon,
                              color: settingsSelected ? kPrimaryColor : kGrey1Color,
                            ),
                            tooltip: "Settings",
                            title: Text(
                              widget.items.last.text,
                              softWrap: false,
                              overflow: TextOverflow.fade,
                              style: Theme.of(context).textTheme.headline2?.copyWith(
                                    color: settingsSelected ? kPrimaryColor : kGrey1Color,
                                  ),
                            ),
                            onTap: () {
                              context.read<IndexCubit>().assignPage(lastIndex);
                            },
                          ),
                        ],
                      ),
                    ),
                    CollapsibleItemWidget(
                      offsetX: _offsetX,
                      scale: _fraction,
                      leading: AppIcons.svgAsset(
                        AppIcons.logout,
                        color: Colors.redAccent,
                      ),
                      tooltip: "Logout",
                      title: Text(
                        "Logout",
                        softWrap: false,
                        overflow: TextOverflow.fade,
                        style: Theme.of(context).textTheme.headline2?.copyWith(
                              color: Colors.redAccent,
                            ),
                      ),
                      onTap: () async {
                        await loginBloc.logout();
                        context.read<IndexCubit>().assignPage(0);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Column collapsedHeader(BuildContext context, AuthState authState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Text(
            "LnG",
            style: Theme.of(context).textTheme.headline3?.copyWith(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 24.sp,
                ),
          ),
        ),
        Card(
          elevation: 0,
          color: kSecondaryColor,
          margin: EdgeInsets.only(top: 16, bottom: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child: authState.identity?.photoUrl != null
              ? CircleAvatar(
                  backgroundImage: NetworkImage(authState.identity!.photoUrl!),
                )
              : CircleAvatar(),
        ),
      ],
    );
  }

  Padding _expandedHeader(BuildContext context, AuthState authState) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Load and Go",
              style: Theme.of(context).textTheme.headline3?.copyWith(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 24.sp,
                  )),
          Card(
            elevation: 0,
            color: kSecondaryColor,
            margin: EdgeInsets.only(top: 16, bottom: 8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            child: ExpansionTile(
              leading: authState.identity?.photoUrl != null
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(authState.identity!.photoUrl!),
                    )
                  : CircleAvatar(),
              title: Text(
                authState.identity?.fullname ?? "LnG user",
                style: Theme.of(context).textTheme.headline6,
              ),
              subtitle: authState.identity?.title != null
                  ? Text(
                      authState.identity!.title!,
                      style: Theme.of(context).textTheme.bodyText1,
                    )
                  : null,
              children: [SizedBox(height: 60)],
              tilePadding: EdgeInsets.only(left: 8, right: 8),
            ),
          ),
        ],
      ),
    );
  }

  double get _fraction => (_currWidth - widget.minWidth) / _delta;
  double get _currAngle => -math.pi * _fraction;
  double get _offsetX => _maxOffsetX * _fraction;

  void _animateTo(double endWidth) {
    _widthAnimation = Tween<double>(
      begin: _currWidth,
      end: endWidth,
    ).animate(_curvedAnimation);
    _controller.reset();
    _controller.forward();
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    if (details.primaryDelta != null) {
      _currWidth += details.primaryDelta!;
      if (_currWidth > tempWidth)
        _currWidth = tempWidth;
      else if (_currWidth < widget.minWidth)
        _currWidth = widget.minWidth;
      else
        setState(() {});
    }
  }

  void _onHorizontalDragEnd(DragEndDetails _) {
    if (_currWidth == tempWidth)
      setState(() => _isCollapsed = false);
    else if (_currWidth == widget.minWidth)
      setState(() => _isCollapsed = true);
    else {
      var threshold = _isCollapsed ? _delta1By4 : _delta3by4;
      var endWidth = _currWidth - widget.minWidth > threshold ? tempWidth : widget.minWidth;
      _animateTo(endWidth);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class CollapsibleContainer extends StatelessWidget {
  const CollapsibleContainer(
      {required this.height,
      required this.width,
      required this.borderRadius,
      required this.color,
      required this.child,
      required this.sidebarBoxShadow});

  final double height, width, borderRadius;
  final Color color;
  final Widget child;
  final List<BoxShadow> sidebarBoxShadow;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.only(
        top: 16,
        bottom: 16,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: color,
        boxShadow: sidebarBoxShadow,
      ),
      child: child,
    );
  }
}
