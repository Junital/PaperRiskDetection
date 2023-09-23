import matplotlib.pyplot as plt

# 数据
categories = ['A', 'B', 'C', 'D', 'E']
values = [15, 10, 7, 12, 8]

# 配置字体
plt.rcParams['font.family'] = 'SimHei'

# 设置颜色
# colors = ['#1f77b4', '#ff7f0e', '#2ca02c', '#d62728', '#9467bd']

# 创建柱状图
plt.bar(categories, values, color='#beccba')

# 设置图表标题和标签
plt.title('柱状图示例')
plt.xlabel('类别')
plt.ylabel('值')

# 显示图表
plt.show()
