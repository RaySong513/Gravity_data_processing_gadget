# Gravity_data_processing_gadget

Some small tool scripts written for field data processing of gravity measurements

**！！！使用该库内python程序请确保本地python安装正确！！！**

## gravity_line_interpolation.m
该程序自动读取读取data.xlsx文件当中所有sheet数据，第一列为点号或坐标位置用于X轴，第二列数据为布格重力异常值。
该程序主要对散点数据进行插值处理，最后生成与sheet数量相对应的插值后的折线趋势图。

## gravity_line_smoothing.m
该程序自动读取读取data.xlsx文件当中所有sheet数据，第一列为点号或坐标位置用于X轴，第二列数据为布格重力异常值。
该程序主要对数据进行平滑处理，对于每个sheet，生成三张图件，分别为插值后折线图、平滑后折线图、将两者合并在一起的对比图

## potential_field_separation.m
该程序自动读取读取data.xlsx文件当中所有sheet数据，第一列为点号或坐标位置用于X轴，第二列数据为布格重力异常值。
该程序主要对数据进行平滑处理，对于每个sheet，生成三张图件，分别为插值后折线图、平滑后折线图、将两者合并在一起的对比图

## Central_terrain_correction_calc.py
该程序自动读取读取data.xlsx文件当中所有sheet数据，第一列为点号或坐标位置用于X轴，第二列数据为布格重力异常值。
该程序主要对数据进行位场分离，对于每个sheet，生成三张图件，分别为平滑后折线图、区域场图件、局部场图件

- Python版本：3.11
- 使用到的库：pandas、openxrl、msvcrt、numpy

该程序自动测算中心点与改正范围内的所有点平均值之差，根据角度扇形区域输出该区域内差值，以便后续查阅<扇形域重力地形改正表>

### 使用说明：

1. data.xlsx内格式设置如下：
   - 第一行设置为：“备注”、“号数”、“  ”、“  ”、“X坐标”、“Y坐标”、“高程值”  共七列
   - 第二行为中心点数据
   - 其余行为测区内其余点数据
   
2. 将数据表格重命名为“data.xlsx”文件并与该程序置于同一路径下

3. 双击运行Central__terrain_correction_calc.py

4. 输出如下：

``` 
重力点数据: 备注           XXXX（点名）
号数               X（点号）
X坐标    XXXX.XX
Y坐标    XXXX.XX
高程值       XXXX.XX
Name: X, dtype: XXXXXX
范围 20-50m, 角度区间 0-45度: 平均高程差为 XXX 米
范围 20-50m, 角度区间 45-90度: 平均高程差为 XXX 米
…………
范围 500-700m, 角度区间 315.0-337.5度: 平均高程差为 XXX 米
范围 500-700m, 角度区间 337.5-360.0度: 平均高程差为 XXX 米
```

