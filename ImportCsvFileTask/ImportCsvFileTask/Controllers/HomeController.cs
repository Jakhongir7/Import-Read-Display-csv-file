using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.IO;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;

namespace ImportCsvFileTask.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            employee_databaseEntities entities = new employee_databaseEntities();
            return View(from employee in entities.Employees.Take(10) select employee);
        }
        [Route("Home/UpdateEmployee")]
        [HttpPost]
        public ActionResult UpdateEmployee(Employees _employee)
        {
            using (employee_databaseEntities entities = new employee_databaseEntities())
            {
                Employees updatedEmployee = (from e in entities.Employees
                                             where e.Payroll_Number == _employee.Payroll_Number
                                             select e).FirstOrDefault();
                updatedEmployee.Start_Date = _employee.Start_Date;
                updatedEmployee.EMail_Home = _employee.EMail_Home;
                updatedEmployee.Postcode = _employee.Postcode;
                updatedEmployee.Address_2 = _employee.Address_2;
                updatedEmployee.Address = _employee.Address;
                updatedEmployee.Mobile = _employee.Mobile;
                updatedEmployee.Telephone = _employee.Telephone;
                updatedEmployee.Date_of_Birth = _employee.Date_of_Birth;
                updatedEmployee.Surname = _employee.Surname;
                updatedEmployee.Forename = _employee.Forename;
                entities.SaveChanges();
            }
            return new EmptyResult();
        }

        [HttpPost]
        public ActionResult Index(HttpPostedFileBase postedFile)
        {
            string filePath = string.Empty;
            if (postedFile != null)
            {
                string path = Server.MapPath("~/Uploads/");
                if (!Directory.Exists(path))
                {
                    Directory.CreateDirectory(path);
                }

                filePath = path + Path.GetFileName(postedFile.FileName);
                string extension = Path.GetExtension(postedFile.FileName);
                postedFile.SaveAs(filePath);

                //Create a DataTable.
                DataTable dt = new DataTable();
                dt.Columns.AddRange(new DataColumn[11] { new DataColumn("Payroll_Number", typeof(string)),
                                new DataColumn("Forename", typeof(string)),
                                new DataColumn("Surname",typeof(string)),
                                new DataColumn("Date_of_Birth",typeof(DateTime)),
                                new DataColumn("Telephone",typeof(string)),
                                new DataColumn("Mobile",typeof(string)),
                                new DataColumn("Address",typeof(string)),
                                new DataColumn("Address_2",typeof(string)),
                                new DataColumn("Postcode",typeof(string)),
                                new DataColumn("EMail_Home",typeof(string)),
                                new DataColumn("Start_Date",typeof(DateTime)) });


                //Read the CSV file
                string csvData = System.IO.File.ReadAllText(filePath);
                Boolean headerRowHasBeenSkipped = false;
                //Execute a loop over the rows
                foreach (string row in csvData.Split('\n'))
                {
                    if (headerRowHasBeenSkipped)
                    {
                        if (!string.IsNullOrEmpty(row))
                        {
                            dt.Rows.Add();
                            int i = 0;

                            //Execute a loop over the columns
                            foreach (string cell in row.Split(','))
                            {
                                dt.Rows[dt.Rows.Count - 1][i] = cell;
                                i++;
                            }
                        }
                    }
                    headerRowHasBeenSkipped = true;
                }

                string conString = ConfigurationManager.ConnectionStrings["ConstringTest"].ConnectionString;
                using (SqlConnection con = new SqlConnection(conString))
                {
                    using (SqlBulkCopy sqlBulkCopy = new SqlBulkCopy(con))
                    {
                        //Datatable name.
                        sqlBulkCopy.DestinationTableName = "[dbo].[Employees]";

                        //opt.Map the DataTable columns with that of the database table
                        sqlBulkCopy.ColumnMappings.Add("Payroll_Number", "Payroll_Number");
                        sqlBulkCopy.ColumnMappings.Add("Forename", "Forename");
                        sqlBulkCopy.ColumnMappings.Add("Surname", "Surname");
                        sqlBulkCopy.ColumnMappings.Add("Date_of_Birth", "Date_of_Birth");
                        sqlBulkCopy.ColumnMappings.Add("Telephone", "Telephone");
                        sqlBulkCopy.ColumnMappings.Add("Mobile", "Mobile");
                        sqlBulkCopy.ColumnMappings.Add("Address", "Address");
                        sqlBulkCopy.ColumnMappings.Add("Address_2", "Address_2");
                        sqlBulkCopy.ColumnMappings.Add("Postcode", "Postcode");
                        sqlBulkCopy.ColumnMappings.Add("EMail_Home", "EMail_Home");
                        sqlBulkCopy.ColumnMappings.Add("Start_Date", "Start_Date");

                        con.Open();
                        sqlBulkCopy.WriteToServer(dt);
                        con.Close();
                    }
                }
            }

            return RedirectToAction("Index"); ;
        }
    }
}