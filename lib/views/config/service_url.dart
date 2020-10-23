// const serviceUrl = 'http://10.1.48.181:7300/mock/5e78639618b2441ed0979211/base';
// const serviceUrl = 'http://192.168.1.6:7300/mock/5e78639618b2441ed0979211/base';
const serviceUrl = 'http://10.1.22.187:7300/mock/5eb657de1ac6f950a4586dfd/base';
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
      serviceUrl + '/goods/info/accessory',
};
