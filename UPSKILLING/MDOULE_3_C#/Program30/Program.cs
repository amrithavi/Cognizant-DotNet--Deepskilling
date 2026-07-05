using System;
using System.Data.SqlClient;
using System.Data;

class Program
{
    static void Main()
    {
        string connectionString = "Server=localhost;Database=CompanyDB;Trusted_Connection=True;";

        using (SqlConnection con = new SqlConnection(connectionString))
        {
            con.Open();

            string insertQuery = "insert into Employees(Name, Salary) values('arun', 50000)";
            SqlCommand insertCmd = new SqlCommand(insertQuery, con);
            insertCmd.ExecuteNonQuery();
            Console.WriteLine("employee inserted");

            string selectQuery = "select * from Employees";
            SqlCommand selectCmd = new SqlCommand(selectQuery, con);

            SqlDataReader reader = selectCmd.ExecuteReader();

            Console.WriteLine("employee records:");

            while (reader.Read())
            {
                Console.WriteLine(reader["Id"] + " " +
                                  reader["Name"] + " " +
                                  reader["Salary"]);
            }

            reader.Close();

            string updateQuery = "update Employees set Salary = 60000 where Name = 'arun'";
            SqlCommand updateCmd = new SqlCommand(updateQuery, con);
            updateCmd.ExecuteNonQuery();
            Console.WriteLine("employee updated");

            string deleteQuery = "delete from Employees where Name = 'arun'";
            SqlCommand deleteCmd = new SqlCommand(deleteQuery, con);
            deleteCmd.ExecuteNonQuery();
            Console.WriteLine("employee deleted");

            SqlDataAdapter adapter = new SqlDataAdapter("select * from Employees", con);
            DataTable table = new DataTable();

            adapter.Fill(table);

            Console.WriteLine("rows in datatable: " + table.Rows.Count);
        }
    }
}