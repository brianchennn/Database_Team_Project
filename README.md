# Database_Team_Project
彭文志第二組的都給我進來
よ！よ！ドンダよ！

#### 大檔案傳輸方法:
https://git-lfs.github.com/

```
$ git lfs install
$ git lfs track "*.csv"
$ git add .gitattributes
$ git add file.psd
$ git commit -m "Add design file"
$ git push origin master
```
#### git push 不上去的做法:
有可能是其他貢獻者commit上去了 你的本地版本落後github 的版本

1.先pull下來再push
```
$ git pull origin master --rebase
```

2.強制蓋掉其他使用者的commit(不建議這麼做)
```
$git pull origin master -f
```

