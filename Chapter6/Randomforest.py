import pandas as pd
import numpy as np
from sklearn.ensemble import RandomForestClassifier
from sklearn.externals import joblib
#参数调整
def adjust_para(x_train,y_train):
    nTreeList = range(50, 201, 1) #最大决策树个数
    maxfeatures=range(1,21,1)#最大特征数 
    maxdepth=range(1,101,1)#决策树最大深度 
    minsplit=range(2,153,20)#内部节点再划分所需样本数
    minleaf=range(1,62,10)#叶子节点最小样本数

    code = x_train.iloc[:, 0]
    code = code.reset_index(drop=True)	
    x_train1 = x_train.iloc[:, 1:]
    
    parameters=[]

    oob11 = []
    for iTrees in nTreeList:                 
        #accuracy=[]
        RFModel = RandomForestClassifier(n_estimators=iTrees, max_features='sqrt',oob_score=True,random_state=0)
        RFModel.fit(x_train1,y_train)
        y_pred = RFModel.predict(x_train1)
        y_test_pred = pd.DataFrame(y_pred, columns=['risk_pred'])
        y_train1 = y_train.reset_index(drop=True)#将本值重排序
        result_test = pd.concat([code, y_test_pred,y_train1], axis=1)
        result_test1 = result_test.rename(columns={'risk':'risk_true'})
        oob11.append(RFModel.oob_score_)
        #accuracy.append(result_test1.risk_pred.corr(result_test1.risk_true))
        oob1=pd.DataFrame(oob11,columns=["oob"])
        oob1.to_csv(r'D:\\data\\RF\\oob_n_eatimators.csv', index=False, sep=',',encoding = 'gbk')
    parameters.append(oob11.index(max(oob11))+50)

    oob22=[]
    for iFeatures in maxfeatures:
        RFModel = RandomForestClassifier(n_estimators=parameters[0], max_features=iFeatures,oob_score=True,random_state=0)
        RFModel.fit(x_train1,y_train)
        y_pred = RFModel.predict(x_train1)
        y_test_pred = pd.DataFrame(y_pred, columns=['risk_pred'])
        y_train1 = y_train.reset_index(drop=True)#将本值重排序
        result_test = pd.concat([code, y_test_pred,y_train1], axis=1)
        result_test1 = result_test.rename(columns={'risk':'risk_true'})
        oob22.append(RFModel.oob_score_)
        #accuracy.append(result_test1.risk_pred.corr(result_test1.risk_true))
        oob2=pd.DataFrame(oob22,columns=["oob"])
        oob2.to_csv(r'D:\\data\\RF\\oob_maxfeatures.csv', index=False, sep=',',encoding = 'gbk')
    parameters.append(oob22.index(max(oob22))+1)

    oob33=[]
    for imaxdepth in maxdepth:
        RFModel = RandomForestClassifier(n_estimators=parameters[0], max_features=parameters[1],max_depth=imaxdepth,oob_score=True,random_state=0)
        RFModel.fit(x_train1,y_train)
        y_pred = RFModel.predict(x_train1)
        y_test_pred = pd.DataFrame(y_pred, columns=['risk_pred'])
        y_train1 = y_train.reset_index(drop=True)#将本值重排序
        result_test = pd.concat([code, y_test_pred,y_train1], axis=1)
        result_test1 = result_test.rename(columns={'risk':'risk_true'})
        oob33.append(RFModel.oob_score_)
        #accuracy.append(result_test1.risk_pred.corr(result_test1.risk_true))
        oob3=pd.DataFrame(oob33,columns=["oob"])
        oob3.to_csv(r'D:\\data\\RF\\oob_max_depth.csv', index=False, sep=',',encoding = 'gbk')
    parameters.append(oob33.index(max(oob33))+1)

    oob44=[]
    for iminsplit in minsplit:
        for iminleaf in minleaf:
            RFModel = RandomForestClassifier(n_estimators=parameters[0], max_features=parameters[1],max_depth=parameters[2],min_samples_split=iminsplit,min_samples_leaf=iminleaf,oob_score=True,random_state=0)
            RFModel.fit(x_train1,y_train)
            y_pred = RFModel.predict(x_train1)
            y_test_pred = pd.DataFrame(y_pred, columns=['risk_pred'])
            y_train1 = y_train.reset_index(drop=True)#将本值重排序
            result_test = pd.concat([code, y_test_pred,y_train1], axis=1)
            result_test1 = result_test.rename(columns={'risk':'risk_true'})
            oob44.append(RFModel.oob_score_)
            #accuracy.append(result_test1.risk_pred.corr(result_test1.risk_true))
            oob4=pd.DataFrame(oob44,columns=["oob"])
            oob4.to_csv(r'D:\\data\\RF\\oob_min_split_leaf.csv', index=False, sep=',',encoding = 'gbk')
    parameters.append((int(oob44.index(max(oob44))/7))*20+2)
    parameters.append((int(oob44.index(max(oob44))%7))*10+1)
    print(parameters)       
    return parameters

def rt(x_train, y_train,x_test,y_test,x_testall,y_testall,parameters):
    
	code = x_train.iloc[:, 0]
	code = code.reset_index(drop=True)
	
	x_train1 = x_train.iloc[:, 1:]
    
    #利用调好的参数测试样本
	rf1 = RandomForestClassifier(n_estimators=parameters[0], max_features=parameters[1],max_depth=parameters[2],min_samples_split=parameters[3],min_samples_leaf=parameters[4],oob_score=True,random_state=0)#待调
	
	rf1.fit(x_train1, y_train)

	y1 = rf1.predict(x_train1)
	y_train_pred = pd.DataFrame(y1, columns=['risk_pred'])
	y_train1 = y_train.reset_index(drop=True)#将本值重排序

	result_train = pd.concat([code, y_train_pred,y_train1], axis=1)
	result_train1 = result_train.rename(columns={'risk':'risk_true'})
	result_train1.to_csv(u"D:\\data\\RF\\sample_risk.csv", index=False, sep=',',encoding = 'gbk')
	
	importances = rf1.feature_importances_#特征权重
	print(importances)
    
	file1=open(r'D:\\data\\RF\\weightdataRF.txt','w')
	for i in rf1.feature_importances_:
		file1.write(str(i))
		file1.write('\n')
	file1.close()
	
	oob=rf1.oob_score_#OOB错误率
	print(oob)
	
	r1 = result_train1.risk_pred.corr(result_train1.risk_true)#正确率
	print (r1)
	
	A=pd.crosstab(result_train1.risk_true,result_train1.risk_pred,rownames=['true'],colnames=['pred'])
	print(A)

	code2 = x_test.iloc[:, 0]
	code2 = code2.reset_index(drop=True)	
	x_test1 = x_test.iloc[:, 1:]
	y2 = rf1.predict(x_test1)
	#print(y2)
	y_test_pred = pd.DataFrame(y2, columns=['risk_pred2'])
	y_test1 = y_test.reset_index(drop=True)#将本值重排序


	result_test = pd.concat([code2, y_test_pred,y_test1], axis=1)
	result_test1 = result_test.rename(columns={'risk':'risk_true2'})
	result_test1.to_csv(u"D:\\data\\RF\\test_risk.csv", index=False, sep=',',encoding = 'gbk')


	r2 = result_test1.risk_pred2.corr(result_test1.risk_true2)#正确率
	print (r2)
	
	B=pd.crosstab(result_test1.risk_true2,result_test1.risk_pred2,rownames=['true2'],colnames=['pred2'])
	print(B)
	
	code3 = x_testall.iloc[:, 0]
	code3 = code3.reset_index(drop=True)	
	x_testall1 = x_testall.iloc[:, 1:]
	y3 = rf1.predict(x_testall1)
    
	y_testall_pred = pd.DataFrame(y3, columns=['risk_pred3'])
	y_testall1 = y_testall.reset_index(drop=True)#将本值重排序


	result_testall = pd.concat([code3, y_testall_pred,y_testall1], axis=1)
	result_testall1 = result_testall.rename(columns={'risk':'risk_true3'})
	result_testall1.to_csv(u"D:\\data\\RF\\all_risk.csv", index=False, sep=',',encoding = 'gbk')

	r3 = result_testall1.risk_pred3.corr(result_testall1.risk_true3)#正确率
	print (r3)
	
	C=pd.crosstab(result_testall1.risk_true3,result_testall1.risk_pred3,rownames=['true3'],colnames=['pred3'])
	print(C)
	
	return rf1
    
if __name__ == '__main__':
    #训练集
    filepath =  u"D:\\data\\RF_data\\sample.csv"
    data = pd.read_csv(filepath, header=0, sep=',',na_values='NULL')
    data2=data
    X=data2.iloc[:,0:-1]
    Y=data2.iloc[:,-1]
    #测试集
    filepath2 =  u"D:\\data\\RF_data\\test.csv"
    testdata = pd.read_csv(filepath2, header=0, sep=',',na_values='NULL')
    testdata2=testdata
    X2=testdata2.iloc[:,0:-1]
    Y2=testdata2.iloc[:,-1]
    #全部样本
    filepath3 =  u"D:\\data\\RF_data\\all.csv"
    testalldata = pd.read_csv(filepath3, header=0, sep=',',na_values='NULL')
    testalldata2=testalldata
    XALL=testalldata2.iloc[:,0:-1]
    YALL=testalldata2.iloc[:,-1]
    
    parameters=adjust_para(X,Y)
    risk1=rt(X,Y,X2,Y2,XALL,YALL,parameters)

