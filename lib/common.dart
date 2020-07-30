class Common {
  //私有构造函数
  Common._internal();

  //保存单例
  static Common _singleton = new Common._internal();

  //工厂构造函数
  factory Common()=> _singleton;

  int headerHeight;
}

var common = new Common();
