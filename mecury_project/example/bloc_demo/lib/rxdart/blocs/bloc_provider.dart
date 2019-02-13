import 'package:flutter/material.dart';
import 'package:bloc_demo/rxdart/blocs/count_bloc.dart';

abstract class BlocBase {
  void dispose();
}

class BlocProvider<T extends BlocBase> extends StatefulWidget {
  BlocProvider({
    Key key,
    @required this.child,
    @required this.bloc,
  }) : super(key: key);

  final T bloc;
  final Widget child;

  @override
  _BlocProviderState<T> createState() => _BlocProviderState<T>();

  static T of<T extends BlocBase>(BuildContext context){
    final type = _typeOf<BlocProvider<T>>();
    BlocProvider<T> provider = context.ancestorWidgetOfExactType(type);
    return provider.bloc;
  }

  static Type _typeOf<T>() => T;
}

class _BlocProviderState<T> extends State<BlocProvider<BlocBase>> {
  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

//为何不用 InheritedWidget 来全局管理 BloC 的状态
//我为此也整理了一个将 BLoC 结合 InheritedWidget 使用的示例：bloc_inherited（在 Vscode 打开这段代码是 [close_sinks] 的警告的）
//在很多与 BLoC 相关的文章中，您将看到 Provider 的实现其实是一个 InheritedWidget。
//当然，  这是完全可以实现的，然而，
//
//一个 InheritedWidget 没有提供任何 dispose 方法，记住，在不再需要资源时总是释放资源是一个很好的做法。
//当然，你也可以将 InheritedWidget 包装在另一个 StatefulWidget 中，但是，乍样使用 InheritedWidget 并没有什么便利之处！
//最后，如果不受控制，使用 InheritedWidget 经常会导致一些副作用（请参阅下面的  InheritedWidget 上的提醒）。
//
//这 3 点解释了我为何将通用 BlocProvider 实现为 StatefulWidget，这样我就可以释放资源。
