#!/usr/bin/env python
# -*- coding: utf-8 -*-
import numpy as np

RI_dict = {1: 0, 2: 0, 3: 0.58, 4: 0.90, 5: 1.12, 6: 1.24, 7: 1.32, 8: 1.41, 9: 1.45}
#特征向量法求权重
def get_w(array):
    row = array.shape[0]  # 计算出阶数
    a_axis_0_sum = array.sum(axis=0)#列
    b = array / a_axis_0_sum  # 新的矩阵b
    b_axis_0_sum = b.sum(axis=0)#列
    b_axis_1_sum = b.sum(axis=1)  # 每一行的特征向量
    w = b_axis_1_sum / row  # 归一化处理(特征向量)
    nw = w * row
    AW = (w * array).sum(axis=1)
    max_max = sum(AW / (row * w))
    CI = (max_max - row) / (row - 1)
    CR = CI / RI_dict[row]
    if CR < 0.1:
        print(round(max_max, 6))
        print(round(CI, 6))
        print(round(CR, 6))
        print('特征向量:%s' % w)
		#将特征向量写入txt
        file = open("D:\\data\\AHP_data\\weightdata.txt",'a')
        for i in w:
            file.write(str(i))
            file.write(" ")
        file.write("\n")
        file.close()
        return w
    else:
        print(round(CR, 3))
        print('不满足一致性，请进行修改')

def main(array):
    if type(array) is np.ndarray:
        return get_w(array)
    else:
        print('请输入numpy对象')


if __name__ == '__main__':
    #判断矩阵
    e = np.array([[1, 1, 1], 
				  [1, 1, 1], 
				  [1, 1,1]])
    b = np.array([[1, 1,1/2, 1/3,1/3,1/5,1/7,1/9,1/9],[1, 1,1/2, 1/3,1/3,1/5,1/7,1/9,1/9], [2,2,1,1/2,1/2,1/4,1/6,1/8,1/8],[3,3,2,1,1,1/3,1/5,1/7,1/7],[3,3,2,1,1,1/3,1/5,1/7,1/7],[5,5,4,3,3,1,1/3,1/5,1/5],[7,7,6,5,5,3,1,1/3,1/3],[9,9,8,7,7,5,3,1,1],[9,9,8,7,7,5,3,1,1]])
    c = np.array([[1,1/3,1/5,1/5,1/7,1/7,1/9], [3,1,1/3,1/3,1/5,1/5,1/7], [5,3,1,1,1/3,1/3,1/5],[5,3,1,1,1/3,1/3,1/5],[7,5,3,3,1,1,1/3],[7,5,3,3,1,1,1/3],[9,7,5,5,3,3,1]])
    d = np.array([[1,1,1/3,1/5], [1,1,1/3,1/5], [3,3,1,1/3],[5,5,3,1]])
    e = main(e)
    b = main(b)
    c = main(c)
    d = main(d)
    b1=e[0]*b
    c1=e[1]*c
    d1=e[2]*d
    weight=np.hstack((b1,c1))
    weight=np.hstack((weight,d1))
    file3 = open("D:\\data\\AHP_data\\weightdata.txt",'a')
    for i in weight:
            file3.write(str(i))
            file3.write("\n")
    file3.close()
    #计算社区风险
    input_file=open("D:\\data\\AHP_data\\AHP_data.csv","r")
    output_file=open("D:\\data\\AHP_data\\AHP_output.csv","w")
    name=input_file.readline()
    name=name.rstrip()+","+'risk'+'\n'
    output_file.write(name)
    for line in input_file:
        data=line.split(',')[0:]
        datanum=[]
        for i in data:
            j=float(i)
            datanum.append(j)
        datanum=np.array(datanum)
        risk=datanum*weight
        risk=risk.sum()
        new_line=line.rstrip()+","+str(risk)+'\n'
        output_file.write(new_line)
    input_file.close()
    output_file.close()
	
