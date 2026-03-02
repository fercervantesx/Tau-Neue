import 'package:flutter/widgets.dart';
import '../foundations/theme/tau_theme.dart';

/// TAU NEUE accordion component with tactical terminal aesthetic.
///
/// Collapsible section groups with smooth expand/collapse animation.
/// Supports single or multi-expand modes.
///
/// Example:
/// ```dart
/// TauAccordion(
///   items: [
///     TauAccordionItem(
///       header: 'SECTION 1',
///       body: Text('Content 1'),
///     ),
///     TauAccordionItem(
///       header: 'SECTION 2',
///       body: Text('Content 2'),
///     ),
///   ],
/// )
/// ```
class TauAccordion extends StatefulWidget {
  const TauAccordion({
    super.key,
    required this.items,
    this.allowMultiple = false,
    this.initialExpandedIndices = const [],
  });

  /// List of accordion items.
  final List<TauAccordionItem> items;

  /// Whether multiple items can be expanded at once.
  final bool allowMultiple;

  /// Initially expanded item indices.
  final List<int> initialExpandedIndices;

  @override
  State<TauAccordion> createState() => _TauAccordionState();
}

class _TauAccordionState extends State<TauAccordion> {
  late Set<int> _expandedIndices;

  @override
  void initState() {
    super.initState();
    _expandedIndices = Set.from(widget.initialExpandedIndices);
  }

  void _toggleItem(int index) {
    setState(() {
      if (_expandedIndices.contains(index)) {
        _expandedIndices.remove(index);
      } else {
        if (!widget.allowMultiple) {
          _expandedIndices.clear();
        }
        _expandedIndices.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = TauTheme.colorsOf(context);
    final spacing = TauTheme.spacingOf(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: List.generate(
        widget.items.length,
        (index) {
          final item = widget.items[index];
          final isExpanded = _expandedIndices.contains(index);
          final isLast = index == widget.items.length - 1;

          return _TauAccordionItemWidget(
            item: item,
            isExpanded: isExpanded,
            isLast: isLast,
            onToggle: () => _toggleItem(index),
            colors: colors,
            spacing: spacing,
          );
        },
      ),
    );
  }
}

/// Configuration for a single accordion item.
class TauAccordionItem {
  const TauAccordionItem({
    required this.header,
    required this.body,
  });

  /// Header text or widget.
  final dynamic header;

  /// Body content widget.
  final Widget body;
}

/// Internal accordion item widget.
class _TauAccordionItemWidget extends StatefulWidget {
  const _TauAccordionItemWidget({
    required this.item,
    required this.isExpanded,
    required this.isLast,
    required this.onToggle,
    required this.colors,
    required this.spacing,
  });

  final TauAccordionItem item;
  final bool isExpanded;
  final bool isLast;
  final VoidCallback onToggle;
  final dynamic colors;
  final dynamic spacing;

  @override
  State<_TauAccordionItemWidget> createState() => _TauAccordionItemWidgetState();
}

class _TauAccordionItemWidgetState extends State<_TauAccordionItemWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _expandAnimation;
  late Animation<double> _iconRotation;
  bool _hovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _expandAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutExpo,
    );

    _iconRotation = Tween<double>(
      begin: 0.0,
      end: 0.5,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutExpo,
    ));

    if (widget.isExpanded) {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(_TauAccordionItemWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isExpanded != oldWidget.isExpanded) {
      if (widget.isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final typography = TauTheme.typographyOf(context);

    final headerWidget = widget.item.header is String
        ? Text(
            widget.item.header as String,
            style: typography.labelMono.copyWith(
              color: widget.colors.textOnDark,
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.8,
            ),
          )
        : widget.item.header as Widget;

    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: widget.isLast
              ? BorderSide.none
              : BorderSide(
                  color: widget.colors.borderSubtle,
                  width: 1.0,
                ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          MouseRegion(
            onEnter: (_) => setState(() => _hovered = true),
            onExit: (_) => setState(() => _hovered = false),
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: widget.onToggle,
              child: Container(
                padding: EdgeInsets.all(widget.spacing.spacingBase * 2),
                color: _hovered
                    ? widget.colors.surfaceElevated
                    : widget.colors.surfaceBase,
                child: Row(
                  children: [
                    Expanded(child: headerWidget),
                    SizedBox(width: widget.spacing.spacingBase),
                    RotationTransition(
                      turns: _iconRotation,
                      child: Icon(
                        const IconData(0xe5cf, fontFamily: 'MaterialIcons'), // expand_more
                        color: widget.colors.textMuted,
                        size: 20.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Body
          SizeTransition(
            sizeFactor: _expandAnimation,
            child: Container(
              padding: EdgeInsets.all(widget.spacing.spacingBase * 2),
              color: widget.colors.surfaceElevated,
              child: widget.item.body,
            ),
          ),
        ],
      ),
    );
  }
}
