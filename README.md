
##   自定义collocationViewLayout实现瀑布流 
   

#####  功能描述：

1. 满足UICollectionViewFlowLayout提供的普通的线性布局和网格布
2. 满足单区和多区的瀑布流布局
3. 满足多区瀑布流时每个区的列数可以不同
4. 满足设置header和footer
5. 满足设置header和footer的间距 

##### 使用方法

和UICollectionViewFlowLayout 使用方法一致,具体看 Demo

##### API

如下:
```

@protocol JWCCustomLayoutDelegate <NSObject>

@required 
// cell 高
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(JWCCustomLayout *)collectionViewLayout heightForRowAtIndexPath:(NSIndexPath *)indexPath itemWidth:(CGFloat)itemWidth ;

@optional
// headersize
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(JWCCustomLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;

// footer 的 size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(JWCCustomLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section;

// 每个区的边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(JWCCustomLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;

// 每个区多少列
- (NSInteger)collectionView:(UICollectionView *)collectionView layout:(JWCCustomLayout *)collectionViewLayout columnNumberAtSection:(NSInteger )section;


// 每个区多少中行距
- (NSInteger)collectionView:(UICollectionView *)collectionView layout:(JWCCustomLayout *)collectionViewLayout lineSpacingForSectionAtIndex:(NSInteger)section;

// 每个 item 之间的左右间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(JWCCustomLayout*)collectionViewLayout interitemSpacingForSectionAtIndex:(NSInteger)section;

// 本区区头和上个区区尾的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(JWCCustomLayout*)collectionViewLayout spacingWithLastSectionForSectionAtIndex:(NSInteger)section;  （注意：在collectionViewFolwLayout中是无法设置当前的区头和上个区尾的间距的，为了弥补这一缺憾，特此添加这个方法）
```



#### 效果图


![image](https://github.com/OlderChicken/CustomLayout/blob/master/pc1.png?raw=true)
效果图2 一个区 无header 无footer


![image](https://github.com/OlderChicken/CustomLayout/blob/master/pc2.png?raw=true)
效果图1 多区 有header有footer header和footer有间隔





![image](https://github.com/OlderChicken/CustomLayout/blob/master/pc3.png?raw=true)

效果图3 多区 有header有footer header和footer无间隔

#### 原理解释

看个人博客

[原理解释](http://www.wuchao.net.cn/2017/08/07/%E8%87%AA%E5%AE%9A%E4%B9%89collocationViewLayout%E5%AE%9E%E7%8E%B0%E7%80%91%E5%B8%83%E6%B5%81/)

***如果解决了您的问题,请给个 start 鼓励*** 