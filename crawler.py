import requests
import re
from bs4 import BeautifulSoup
url ="https://www.baseball-reference.com/players/"


#print(soup.prettify())
#player_url=[]
'''f = open("urls",'a')
for i in range(0,26):
    print(i)
    url2 = url + chr(i+97) +'/'
    res = requests.get(url2)
    soup = BeautifulSoup(res.text,'lxml')
    block = soup.find(id="all_players_")
    g = block.find_all('a')
    for str1 in g:
        #print(str1.get('href'))
        str2=url[0:-9]+str1.get('href')+'\n'
        f.write(str2)
        #player_url.append(url[0:-9]+str1.get('href')) 
f.close 
'''
f=open("urls",'r')
#urls=f.readline
while(1):
    U=f.readline()
    print(U)
    res = requests.get(U)
    soup = BeautifulSoup(res.text,'lxml')
    
    if(U[0]=='\n'):
        break
    
    #print(block)
    

