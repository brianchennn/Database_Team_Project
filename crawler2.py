import requests
import re
from bs4 import BeautifulSoup
from pyquery import PyQuery as pq
urls=[]
'''with open('urls','r') as f:
   for line in f:
       res = requests.get(line)
       soup = BeautifulSoup(res.text,'lxml')
       #print(soup)
       t = soup.find_all("div",{"id":"all_pitching_standard"})
       print(t)
print('r')
'''
url = "https://www.baseball-reference.com/players/o/ohtansh01.shtml"
res = requests.get(url)
soup = BeautifulSoup(res.text,'lxml')
t = soup.find(id="all_pitching_standard")
print(t)
trs = t.find_all("tr")
print(trs)
'''
res = requests.get(url)
text = res.text
doc = pq(text)
    # 獲得每一行的tr標籤
tds = doc('table.table tbody tr.alt').items()

for td in tds:
    print("d")
    id = td.find('td:data-stat').text()     # 排名
    print(id)'''