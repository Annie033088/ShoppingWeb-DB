# ShoppingWeb-DB說明 #

## 簡介 ##

- 這個ShoppingWeb-DB方案的目的是載入本專案使用到的資料庫並紀錄資料庫遷移歷史
- 這個方案包括VS主控台應用程式專案及VS SQL Project專案。

## 目錄 ##

1. 簡介
2. 安裝
3. 使用方式

## 安裝 ##

1. 複製ShoppingWeb-DB`git clone https://github.com/Annie033088/ShoppingWeb-DB.git`
2. 進入Database資料夾並打開方案
3. 安裝Nuget套件:DbUp

## 使用方式 ##

- 載入資料庫到SQL Server：打開Database專案, 右鍵Database專案, 點擊發佈, 按照發布流程將SQL SERVER的Pashamao資料庫建立完畢
- 欲更新資料庫結構：
    1. 設定DataBase.Migration的Program.cs裡的資料庫連線字串
    2. 將要更新的資料庫指令檔案(.sql檔案)存入DataBase.Migration的SQLScripts資料夾底下, 並執行DataBase.Migration專案
    3. 右鍵點擊Database專案, 點擊結構描述比較, 更新Database專案的資料庫結構
