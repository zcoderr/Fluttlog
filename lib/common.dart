class Common {
  //私有构造函数
  Common._internal();

  //保存单例
  static Common _singleton = new Common._internal();

  //工厂构造函数
  factory Common()=> _singleton;

  int headerHeight;
}

//定义一个top-level（全局）变量，页面引入该文件后可以直接使用bus
var common = new Common();
