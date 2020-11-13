// sumsong 公司IP
// const serviceUrl = 'http://10.1.48.185:7300/mock/5f9631d65ffdfd2150c09fa6/base';
// SUMSONG 家IP
// const serviceUrl = 'http://192.168.1.6:7300/mock/5e78639618b2441ed0979211/base';
// SUMSONG公司台式IP
// const serviceUrl = 'http://10.1.22.187:7300/mock/5eb657de1ac6f950a4586dfd/base';
// MAC PRO公司IP
const serviceUrl = 'http://10.1.48.119:7300/mock/5fade10ec190ef028ac10812/base';
const servicePath = {
  'homePageContent': serviceUrl + '/homePageContent', // 首页信息
  'homePageRecommend': serviceUrl + '/homePageRecommend', // 首页推荐信息
  'categoryPage': serviceUrl + '/categoryContentPage', // 分类页面信息
  'categoryNavList': serviceUrl + '/categoryNavList', // 分类页面导航
  'categoryMainList': serviceUrl + '/categoryMainList', // 分类页面右侧主体内容
  'categoryNavTop': serviceUrl + '/category/detail/topBar', // 分类页面顶部过滤导航
  'categoryDetailMain':
      serviceUrl + '/category/detail/getSumarys', // 分类页面某一类的详情列表
  'categoryNavTopMore':
      serviceUrl + '/category/detail/topBar/filter/more', // 分类页面顶部过滤导航右侧抽屉中更多分类
  'cateGoodsCommentDetail':
      serviceUrl + '/category/detail/goodsDetail', // 分类中每一类中某个商品的详情评价
  'goodsAccessory':
      serviceUrl + '/goods/info/accessory', // 分类中每一类中手机商品的配件
  'currentGoodsSearch': serviceUrl + '/goods/info/currentSearch', // 显示当前搜索数据
  'goodsSearch': serviceUrl + '/goods/info/search', // 商品详情推荐的搜索
  'goodsRecommend': serviceUrl + '/goods/info/likeRecommand', // 商品详情推荐的你喜欢的
  'goodsRange': serviceUrl + '/goods/info/range', // 商品详情推荐中的排行榜
  'goodsHint': serviceUrl + '/goods/info/hintSearch', // 商品联想搜索
};
