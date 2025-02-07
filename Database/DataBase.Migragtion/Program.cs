using DbUp;
using DbUp.Engine;
using Microsoft.Data.SqlClient;

class Program
{
    static void Main(string[] args)
    {
        //資料庫連接字串
        string connectionString = @"Data Source=LAPTOP-43CNJ97A\SQLEXPRESS;Integrated Security=True;Initial Catalog=TTT;Persist Security Info=True;MultipleActiveResultSets=True;TrustServerCertificate=True";
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

                //將資料庫當中, DbUp的歷史紀錄表(SchemaVersions)備份, 更新對應InitializeSchemaVersionsTable.sql檔案
                using (var connection = new SqlConnection(connectionString))
                {
                    string filePath = @"..\..\..\InitializeSchemaVersionsTable.sql";
                    connection.Open();
                    string query = "SELECT ScriptName, Applied FROM SchemaVersions";

                    var command = new SqlCommand(query, connection);
                    using (var reader = command.ExecuteReader())
                    {
                        using (StreamWriter writer = new StreamWriter(filePath))
                        {
                            writer.WriteLine("-- DbUp SchemaVersions Backup");
                            writer.WriteLine("-- Generated on: " + DateTime.Now);
                            writer.WriteLine("");

                            while (reader.Read())
                            {
                                string scriptName = reader.GetString(0);
                                DateTime applied = reader.GetDateTime(1);
                                string appliedStr = applied.ToString("yyyy-MM-dd HH:mm:ss");

                                string insertStatement = $"INSERT INTO SchemaVersions (ScriptName, Applied) VALUES ('{scriptName}', '{appliedStr}');";
                                writer.WriteLine(insertStatement);
                            }
                        }
                    }

                    connection.Close();
                    Console.WriteLine($"SQL 檔案已生成：{filePath}");
                }
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