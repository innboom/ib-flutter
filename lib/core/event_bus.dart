class EventBus {
  // 私有构造函数
  EventBus._internal();

  static EventBus? _instance;

  // 获取唯一实例
  static EventBus get instance => _getInstance();

  static EventBus _getInstance() {
    return _instance ??= EventBus._internal();
  }

  // 存储事件回调方法
  final Map<String, List<Function>> _events = {};

  // 设置事件监听
  void addListener<T>(String eventKey, Function(T) callback) {
    // 如果事件的回调列表不存在，则初始化为空列表
    if (!_events.containsKey(eventKey)) {
      _events[eventKey] = [];
    }

    // 防止重复添加相同的回调
    if (!_events[eventKey]!.contains(callback)) {
      _events[eventKey]!.add(callback);
    }
  }

  // 移除监听
  void removeListener(String eventKey, Function callback) {
    if (_events.containsKey(eventKey)) {
      _events[eventKey]!.remove(callback);
    }
  }

  // 提交事件，并传递数据
  void commit<T>(String eventKey, T data) {
    // 调用每个事件的回调，并传递数据
    if (_events.containsKey(eventKey)) {
      for (var callback in _events[eventKey]!) {
        callback(data);
      }
    }
  }

  // 清空所有事件监听
  void clear() {
    _events.clear();
  }
}

class EventKeys {
  static const String logout = "Logout";
}
