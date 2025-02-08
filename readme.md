# ShoppingWeb-DB方案說明 #

## 目錄 ##

1. 簡介
2. 還原專案
3. 從專案Migration至DB流程
4. 從DB還原至專案流程
5. 其他備註

## 簡介 ##

ShoppingWeb-DB方案包含兩個Visual Studio專案，
分別為DataBase.Migration(主控台應用程式)及Database(SQL Project)

DataBase.Migration功能為：紀錄資料庫的遷移紀錄

Database功能為：將資料庫內容還原

## 還原專案 ##

1. 複製ShoppingWeb-DB Repo `git clone https://github.com/Annie033088/ShoppingWeb-DB.git`
2. 進入Database 資料夾運行方案 (Database.sln)
3. 重建方案同時還原已安裝Nuget套件 (DbUp)

### 從Database專案建構SQL資料庫 ###

1. 打開Database專案, 右鍵Database專案, 點擊發行, 按照發行流程將SQL SERVER的Pashamao資料庫建立完畢

### 從專案Migration至DB流程 ###

1. 打開SQL Server的資料庫, 並在資料庫內執行DataBase.Migration底下的InitializeSchemaVersionsTable.sql檔案 [說明](#將資料插入schemaversions的表)
![Initialize Image](https://github.com/Annie033088/ShoppingWeb-DB/blob/Main/img/Initialize1.png)
2. 設定DataBase.Migration的Program.cs裡的資料庫連線字串
3. 將要更新的資料庫指令檔案(.sql檔案)存入DataBase.Migration的SQLScripts資料夾底下, 並執行DataBase.Migration專案
4. 右鍵點擊Database專案, 點擊結構描述比較, 更新Database專案的資料庫結構

### 從DB還原至專案流程 ###

...//TODO:添加流程及說明，建議同時添加圖片輔助解釋

## 其他備註 ##

### DbUp套件說明 ###

//TODO: 添加套件說明

### 將資料插入SchemaVersions的表 ###

- 目的：讓 DataBase.Migration 執行的時候，DbUp套件可以正確判斷哪些script(.sql檔案)已經被執行過了
- 原理：當使用DbUp來做資料庫更新的時候，資料庫內會產生SchemaVersions這張表，這張表會紀錄專案中的SQLScripts資料夾內的哪些script已經被執行過了，
        因此當需要更新資料庫結構時，必須先將SchemaVersions這張紀錄表還原，才能正確執行script(.sql檔案)
