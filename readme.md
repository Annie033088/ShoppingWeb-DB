# ShoppingWeb-DB說明 #

## 簡介 ##

- 這個ShoppingWeb-DB方案的目的是載入本專案使用到的資料庫並紀錄資料庫遷移歷史
- 這個方案包括VS主控台應用程式專案及VS SQL Project專案。

## 目錄 ##

1. 簡介
2. 安裝
3. 使用方式
4. 備註

## 安裝 ##

1. 複製ShoppingWeb-DB`git clone https://github.com/Annie033088/ShoppingWeb-DB.git`
2. 進入Database資料夾並打開方案
3. 安裝Nuget套件:DbUp

## 使用方式 ##

- 載入資料庫到SQL Server：
    1. 打開Database專案, 右鍵Database專案, 點擊發佈, 按照發布流程將SQL SERVER的Pashamao資料庫建立完畢
- 欲更新資料庫結構：
    1. 打開SQL Server的Pashamao資料庫, 並執行DataBase.Migragtion底下的InitializeSchemaVersionsTable.sql檔案 [說明](#將資料插入schemaversions的表)
    2. 設定DataBase.Migration的Program.cs裡的資料庫連線字串
    3. 將要更新的資料庫指令檔案(.sql檔案)存入DataBase.Migration的SQLScripts資料夾底下, 並執行DataBase.Migration專案
    4. 右鍵點擊Database專案, 點擊結構描述比較, 更新Database專案的資料庫結構

## 備註 ##

### 將資料插入SchemaVersions的表 ###

- 目的：讓 DataBase.Migration 執行的時候, DbUp套件可以正確判斷哪些script(.sql檔案)已經被執行過了
- 原理：當使用DbUp來做資料庫更新的時候, 資料庫內會產生SchemaVersions這張表, 這張表會紀錄 專案中的SQLScripts資料夾內的哪些script已經被執行過了
        因此當需要更新資料庫結構時, 必須先將SchemaVersions這張紀錄表還原, 才能正確執行script(.sql檔案)