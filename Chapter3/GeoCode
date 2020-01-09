from urllib.request import urlopen, quote
import json

# 地理编码
output = 'json'
ak = '7XQ17G7GYUIrz70leZXK5nhSzM1xbtx4'#需填入自己申请应用后生成的ak
url = 'http://api.map.baidu.com/geocoding/v3/?address='
address = "武汉大学测绘学院"
add = quote(address)  # 为防止乱码，先用quote进行编码
url2 = url + add + '&output=' + output + "&ak=" + ak
req = urlopen(url2)
res = req.read().decode()
temp = json.loads(res)
lng = temp['result']['location']['lng']  # 获取经度
lat = temp['result']['location']['lat']  # 获取纬度
list1 = [lng, lat]
print('百度坐标为：', list1)

# 逆地理编码解析
address = '30.538291990033617,114.36564149049224'
url = 'http://api.map.baidu.com/reverse_geocoding/v3/?ak=7XQ17G7GYUIrz70leZXK5nhSzM1xbtx4&output=json&location=' + str(address)
req = urlopen(url)
res = req.read().decode()
temp = json.loads(res)
answer=temp['result']['formatted_address']
print(answer)
