using DbUp;
using DbUp.Engine;

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
}