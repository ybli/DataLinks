import math
import numpy as np

def get_w(weightAHP,weightRF):
    sum=0.0
    for i in range(20):
        sum=sum+(weightAHP[i]-weightRF[i])*(weightAHP[i]-weightRF[i])
    sum=sum/8
    u=math.sqrt(sum)+0.5
    v=1-u
    print(u)
    print(v)
    for j in range(20):
        w=u*weightAHP[j]+v*weightRF[j]
        weight.append(w)
    print(weight)

    return weight

if __name__ == '__main__':
    AHP=[]
    RF=[]
    weight=[]
    file1 = open("D:\\data\\RF_AHP_data\\weightdataAHP.txt",'r')
    for line1 in file1:
        line1=line1.strip()
        AHP.append(float(line1))
    file1.close()
    file2 = open("D:\\data\\RF_AHP_data\\weightdataRF.txt",'r')
    for line2 in file2:
        line2=line2.strip()
        RF.append(float(line2))
    file2.close()
	
    weight=get_w(AHP,RF)
    input_file=open("D:\\data\\RF_AHP_data\\data.csv","r")
    output_file=open("D:\\data\\RF_AHP_data\\AHP_RF.csv","w")
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