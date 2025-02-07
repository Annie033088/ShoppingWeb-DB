using Microsoft.SqlServer.Dac;
using DbUp;
using System;
using System.IO;
using System.Linq;
using DbUp.Engine;
using System.Diagnostics;

class Program
{
    static void Main(string[] args)
    {
        //資料庫連接字串
        string connectionString = @"Data Source=LAPTOP-43CNJ97A\SQLEXPRESS;Integrated Security=True;Initial Catalog=Test;Persist Security Info=True;MultipleActiveResultSets=True;TrustServerCertificate=True";
        // 這是儲存 SQL 檔案的資料夾
        string scriptsFolder = @"..\..\..\SQLScripts"; 

        try
        {
            // 初始化 DbUp
            UpgradeEngine upgrader = DeployChanges.To
                .SqlDatabase(connectionString)
                .WithScriptsFromFileSystem(scriptsFolder)
                .LogToConsole()
                .Build();

            // 執行資料庫遷移
            DatabaseUpgradeResult result = upgrader.PerformUpgrade();

            if (result.Successful)
            {
                Console.WriteLine("資料庫更新成功!");
                GenerateDacpac();
                SynchronousDacpac();
            }
            else
            {
                Console.WriteLine("資料庫更新失敗!");
                Console.WriteLine(result.Error);
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine("dbup運行失敗" + ex.Message);
            throw;
        }
    }

    /// <summary>
    /// 導出dacpac檔案
    /// </summary>
    private static void GenerateDacpac()
    {
        string command = "sqlpackage";
        string arguments = @"/Action:Export /ssn:LAPTOP-43CNJ97A\SQLEXPRESS /sdn:Test /tf:..\..\..\..\Database.dacpac";

        try
        {
            // 設定 ProcessStartInfo 用來執行外部命令
            var processStartInfo = new ProcessStartInfo
            {
                FileName = command, 
                Arguments = arguments,
                RedirectStandardOutput = true, 
                UseShellExecute = false,
                CreateNoWindow = true
            };

            // 啟動外部命令
            using (var process = Process.Start(processStartInfo))
            {
                if (process != null)
                {
                    // 讀取命令執行的結果
                    string output = process.StandardOutput.ReadToEnd();
                    Console.WriteLine("導出資料庫的dacpac檔案成功" + output);
                    process.WaitForExit();
                }
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine("導出資料庫的dacpac檔案失敗" + ex.Message);
        }
    }

    /// <summary>
    /// 將dacpac檔案同步到 sql project
    /// </summary>
    private static void SynchronousDacpac()
    {
        string command = "sqlpackage";
        string arguments = @"sqlpackage /Action:Publish /SourceFile:Database.dacpac /TargetFile:..\..\..\Database\Database.sqlproj";

        try
        {
            var processStartInfo = new ProcessStartInfo
            {
                FileName = command,
                Arguments = arguments,
                RedirectStandardOutput = true,
                UseShellExecute = false,
                CreateNoWindow = true
            };

            using (var process = Process.Start(processStartInfo))
            {
                if (process != null)
                {
                    string output = process.StandardOutput.ReadToEnd();
                    Console.WriteLine("同步資料庫的dacpac檔案到sql project成功" + output);
                    process.WaitForExit();
                }
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine("同步資料庫的dacpac檔案到sql project失敗 " + ex.Message);
        }
    }
}