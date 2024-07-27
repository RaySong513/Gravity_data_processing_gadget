# 重力数据处理工具

一些用于重力测量野外数据处理的小工具脚本。

![License](https://img.shields.io/badge/license-MIT-green)

**注意：使用本仓库内的 Python 程序前，请确保本地已正确安装 Python。**

---

## 📊 脚本功能表

| 脚本名                    | 功能描述                                       |
|---------------------------|------------------------------------------------|
| [gravity_line_interpolation.m](#gravity_line_interpolationm) | 对散点数据进行插值处理并生成趋势图             |
| [gravity_line_smoothing.m](#gravity_line_smoothingm)     | 对数据进行平滑处理并生成比较图                 |
| [potential_field_separation.m](#potential_field_separationm) | 生成平滑后折线图、区域场图和局部场图           |
| [horizontal_derivative.m](#horizontal_derivativem)      | 进行水平导数处理并生成水平导数图               |
| [inversion.m](#inversionm)                  | 迭代反演地下异常体，适用于简单数据反演         |
| [linear_inversion.m](#linear_inversionm)           | 使用特征值法反演地下异常体，生成轮廓线图       |
| [Terrain_Inversion.m](#terrain_inversionm)          | 生成三张图，展示平滑后曲线、轮廓线和地形剖面图 |
| [Central_terrain_correction_calc.py](#中央地形改正计算central_terrain_correction_calcpy) | 测算中心点与改正范围内所有点的平均值之差    |

---

## 📜 脚本概述

### 🔍 gravity_line_interpolation.m
该程序自动读取 `data.xlsx` 文件中的所有 sheet 数据。第一列为点号或坐标位置（用于 X 轴），第二列为布格重力异常值。程序对散点数据进行插值处理，最后生成与 sheet 数量对应的插值后趋势图。

### 🌊 gravity_line_smoothing.m
该程序自动读取 `data.xlsx` 文件中的所有 sheet 数据。第一列为点号或坐标位置（用于 X 轴），第二列为布格重力异常值。程序对数据进行平滑处理，每个 sheet 生成三张图件：
1. 插值后折线图
2. 平滑后折线图
3. 合并图（插值和平滑对比）

### 🔀 potential_field_separation.m
该程序自动读取 `data.xlsx` 文件中的所有 sheet 数据。第一列为点号或坐标位置（用于 X 轴），第二列为布格重力异常值。程序对数据进行平滑处理，每个 sheet 生成三张图件：
1. 平滑后折线图
2. 区域场图
3. 局部场图

### ➡️ horizontal_derivative.m
该程序自动读取 `data.xlsx` 文件中的所有 sheet 数据。第一列为点号或坐标位置（用于 X 轴），第二列为布格重力异常值。程序对数据进行水平导数处理，每个 sheet 生成两张图件：
1. 平滑后折线图
2. 水平导数图

### 🌍 重力异常反演地下异常体
这些反演程序利用布格重力异常值反演地下异常体位置和轮廓。只读取 `data.xlsx` 文件中的第一个 sheet 数据，第一列为点号或坐标位置（用于 X 轴），第二列为布格重力异常值。

#### 🌀 inversion.m
该程序通过迭代反演地下异常体，适用于简单重力数据反演，时间较长。

#### 🔧 linear_inversion.m
该程序利用特征值法反演地下异常体。在同一窗口内生成两张图：
1. 平滑后折线图
2. 密度分界面深度反演结果轮廓线

#### 🌄 Terrain_Inversion.m
该程序通过迭代反演地下异常体。在同一窗口内生成三张图：
1. 平滑后折线图（上方）
2. 密度分界面深度反演结果轮廓线（中间）
3. 实地地形剖面图（下方）

### 📏 中心地形改正计算（Central_terrain_correction_calc.py）
该程序自动读取 `data.xlsx` 文件中的所有 sheet 数据。第一列为点号或坐标位置（用于 X 轴），第二列为布格重力异常值。程序测算中心点与改正范围内所有点的平均值之差，并根据角度扇形区域输出该区域内差值，以便后续查阅 <扇形域重力地形改正表>。

![Python Version](https://img.shields.io/badge/python-3.11-blue)
![Libraries Used](https://img.shields.io/badge/libraries-pandas%2C%20openpyxl%2C%20msvcrt%2C%20numpy-blue)

## 🛠️ 使用说明

1. `data.xlsx` 文件格式如下：
   - 第一行为：“备注”、“号数”、“（空）”、“（空）”、“X 坐标”、“Y 坐标”、“高程值”，共七列
   - 第二行为中心点数据
   - 其余行为测区内其他点数据
   
2. 将数据表重命名为 `data.xlsx`，并与脚本置于同一路径下。

3. 双击运行 `Central_terrain_correction_calc.py`。

4. 输出如下：

```plaintext
重力点数据: 备注           XXXX（点名）
号数               X（点号）
X坐标    XXXX.XX
Y坐标    XXXX.XX
高程值       XXXX.XX
Name: X, dtype: XXXXXX
范围 20-50m, 角度区间 0-45度: 平均高程差为 XXX 米
范围 20-50m, 角度区间 45-90度: 平均高程差为 XXX 米
...
范围 500-700m, 角度区间 315.0-337.5度: 平均高程差为 XXX 米
范围 500-700m, 角度区间 337.5-360.0度: 平均高程差为 XXX 米
