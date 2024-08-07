part of 'accordion.dart';

typedef RxAccordionHeaderBuilder = Widget Function(
  BuildContext context,
  AccordionHeaderSpec headerSpec,
);

class RxBlankAccordion extends StatefulWidget {
  const RxBlankAccordion({
    super.key,
    required this.header,
    required this.content,
    this.initiallyExpanded = false,
    required this.style,
  });

  final RxAccordionHeaderBuilder header;
  final Widget content;
  final Style style;
  final bool initiallyExpanded;

  @override
  State<RxBlankAccordion> createState() => _RxBlankAccordionState();
}

class _RxBlankAccordionState extends State<RxBlankAccordion>
    with TickerProviderStateMixin {
  bool _isExpanded = false;
  AnimationController? _animationController;
  CurvedAnimation? _curvedAnimation;
  MixWidgetStateController? _stateController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Durations.short4,
      vsync: this,
    );
    _curvedAnimation = CurvedAnimation(
      parent: _animationController!,
      curve: Curves.decelerate,
    );

    _isExpanded = widget.initiallyExpanded;
    _stateController = MixWidgetStateController()..selected = _isExpanded;
    _animationController!.value = _isExpanded ? 1 : 0;
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      print('_state Updated: ${_stateController!.value}');
      _stateController!.selected = _isExpanded;

      if (_isExpanded) {
        _animationController!.forward();
      } else {
        _animationController!.reverse();
      }
      // PageStorage.maybeOf(context)?.writeState(context, _isExpanded);
    });

    // widget.onExpansionChanged?.call(_isExpanded ? widget.identityValue : null);
  }

  @override
  void dispose() {
    _animationController!.dispose();
    _curvedAnimation!.dispose();
    _stateController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: SpecBuilder(
        style: widget.style,
        // autoHandleWidgetStates: false,
        builder: (context) {
          final spec = AccordionSpec.of(context);

          final ContainerWidget = spec.container;
          final HeaderContainerWidget = spec.headerContainer;
          final ContentContainerWidget = spec.contentContainer;
          final FlexWidget = spec.flex;

          final content = ContentContainerWidget(child: widget.content);

          return ContainerWidget(
            child: FlexWidget(
              direction: Axis.vertical,
              children: [
                Pressable(
                  onPress: _handleTap,
                  controller: _stateController,
                  child: widget.header(context, spec.headerContainer),
                ),
                AnimatedBuilder(
                  animation: _animationController!.view,
                  builder: (context, child) {
                    return ClipRect(
                      child: Align(
                        alignment: Alignment.topCenter,
                        heightFactor: _curvedAnimation!.value,
                        child: child,
                      ),
                    );
                  },
                  child: content,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}