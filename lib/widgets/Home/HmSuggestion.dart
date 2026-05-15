import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HmSuggestion extends StatefulWidget {
  //优惠推荐数据列表
  SpecialRecommendResult SpecialRecommendList;
  HmSuggestion({Key? key, required this.SpecialRecommendList})
    : super(key: key);

  @override
  _HmSuggestionState createState() => _HmSuggestionState();
}

class _HmSuggestionState extends State<HmSuggestion> {
  // 取网络请求数据的前三条
  List<GoodsItem> _getDisplayItem() {
    // 对网络请求比ui构建慢的ui显示错误bug修复
    if (widget.SpecialRecommendList.subTypes.isEmpty)
      return []; // 为空则返回空列表，直至不为空
    // take()方法是指取前几条的意思
    return widget.SpecialRecommendList.subTypes.first.goodsItems.items
        .take(3)
        .toList();
    //  这里是通过列表取首值再取列表的首值，调出items的
  }

  // 顶部内容封装
  Widget _buildHeader() {
    return Row(
      children: [
        Text(
          "特惠推荐",
          style: TextStyle(
            color: const Color.fromARGB(255, 94, 7, 1),
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(width: 10),
        Text(
          "精选省攻略",
          style: TextStyle(
            color: const Color.fromARGB(255, 97, 27, 22),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  // 左侧内容封装
  Widget _buildLeft() {
    return Container(
      height: 140,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage("lib/assets/home_cmd_inner.png"),
          fit: BoxFit.cover, // 设置为全覆盖
        ),
      ),
    );
  }

  // 右侧内容封装
  List<Widget> _getChildrenList() {
    List<GoodsItem> list = _getDisplayItem(); // 取到三条数据
    return List.generate(list.length, (int index) {
      // 对每个数据图片构建并设置样式
      return Column(
        // 这里设置Column的原因是上图片下文字
        children: [
          // 新组件ClipRRect，包裹子组件，可以裁剪图片，设置圆角
          ClipRRect(
            borderRadius: BorderRadius.circular(8), // 和container的格式一样
            child: Image.network(
              // errorBuilder用于当网络图片出现404时，用一个新部件替换原有部件
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  "lib/assets/home_cmd_inner.png",
                  width: 100,
                  height: 140,
                  fit: BoxFit.cover,
                ); // 返回本地图片保证不会出现显示失败
              },
              list[index].picture,
              fit: BoxFit.cover,
              width: 100,
              height: 140,
            ),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 237, 100, 90),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text("￥${list[index].price}"),
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        height: 250,
        alignment: Alignment.center,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(12), // 设置圆角
          image: DecorationImage(
            image: AssetImage("lib/assets/home_cmd_sm.png"),
            fit: BoxFit.cover, // 设置全覆盖
          ),
        ),
        child: Column(
          children: [
            // 顶部内容
            _buildHeader(),
            SizedBox(height: 10),
            Row(
              children: [
                _buildLeft(),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 主轴对齐均分
                    children: _getChildrenList(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
