# Gravity_data_processing_gadget

Some small tool scripts written for field data processing of gravity measurements

**！！！使用该库内程序请确保本地python安装正确！！！**

## Central_terrain_correction_calc.py

- Python版本：3.11
- 使用到的库：pandas、numpy、time、openxrl

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


Gravity_data_processing_gadget
=============================

Some small tool scripts written for field data processing of gravity measurements

**!!! Please make sure that your local Python is installed correctly before using the program in this library! ! !**

## Central__terrain_correction_calc.py

- **Python version:** 3.11
- **Libraries used:** pandas, numpy, time, openxrl

The program automatically calculates the difference between the center point and the average value of all points in the correction range, and outputs the difference in the area according to the angle sector area, so as to refer to the <sector domain gravity terrain correction table> later.

### Instructions:

1. The format settings in `data.xlsx` are as follows:
   - The first row is set as: "Remarks", "Number", "", "", "X coordinate", "Y coordinate", "Elevation value" for a total of seven columns
   - The second row is the center point data
   - The remaining rows are the data of the remaining points in the survey area
2. Rename the data table to "data.xlsx" file and place it in the same path as the program
3. Double-click to run `Central__terrain_correction_calc.py`
4. The output is as follows:

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

