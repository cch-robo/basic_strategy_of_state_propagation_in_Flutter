import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:basic_of_state_propagation/src/base/custom_widgets.dart';


/// Text wrapper
/// Text > StatelessWidget > Widget
class MyText extends Text {

  final String name;
  final Holder<MyStatelessElement> elementHolder;

  MyText(String data, {
    String name = "MyText",
    Key key,
    TextStyle style,
    TextAlign textAlign,
    TextDirection textDirection,
    Locale locale,
    bool softWrap,
    TextOverflow overflow,
    double textScaleFactor,
    int maxLines,
    String semanticsLabel,
  }) :  this.name = name,
        this.elementHolder = Holder(),
        super(
          data,
          key: key,
          style: style,
          textAlign: textAlign,
          textDirection: textDirection,
          locale: locale,
          softWrap: softWrap,
          overflow: overflow,
          textScaleFactor: textScaleFactor,
          maxLines: maxLines,
          semanticsLabel: semanticsLabel,
        ) {
    debugPrint("$name#constructor  instance=${this.hashCode}");
  }

  MyText.rich(TextSpan textSpan, {
    String name = "MyText",
    Key key,
    TextStyle style,
    TextAlign textAlign,
    TextDirection textDirection,
    Locale locale,
    bool softWrap,
    TextOverflow overflow,
    double textScaleFactor,
    int maxLines,
    String semanticsLabel,
  }): this.name = name,
      this.elementHolder = Holder(),
      super.rich(
        textSpan,
        key: key,
        style: style,
        textAlign: textAlign,
        textDirection: textDirection,
        locale: locale,
        softWrap: softWrap,
        overflow: overflow,
        textScaleFactor: textScaleFactor,
        maxLines: maxLines,
        semanticsLabel: semanticsLabel,
      ) {
    debugPrint("$name.rich#constructor  instance=${this.hashCode}");
  }


  @override
  Widget build(BuildContext context) {
    debugPrint("$name#build(context:${context.hashCode})  instance=${this.hashCode}");
    return super.build(context);
  }

  @override
  StatelessElement createElement() {
    debugPrint("$name$createElement()  instance=${this.hashCode}");
    elementHolder.object = new MyStatelessElement(this, "$name:MyStatelessElement");
    return elementHolder.object;
  }
}


/// Scaffold wrapper
/// Scaffold > StatefulWidget > Widget
class MyScaffold extends Scaffold {

  final String name;
  final Holder<MyStatefulElement> elementHolder;

  MyScaffold({
      String name = "MyScaffold",
      Key key,
      PreferredSizeWidget appBar,
      Widget body,
      Widget floatingActionButton,
      FloatingActionButtonLocation floatingActionButtonLocation,
      FloatingActionButtonAnimator floatingActionButtonAnimator,
      List<Widget> persistentFooterButtons,
      Widget drawer,
      Widget endDrawer,
      Color backgroundColor,
      Widget bottomNavigationBar,
      Widget bottomSheet,
      bool resizeToAvoidBottomPadding = true,
      bool primary = true,
    }) : assert(primary != null),
         this.name = name,
         this.elementHolder = Holder(),
         super(
          key: key,
          appBar: appBar,
          body: body,
          floatingActionButton: floatingActionButton,
          floatingActionButtonLocation: floatingActionButtonLocation,
          floatingActionButtonAnimator: floatingActionButtonAnimator,
          persistentFooterButtons: persistentFooterButtons,
          drawer: drawer,
          endDrawer: endDrawer,
          bottomNavigationBar: bottomNavigationBar,
          bottomSheet: bottomSheet,
          backgroundColor: backgroundColor,
          resizeToAvoidBottomPadding: resizeToAvoidBottomPadding,
          primary: primary,
        ) {
    debugPrint("$name#constructor  instance=${this.hashCode}");
  }

  @override
  StatefulElement createElement() {
    debugPrint("$name#createElement()  instance=${this.hashCode}");
    elementHolder.object = MyStatefulElement(this, "$name:MyStatefulElement");
    return elementHolder.object;
  }

  @override
  MyScaffoldState createState() {
    debugPrint("$name$createState()  instance=${this.hashCode}");
    return new MyScaffoldState("$name:State");
  }
}
class MyScaffoldState extends ScaffoldState {
  final String name;

  MyScaffoldState(this.name) {
    debugPrint("$name#constructor()  instance=${this.hashCode}");
  }

  @override
  Widget build(BuildContext context){
    debugPrint("$name#build(context:${context.hashCode})  instance=${this.hashCode}, , widget=${widget.hashCode}:${widget.runtimeType.toString()}");
    return super.build(context);
  }
}


/// Column wrapper
/// Column > Flex > MultiChildRenderObjectWidget > RenderObjectWidget > Widget
class MyColumn extends Column {

  final String name;
  final Holder<MyMultiChildRenderObjectElement> elementHolder;
  final Holder<RenderObject> renderObjectHolder;

  MyColumn({
    String name = "MyColumn",
    Key key,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    TextDirection textDirection,
    VerticalDirection verticalDirection = VerticalDirection.down,
    TextBaseline textBaseline,
    List<Widget> children = const <Widget>[],
  }) : this.name = name,
       this.elementHolder = Holder(),
       this.renderObjectHolder = Holder(),
       super(
         key: key,
         mainAxisAlignment: mainAxisAlignment,
         mainAxisSize: mainAxisSize,
         crossAxisAlignment: crossAxisAlignment,
         textDirection: textDirection,
         verticalDirection: verticalDirection,
         textBaseline: textBaseline,
         children: children,
       ) {
    debugPrint("$name#constructor  instance=${this.hashCode}");
  }

  // There is no build() in MultiChildRenderObjectWidget > RenderObjectWidget

  @override
  MultiChildRenderObjectElement createElement() {
    debugPrint("$name#createElement()  instance=${this.hashCode}");
    elementHolder.object = MyMultiChildRenderObjectElement(this, "$name:MyMultiChildRenderObjectElement");
    return elementHolder.object;
  }

  @override
  RenderFlex createRenderObject(BuildContext context) {
    debugPrint("$name#createRenderObject(context:${context.hashCode})");
    renderObjectHolder.object = super.createRenderObject(context);
    return renderObjectHolder.object;
  }

  @override
  void updateRenderObject(BuildContext context, RenderObject renderObject) {
    debugPrint("$name#updateRenderObject(context:${context.hashCode}, renderObject:${renderObject.hashCode})");
    super.updateRenderObject(context, renderObject);
  }
}


/// Container wrapper
/// Container > StatelessWidget > Widget
class MyContainer extends Container {

  final String name;
  final Holder<MyStatelessElement> elementHolder;

  MyContainer({
    String name = "MyContainer",
    Key key,
    AlignmentGeometry alignment,
    EdgeInsetsGeometry padding,
    Color color,
    Decoration decoration,
    Decoration foregroundDecoration,
    double width,
    double height,
    BoxConstraints constraints,
    EdgeInsetsGeometry margin,
    Matrix4 transform,
    Widget child,
  }) : this.name = name,
       this.elementHolder = Holder(),
       super(
        key: key,
        alignment: alignment,
        padding: padding,
        color: color,
        decoration: decoration,
        foregroundDecoration: foregroundDecoration,
        width: width,
        height: height,
        constraints: constraints,
        margin: margin,
        transform: transform,
        child: child,
      ) {
    debugPrint("$name#constructor  instance=${this.hashCode}");
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("$name#build(context:${context.hashCode})  instance=${this.hashCode}");
    return super.build(context);
  }

  @override
  StatelessElement createElement() {
    debugPrint("$name#createElement()  instance=${this.hashCode}");
    elementHolder.object = new MyStatelessElement(this, "$name:MyStatelessElement");
    return elementHolder.object;
  }
}


/// FloatingActionButton wrapper
/// FloatingActionButton > StatefulWidget > Widget
class MyFloatingActionButton extends MyStatefulWidget {

  final String name;
  final Holder<MyStatefulElement> elementHolder;
  final FloatingActionButton floatingActionButton;

  MyFloatingActionButton({
    String name = "MyFloatingActionButton",
    Key key,
    Widget child,
    String tooltip,
    Color foregroundColor,
    Color backgroundColor,
    Object heroTag /*= const _DefaultHeroTag()*/,
    double elevation = 6.0,
    double highlightElevation = 12.0,
    @required VoidCallback onPressed,
    bool mini = false,
    ShapeBorder shape = const CircleBorder(),
    Clip clipBehavior = Clip.none,
    MaterialTapTargetSize materialTapTargetSize,
    bool isExtended = false,
  }) : this.name = name,
        this.elementHolder = Holder(),
        floatingActionButton = new FloatingActionButton(
          key: key,
          child: child,
          tooltip: tooltip,
          foregroundColor: foregroundColor,
          backgroundColor: backgroundColor,
          heroTag: heroTag,
          elevation: elevation,
          highlightElevation: highlightElevation,
          onPressed: onPressed,
          mini: mini,
          shape: shape,
          clipBehavior: clipBehavior,
          materialTapTargetSize: materialTapTargetSize,
          isExtended: isExtended,
        ),
        super(key: key, name: name);

  MyFloatingActionButton.extended({
    Key key,
    String name = "MyFloatingActionButton",
    String tooltip,
    Color foregroundColor,
    Color backgroundColor,
    Object heroTag /*= const _DefaultHeroTag()*/,
    double elevation = 6.0,
    double highlightElevation = 12.0,
    @required VoidCallback onPressed,
    ShapeBorder shape = const CircleBorder(),
    bool isExtended = false,
    MaterialTapTargetSize materialTapTargetSize,
    Clip clipBehavior = Clip.none,
    @required Widget icon,
    @required Widget label,
  }) :  this.name = name,
        this.elementHolder = Holder(),
        this.floatingActionButton = new FloatingActionButton.extended(
            key: key,
            tooltip: tooltip,
            foregroundColor: foregroundColor,
            backgroundColor: backgroundColor,
            heroTag: heroTag,
            elevation: elevation,
            highlightElevation: highlightElevation,
            onPressed: onPressed,
            shape: shape,
            isExtended: isExtended,
            materialTapTargetSize: materialTapTargetSize,
            clipBehavior: clipBehavior,
            icon: icon,
            label: label,
        ),
        super(key: key, name: name);

  @override
  StatefulElement createElement() {
    debugPrint("$name#createElement()  instance=${this.hashCode}");
    elementHolder.object = MyStatefulElement(this, "$name:MyStatefulElement");
    return elementHolder.object;
  }

  @override
  _MyFloatingActionButtonState createState() {
    debugPrint("$name$createState()  instance=${this.hashCode}");
    return new _MyFloatingActionButtonState("$name:State", floatingActionButton);
  }
}

/// FloatingActionButton State wrapper
class _MyFloatingActionButtonState extends State<MyFloatingActionButton> {
  final String name;
  final FloatingActionButton floatingActionButton;

  _MyFloatingActionButtonState(this.name, this.floatingActionButton) : super() {
    debugPrint("$name#construct  instance=${this.hashCode}");
  }

  // Copy of private _FloatingActionButtonState Implementation

  bool _highlight = false;
  void _handleHighlightChanged(bool value) {
    setState(() {
      _highlight = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("$name#build(context:${context.hashCode})  instance=${this.hashCode}, , widget:${widget.hashCode}:${widget.runtimeType.toString()}");

    // Private field of FloatingActionButton
    BoxConstraints _sizeConstraints = floatingActionButton.mini
        ? const BoxConstraints.tightFor(
          width: 40.0,
          height: 40.0,
        )
        : const BoxConstraints.tightFor(
          width: 56.0,
          height: 56.0,
        );

    // After that, copy of from _FloatingActionButtonState Implementation
    final ThemeData theme = Theme.of(context);
    final Color foregroundColor = floatingActionButton.foregroundColor ?? theme.accentIconTheme.color;
    Widget result;

    if (floatingActionButton.child != null) {
      result = IconTheme.merge(
        data: IconThemeData(
          color: foregroundColor,
        ),
        child: floatingActionButton.child,
      );
    }

    result = RawMaterialButton(
      onPressed: floatingActionButton.onPressed,
      onHighlightChanged: _handleHighlightChanged,
      elevation: _highlight ? floatingActionButton.highlightElevation : floatingActionButton.elevation,
      constraints: /*widget._sizeConstraints*/_sizeConstraints,
      materialTapTargetSize: floatingActionButton.materialTapTargetSize ?? theme.materialTapTargetSize,
      fillColor: floatingActionButton.backgroundColor ?? theme.accentColor,
      textStyle: theme.accentTextTheme.button.copyWith(
        color: foregroundColor,
        letterSpacing: 1.2,
      ),
      shape: floatingActionButton.shape,
      clipBehavior: floatingActionButton.clipBehavior,
      child: result,
    );

    if (floatingActionButton.tooltip != null) {
      result = MergeSemantics(
        child: Tooltip(
          message: floatingActionButton.tooltip,
          child: result,
        ),
      );
    }

    if (floatingActionButton.heroTag != null) {
      result = Hero(
        tag: floatingActionButton.heroTag,
        child: result,
      );
    }

    return result;
  }
}

/// Copy of private _DefaultHeroTag class at FloatingActionButton package
class _MyDefaultHeroTag {
  const _MyDefaultHeroTag();
  @override
  String toString() => '<default FloatingActionButton tag>';
}


/// RaisedButton wrapper
/// RaisedButton > MaterialButton > StatelessWidget
class MyRaisedButton extends RaisedButton {

  final String name;
  final Holder<MyStatelessElement> elementHolder;

  MyRaisedButton({
    String name = "MyRaisedButton",
    Key key,
    @required VoidCallback onPressed,
    ValueChanged<bool> onHighlightChanged,
    ButtonTextTheme textTheme,
    Color textColor,
    Color disabledTextColor,
    Color color,
    Color disabledColor,
    Color highlightColor,
    Color splashColor,
    Brightness colorBrightness,
    double elevation,
    double highlightElevation,
    double disabledElevation,
    EdgeInsetsGeometry padding,
    ShapeBorder shape,
    Clip clipBehavior = Clip.none,
    MaterialTapTargetSize materialTapTargetSize,
    Duration animationDuration,
    Widget child,
  }) :  this.name = name,
        this.elementHolder = Holder(),
        super(
          key: key,
          onPressed: onPressed,
          onHighlightChanged: onHighlightChanged,
          textTheme: textTheme,
          textColor: textColor,
          disabledTextColor: disabledTextColor,
          color: color,
          disabledColor: disabledColor,
          highlightColor: highlightColor,
          splashColor: splashColor,
          colorBrightness: colorBrightness,
          elevation: elevation,
          highlightElevation: highlightElevation,
          disabledElevation: disabledElevation,
          padding: padding,
          shape: shape,
          clipBehavior: clipBehavior,
          materialTapTargetSize: materialTapTargetSize,
          animationDuration: animationDuration,
          child: child) {
    debugPrint("$name#constructor  instance=${this.hashCode}");
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("$name#build(context:${context.hashCode})  instance=${this.hashCode}");
    return super.build(context);
  }

  @override
  StatelessElement createElement() {
    debugPrint("$name#createElement()  instance=${this.hashCode}");
    elementHolder.object = new MyStatelessElement(this, "$name:MyStatelessElement");
    return elementHolder.object;
  }
}


/// Builder wrapper
/// Builder > StatelessWidget
class MyBuilder extends Builder {
  final String name;
  final Holder<MyStatelessElement> elementHolder;

  MyBuilder({
    String name = "MyBuilder",
    Key key,
    @required WidgetBuilder builder,
  }) :  this.name = name,
        this.elementHolder = Holder(),
        super(key: key, builder: builder) {
    debugPrint("$name#constructor  instance=${this.hashCode}");
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("$name#build(context:${context.hashCode})  instance=${this.hashCode}(${this.runtimeType.toString()})");
    return super.build(context);
  }

  @override
  StatelessElement createElement() {
    debugPrint("$name#createElement()  instance=${this.hashCode}");
    elementHolder.object = new MyStatelessElement(this, "$name:MyStatelessElement");
    return elementHolder.object;
  }
}


/// InheritedWidget wrapper
/// InheritedWidget > ProxyWidget > Widget
abstract class MyInheritedWidget extends InheritedWidget {
  final String name;
  final Holder<MyInheritedElement> elementHolder;

  MyInheritedWidget({
    String name = "MyInheritedWidget",
    Key key,
    Widget child,
  }) :  this.name = name,
        this.elementHolder = Holder(),
        super(key: key, child: child) {
    debugPrint("$name#constructor  instance=${this.hashCode}");
  }

  // There is no build() in InheritedWidget

  @override
  InheritedElement createElement() {
    debugPrint("$name#createElement()  instance=${this.hashCode}");
    elementHolder.object = new MyInheritedElement(this, "$name:MyInheritedElement");
    return elementHolder.object;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    debugPrint("$name#updateShouldNotify(oldWidget:${oldWidget.hashCode}:${oldWidget.runtimeType.toString()})  instance=${this.hashCode}");
    return true;
  }
}


/// StatelessWidget wrapper
abstract class MyStatelessWidget extends StatelessWidget {
  final String name;
  final Holder<MyStatelessElement> elementHolder;

  MyStatelessWidget({ Key key, String name })
      : this.name = name,
        this.elementHolder = new Holder(),
        super(key: key) {
    debugPrint("$name#constructor  instance=${this.hashCode}");
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("$name#build(context:${context.hashCode})  instance=${this.hashCode}(${this.runtimeType.toString()})");
    return null;
  }

  @override
  StatelessElement createElement() {
    debugPrint("$name#createElement()  instance=${this.hashCode}");
    elementHolder.object = new MyStatelessElement(this, "$name:MyStatelessElement");
    return elementHolder.object;
  }
}


/// StatefulWidget wrapper
abstract class MyStatefulWidget extends StatefulWidget {
  final String name;
  final Holder<MyStatefulElement> elementHolder;
  final Holder<MyState<MyStatefulWidget>> stateHolder;

  MyStatefulWidget({ Key key, String name })
      : this.name = name,
        this.elementHolder = new Holder(),
        this.stateHolder = new Holder(),
        super(key: key) {
    debugPrint("$name#constructor  instance=${this.hashCode}");
  }

  @override
  StatefulElement createElement() {
    debugPrint("$name#createElement()  instance=${this.hashCode}:${this.runtimeType.toString()}");
    elementHolder.object = new MyStatefulElement(this, "$name:MyStatefulElement");
    return elementHolder.object;
  }

  /// Set the value of the inherited destination createState() to Holder
  MyState<MyStatefulWidget> createStateHolder(MyState<MyStatefulWidget> state) {
    stateHolder.object = state;
    return state;
  }
}


/// State wrapper
@optionalTypeArgs
abstract class MyState<T extends MyStatefulWidget> extends State<T> {
  final String name;

  MyState({String name}) : this.name = name {
    debugPrint("$name#constructor()  instance=${this.hashCode}");
  }

  @override
  void initState() {
    debugPrint("$name#initState()  instance=${this.hashCode}, widget=${widget.hashCode}:${widget.runtimeType.toString()}");
    super.initState();
  }

  @override
  void dispose() {
    debugPrint("$name#dispose()  instance=${this.hashCode}, widget=${widget.hashCode}:${widget.runtimeType.toString()}");
    super.dispose();
  }
}


/// InheritedElement wrapper
/// InheritedElement > ProxyElement > ComponentElement > Element
class MyInheritedElement extends InheritedElement {
  final String name;

  MyInheritedElement(InheritedWidget widget, this.name)
      : super(widget) {
    debugPrint("$name#constructor(widget:${widget.hashCode}:${widget.runtimeType.toString()})  instance=${this.hashCode}");
  }

  @override
  void rebuild() {
    debugPrint("$name#rebuild()  instance=${this.hashCode}, widget=${widget.hashCode}:${widget.runtimeType.toString()}");
    // rebuild() not only when Element is created or Element#update(newWiget)
    // it is also executed from BuildOwner#buildScope() of _owner field.
    super.rebuild();
  }

  @override
  Widget build() {
    debugPrint("$name#build()  instance=${this.hashCode}, widget=${widget.hashCode}:${widget.runtimeType.toString()}");
    // It only returns Widget of InheritedWidget's child property
    return super.build();
  }

  @override
  void update(InheritedWidget newWidget) {
    debugPrint("$name#update(newWidget:${newWidget.hashCode})  instance=${this.hashCode}, currentWidget=${widget.hashCode}:${widget.runtimeType.toString()}, dirty=${widget != newWidget}");
    super.update(newWidget);
  }

  @override
  void forgetChild(Element child) {
    debugPrint("$name#forgetChild(child:${child.hashCode})");
    super.forgetChild(child);
  }

  @override
  void mount(Element parent, dynamic newSlot) {
    debugPrint("$name#mount(parent:${parent.hashCode}:${parent.runtimeType.toString()})");
    super.mount(parent, newSlot);
  }

  @override
  void performRebuild() {
    debugPrint("$name#performRebuild()");
    super.performRebuild();
  }

  @override
  void deactivate() {
    debugPrint("$name#deactivate()");
    super.deactivate();
  }

  @override
  void unmount() {
    debugPrint("$name#unmount()");
    super.unmount();
  }

  @override
  void attachRenderObject(dynamic newSlot) {
    debugPrint("$name#attachRenderObject()");
    super.attachRenderObject(newSlot);
  }

  @override
  void detachRenderObject() {
    debugPrint("$name#detachRenderObject()");
    super.detachRenderObject();
  }

  void debugChildElements(){
    debugPrint("$name#debugChildElements()  instance=${this.hashCode}");
    // Reference source
    // Element#debugDescribeChildren():List<DiagnosticsNode> logic and RenderObject#renderObject logic
    ElementVisitor visitor(Element child) {
      if (child != null) {
        debugPrint("$name#visitChildElements  element=${child.runtimeType.toString()}(${child.hashCode}), "
            + "widget=${child.widget.runtimeType.toString()}, "
            + "depth=${child.depth}, "
            + "size=(${child.size.width},${child.size.height})");
        child.visitChildren(visitor);
      } else {
        debugPrint("$name#visitChildElements  element=null");
      }
    };
    this.visitChildElements(visitor);
  }
}


/// StatelessElement wrapper
class MyStatelessElement extends StatelessElement {
  final String name;

  MyStatelessElement(StatelessWidget widget, this.name)
      : super(widget) {
    debugPrint("$name#constructor(widget:${widget.hashCode}:${widget.runtimeType.toString()})  instance=${this.hashCode}");
  }

  @override
  void rebuild() {
    debugPrint("$name#rebuild()  instance=${this.hashCode}, widget=${widget.hashCode}:${widget.runtimeType.toString()}");
    // rebuild() not only when Element is created or Element#update(newWiget)
    // it is also executed from BuildOwner#buildScope() of _owner field.
    super.rebuild();
  }

  @override
  Widget build() {
    debugPrint("$name#build()  instance=${this.hashCode}, widget=${widget.hashCode}:${widget.runtimeType.toString()}");
    return super.build();
  }

  @override
  void update(StatelessWidget newWidget) {
    debugPrint("$name#update(newWidget:${newWidget.hashCode})  instance=${this.hashCode}, currentWidget=${widget.hashCode}:${widget.runtimeType.toString()}, dirty=${widget != newWidget}");
    super.update(newWidget);
  }

  @override
  void forgetChild(Element child) {
    debugPrint("$name#forgetChild(child:${child.hashCode})");
    super.forgetChild(child);
  }

  @override
  void mount(Element parent, dynamic newSlot) {
    debugPrint("$name#mount(parent:${parent.hashCode}:${parent.runtimeType.toString()})");
    super.mount(parent, newSlot);
  }

  @override
  void performRebuild() {
    debugPrint("$name#performRebuild()");
    super.performRebuild();
  }

  @override
  void deactivate() {
    debugPrint("$name#deactivate()");
    super.deactivate();
  }

  @override
  void unmount() {
    debugPrint("$name#unmount()");
    super.unmount();
  }

  @override
  void attachRenderObject(dynamic newSlot) {
    debugPrint("$name#attachRenderObject()");
    super.attachRenderObject(newSlot);
  }

  @override
  void detachRenderObject() {
    debugPrint("$name#detachRenderObject()");
    super.detachRenderObject();
  }

  void debugChildElements(){
    debugPrint("$name#debugChildElements()  instance=${this.hashCode}");
    // Reference source
    // Element#debugDescribeChildren():List<DiagnosticsNode> logic and RenderObject#renderObject logic
    ElementVisitor visitor(Element child) {
      if (child != null) {
        debugPrint("$name#visitChildElements  element=${child.runtimeType.toString()}(${child.hashCode}), "
            + "widget=${child.widget.runtimeType.toString()}, "
            + "depth=${child.depth}, "
            + "size=(${child.size.width},${child.size.height})");
        child.visitChildren(visitor);
      } else {
        debugPrint("$name#visitChildElements  element=null");
      }
    };
    this.visitChildElements(visitor);
  }
}


/// StatefulElement wrapper
class MyStatefulElement extends StatefulElement {
  final String name;

  MyStatefulElement(StatefulWidget widget, this.name)
      : super(widget) {
    debugPrint("$name#constructor(widget:${widget.hashCode}:${widget.runtimeType.toString()})  instance=${this.hashCode}");
  }

  @override
  void rebuild() {
    debugPrint("$name#rebuild()  instance=${this.hashCode}, widget=${widget.hashCode}:${widget.runtimeType.toString()}");
    // rebuild() not only when Element is created or Element#update(newWiget)
    // it is also executed from BuildOwner#buildScope() of _owner field.
    super.rebuild();
  }

  @override
  Widget build() {
    debugPrint("$name#build()  instance=${this.hashCode}, widget=${widget.hashCode}:${widget.runtimeType.toString()}");
    return super.build();
  }

  @override
  void update(StatefulWidget newWidget) {
    debugPrint("$name#update(newWidget:${newWidget.hashCode})  instance=${this.hashCode}, currentWidget=${widget.hashCode}:${widget.runtimeType.toString()}, dirty=${widget != newWidget}");
    super.update(newWidget);
  }

  @override
  void forgetChild(Element child) {
    debugPrint("$name#forgetChild(child:${child.hashCode})");
    super.forgetChild(child);
  }

  @override
  void mount(Element parent, dynamic newSlot) {
    debugPrint("$name#mount(parent:${parent.hashCode}:${parent.runtimeType.toString()})");
    super.mount(parent, newSlot);
  }

  @override
  void performRebuild() {
    debugPrint("$name#performRebuild()");
    super.performRebuild();
  }

  @override
  void deactivate() {
    debugPrint("$name#deactivate()");
    super.deactivate();
  }

  @override
  void unmount() {
    debugPrint("$name#unmount()");
    super.unmount();
  }

  @override
  void attachRenderObject(dynamic newSlot) {
    debugPrint("$name#attachRenderObject()");
    super.attachRenderObject(newSlot);
  }

  @override
  void detachRenderObject() {
    debugPrint("$name#detachRenderObject()");
    super.detachRenderObject();
  }

  void debugChildElements(){
    debugPrint("$name#debugChildElements()  instance=${this.hashCode}");
    // Reference source
    // Element#debugDescribeChildren():List<DiagnosticsNode> logic and RenderObject#renderObject logic
    ElementVisitor visitor(Element child) {
      if (child != null) {
        debugPrint("$name#visitChildElements  element=${child.runtimeType.toString()}(${child.hashCode}), "
            + "widget=${child.widget.runtimeType.toString()}, "
            + "depth=${child.depth}, "
            + "size=(${child.size.width},${child.size.height})");
        child.visitChildren(visitor);
      } else {
        debugPrint("$name#visitChildElements  element=null");
      }
    };
    this.visitChildElements(visitor);
  }
}


/// MultiChildRenderObjectElement wrapper
class MyMultiChildRenderObjectElement extends MultiChildRenderObjectElement {
  final String name;

  MyMultiChildRenderObjectElement(MultiChildRenderObjectWidget widget, this.name)
      : super(widget) {
    debugPrint("$name#constructor(widget:${widget.hashCode}:${widget.runtimeType.toString()})  instance=${this.hashCode}");
  }

  @override
  void rebuild() {
    debugPrint("$name#rebuild()  instance=${this.hashCode}, widget=${widget.hashCode}:${widget.runtimeType.toString()}");
    // rebuild() not only when Element is created or Element#update(newWiget)
    // it is also executed from BuildOwner#buildScope() of _owner field.
    super.rebuild();
  }

  // There is no build() in RenderObjectElement

  @override
  void update(MultiChildRenderObjectWidget newWidget) {
    debugPrint("$name#update(newWidget:${newWidget.hashCode})  instance=${this.hashCode}, currentWidget=${widget.hashCode}:${widget.runtimeType.toString()}, dirty=${widget != newWidget}");
    super.update(newWidget);
  }

  void debugChildElements() {
    debugPrint("$name#debugChildElements()  instance=${this.hashCode}");
    // Reference source
    // Element#debugDescribeChildren():List<DiagnosticsNode> logic and RenderObject#renderObject logic
    ElementVisitor visitor(Element child) {
      if (child != null) {
        debugPrint("$name#visitChildElements  element=${child.runtimeType.toString()}(${child.hashCode}), "
            + "widget=${child.widget.runtimeType.toString()}, "
            + "depth=${child.depth}, "
            + "size=(${child.size.width},${child.size.height})");
        child.visitChildren(visitor);
      } else {
        debugPrint("$name#visitChildElements  element=null");
      }
    };
    this.visitChildElements(visitor);
  }

  @override
  void forgetChild(Element child) {
    debugPrint("$name#forgetChild(child:${child.hashCode})");
    super.forgetChild(child);
  }

  @override
  void insertChildRenderObject(RenderObject child, slot) {
    debugPrint("$name#insertChildRenderObject(child:${child.hashCode}:${child.runtimeType.toString()})");
    super.insertChildRenderObject(child, slot);
  }

  @override
  void moveChildRenderObject(RenderObject child, slot) {
    debugPrint("$name#moveChildRenderObject(child:${child.hashCode}:${child.runtimeType.toString()})");
    super.moveChildRenderObject(child, slot);
  }

  @override
  void removeChildRenderObject(RenderObject child) {
    debugPrint("$name#removeChildRenderObject(child:${child.hashCode}:${child.runtimeType.toString()})");
    super.removeChildRenderObject(child);
  }


  @override
  void mount(Element parent, dynamic newSlot) {
    debugPrint("$name#mount(parent:${parent.hashCode}:${parent.runtimeType.toString()})");
    super.mount(parent, newSlot);
  }

  // After that, from RenderObjectElement> Element

  @override
  void performRebuild() {
    debugPrint("$name#performRebuild()");
    super.performRebuild();
  }

  @protected
  List<Element> updateChildren(List<Element> oldChildren, List<Widget> newWidgets, { Set<Element> forgottenChildren }) {
    debugPrint("$name#updateChildren(oldChildren, newWidgets, forgottenChildren)");
    if (oldChildren != null) {
      oldChildren.forEach((Element element){
        debugPrint("  oldChild:${element.hashCode}:${element.runtimeType.toString()}");
      });
    }
    if (newWidgets != null) {
      newWidgets.forEach((Widget widget){
        debugPrint("  newWidget:${widget.hashCode}:${widget.runtimeType.toString()}");
      });
    }
    if (forgottenChildren != null) {
      forgottenChildren.forEach((Element element){
        debugPrint("  forgottenChild:${element.hashCode}:${element.runtimeType.toString()}");
      });
    }
    return super.updateChildren(oldChildren, newWidgets, forgottenChildren: forgottenChildren);
  }

  @override
  void deactivate() {
    debugPrint("$name#deactivate()");
    super.deactivate();
  }

  @override
  void unmount() {
    debugPrint("$name#unmount()");
    super.unmount();
  }

  @override
  void attachRenderObject(dynamic newSlot) {
    debugPrint("$name#attachRenderObject()");
    super.attachRenderObject(newSlot);
  }

  @override
  void detachRenderObject() {
    debugPrint("$name#detachRenderObject()");
    super.detachRenderObject();
  }
}



/// builder で指定した 子ウイジェットを再描画可能にする Widget のラッパー
class MyRebuildableWidget extends RebuildableWidget {
  MyRebuildableWidget({
    Key key,
    @required StatefulWidgetBuilder builder
  }) : assert(builder != null),
        super(key: key, builder: builder);

  @override
  MyRebuildableWidgetState createState() {
    debugPrint("MyRebuildableWidget#createState()");
    return new MyRebuildableWidgetState();
  }
}

class MyRebuildableWidgetState extends RebuildableWidgetState {
  /// 再描画
  void rebuild(){
    debugPrint("MyRebuildableWidgetState#rebuild()");
    super.rebuild();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("MyRebuildableWidgetState#build(context:${context.hashCode})");
    return super.build(context);
  }
}


/// builder で指定した 子ウイジェットをキャッシュして不変(再描画させない)にする Widget のラッパー
class MyConstantWidget extends ConstantWidget {
  MyConstantWidget({
    Key key,
    @required StatefulWidgetBuilder builder
  }) : assert(builder != null),
        super(key: key, builder: builder);

  @override
  MyConstantWidgetState createState() {
    debugPrint("MyConstantWidget#createState()");
    return MyConstantWidgetState();
  }
}

class MyConstantWidgetState extends ConstantWidgetState {

  @override
  Widget build(BuildContext context) {
    debugPrint("MyConstantWidget#build(context:${context.hashCode})  ${cachedWidget == null ? 'build execute...' : 'build ignore...'}, cachedWidget=${cachedWidget == null ? 'null' : 'not null'}");
    return super.build(context);
  }
}


class Holder<T extends Object> {
  T object;
  Holder([T obj]) : this.object = obj;
}

class PairHolder<F extends Object, S extends Object> {
  F first;
  S second;

  PairHolder([F first, S second]) :
        this.first = first,
        this.second = second;
}
