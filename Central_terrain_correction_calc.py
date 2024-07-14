import msvcrt
import pandas as pd
import numpy as np

data = pd.read_excel('data.xlsx')

columns_of_interest = ['备注', '号数', 'X坐标', 'Y坐标', '高程值']
data = data[columns_of_interest]

# 获取重力点数据（第二行）
gravity_point = data.iloc[0]
print("重力点数据:", gravity_point)

def calculate_elevation_differences_by_segments(data, center_x, center_y, center_elevation, min_radius, max_radius, step_angle):
    # 计算每个点与中心点的距离和角度
    data['distance'] = np.sqrt((data['X坐标'] - center_x) ** 2 + (data['Y坐标'] - center_y) ** 2)
    data['angle'] = np.degrees(np.arctan2(data['Y坐标'] - center_y, data['X坐标'] - center_x)) % 360

    results = []
    for angle in np.arange(0, 360, step_angle):
        min_angle = angle
        max_angle = angle + step_angle
        # 筛选在指定半径和角度范围内的点
        arc_points = data[(data['distance'] >= min_radius) & (data['distance'] <= max_radius)]
        arc_points = arc_points[(arc_points['angle'] >= min_angle) & (arc_points['angle'] < max_angle)]

        # 计算平均高程
        if not arc_points.empty:
            average_elevation = arc_points['高程值'].mean()
            elevation_difference = center_elevation - average_elevation
            results.append((f"{min_angle}-{max_angle}度", elevation_difference))
        else:
            results.append((f"{min_angle}-{max_angle}度", "没有数据点"))

    return results

# 设置重力点为中心点
center_x = gravity_point['X坐标']
center_y = gravity_point['Y坐标']
center_elevation = gravity_point['高程值']

# 定义改正范围和旋转步长
ranges_and_steps = [(20, 50, 45), (50, 100, 45), (100, 200, 45),
                    (200, 300, 22.5), (300, 500, 22.5), (500, 700, 22.5)]

# 计算每个范围的高程差并输出
for min_radius, max_radius, step_angle in ranges_and_steps:
    results = calculate_elevation_differences_by_segments(data, center_x, center_y, center_elevation, min_radius, max_radius, step_angle)
    for result in results:
        if isinstance(result[1], str):
            print(f"范围 {min_radius}-{max_radius}m, 角度区间 {result[0]}: {result[1]}")
        else:
            print(f"范围 {min_radius}-{max_radius}m, 角度区间 {result[0]}: 平均高程差为 {result[1]:.2f} 米")

# 等待按下 ESC 键
print("按下 ESC 键退出程序。")
while True:
    if msvcrt.kbhit():
        if msvcrt.getch() == b'\x1b':
            break
