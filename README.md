# Database_Team_Project
彭文志第二組的都給我進來
よ！よ！ドンダよ！

#### *大檔案傳輸方法*
去 [lfs官網](https://git-lfs.github.com/)下載(mac/linux是這樣 windows我不知道 (求補充))
```
$ git lfs install
$ git lfs track "*.csv"
$ git add .gitattributes 
$ git add file.psd
$ git commit -m "Add design file"
$ git push origin master
```
#### *git push 不上去的解決方法*
有可能是其他貢獻者commit上去了 你的本地版本落後github 的版本

1.先pull下來再push
```
$ git pull origin master --rebase
```

2.強制蓋掉其他使用者的commit(不建議這麼做)
```
$git pull origin master -f
```
###HW1作業專區
![image](https://github.com/brianchennn/Database_Team_Project/blob/master/1~10%E4%BD%9C%E6%A5%AD%E7%AD%94%E6%A1%88%E7%B8%BD%E6%88%AA%E5%9C%96.png?raw=true)

