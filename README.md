# Database_Team_Project
彭文志第二組的都給我進來
よ！よ！ドンダよ！

#### *大檔案傳輸方法*
去 [lfs官網](https://git-lfs.github.com/)下載(mac/linux是這樣 windows我不知道 (求補充))
```
 git lfs install
 git lfs track "*.csv"
 git add .gitattributes 
 git add file.psd
 git commit -m "Add design file"
 git push origin master
```
補：windows 直接去官網載就好 (2020.5.28)

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
