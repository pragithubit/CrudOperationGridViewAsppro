using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data;

namespace CrudOperationGridViewAsp
{
    public partial class GridViewPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetData();

            }
        }

        private void GetData()
        {
            string cs = "Data Source=PRADEEP-SAHOO56\\MSSQLSERVER1; Database=TestDB; Integrated Security=true";

            SqlConnection con = new SqlConnection(cs);
            SqlCommand cmd = new SqlCommand("spGetData", con);
            con.Open();
            empGrid.DataSource = cmd.ExecuteReader();
            empGrid.DataBind();
            con.Close();
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string cs = "Data Source=PRADEEP-SAHOO56\\MSSQLSERVER1; Database=TestDB; Integrated Security=true";

            SqlConnection con = new SqlConnection(cs);
            string FirstName = TextBox1.Text;
            string LastName = TextBox2.Text;
            int Age, Salary;
            string MobileNumber = txtMobileno.Text;

            if (!int.TryParse(TextBox3.Text, out Age) || !int.TryParse(TextBox4.Text, out Salary))
            {
               
                IblMsg.Text = "Please enter valid integer values for Age and Salary.";
                return;
            }

            // Proceed with the rest of your code
            SqlCommand cmd = new SqlCommand("spInsert", con);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@FirstName", FirstName);
            cmd.Parameters.AddWithValue("@Lastname", LastName);
            cmd.Parameters.AddWithValue("@Age", Age);
            cmd.Parameters.AddWithValue("@Salary", Salary);
            cmd.Parameters.AddWithValue("@Mobileno", MobileNumber);

            con.Open();
            int a = cmd.ExecuteNonQuery();
            if (a > 0)
            {
                GetData();
                IblMsg.Text = "Record successfully added!";
                ClearControls();
            }
            else
            {
                IblMsg.Text = "Failed to add record.";
            }
            con.Close();


            // IblMsg.Text = "Record Inserted Sucessfully....!!";



            //TextBox1.Text = "";
            //TextBox2.Text = "";
            //TextBox3.Text = "";
            //TextBox4.Text = "";

        }
       
        void ClearControls()
        {
            TextBox1.Text = TextBox2.Text = TextBox3.Text = TextBox4.Text = txtMobileno.Text="";

        }

        protected void empGrid_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int EmpId = Convert.ToInt32(empGrid.DataKeys[e.RowIndex].Value);

            string cs = "Data Source=PRADEEP-SAHOO56\\MSSQLSERVER1; Database=TestDB; Integrated Security=true";

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("spDelete", con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@EmpId", EmpId);

                con.Open();
                int rowsAffected = cmd.ExecuteNonQuery();
                con.Close();

                if (rowsAffected > 0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "deleteAlert", "alert('Record deleted successfully.');", true);

                    
                    GetData();
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "deleteAlert", "alert('Failed to delete record.');", true);
                    
                }
            }

        }

        protected void empGrid_RowEditing(object sender, GridViewEditEventArgs e)
        {
            empGrid.EditIndex = e.NewEditIndex;
            GetData(); 

            
            if (e.NewEditIndex >= 0 && e.NewEditIndex < empGrid.Rows.Count)
            {
              
                GridViewRow editedRow = empGrid.Rows[e.NewEditIndex];

                
                TextBox TextBox1_Edit = (TextBox)editedRow.FindControl("TextBox1");
                TextBox TextBox2_Edit = (TextBox)editedRow.FindControl("TextBox2");
                TextBox TextBox3_Edit = (TextBox)editedRow.FindControl("TextBox3");
                TextBox TextBox4_Edit = (TextBox)editedRow.FindControl("TextBox4");
                TextBox txtMobileno_Edit = (TextBox)editedRow.FindControl("txtMobileno");

              
                DataRowView row = empGrid.Rows[e.NewEditIndex].DataItem as DataRowView;

                // Check if the data row is not null
                if (row != null)
                {
                 
                    TextBox1_Edit.Text = row["FirstName"].ToString();
                    TextBox2_Edit.Text = row["LastName"].ToString();
                    TextBox3_Edit.Text = row["Age"].ToString();
                    TextBox4_Edit.Text = row["Salary"].ToString();
                    txtMobileno_Edit.Text = row["Mobileno"].ToString();
                }
                else
                {
                    //...
                }
            }
        }

        protected void empGrid_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            empGrid.EditIndex = -1;
            GetData();
        }

        protected void empGrid_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            string cs = "Data Source=PRADEEP-SAHOO56\\MSSQLSERVER1; Database=TestDB; Integrated Security=true";

            SqlConnection con = new SqlConnection(cs);
            int EmpId = Convert.ToInt32(empGrid.DataKeys[e.RowIndex].Value);
            string FirstName = (empGrid.Rows[e.RowIndex].FindControl("TextBox1") as TextBox).Text;
            string LastName = (empGrid.Rows[e.RowIndex].FindControl("TextBox2") as TextBox).Text;
            int Age = Convert.ToInt32((empGrid.Rows[e.RowIndex].FindControl("TextBox3") as TextBox).Text);
            decimal Salary = Convert.ToDecimal((empGrid.Rows[e.RowIndex].FindControl("TextBox4") as TextBox).Text);
            string mobileNumber = (empGrid.Rows[e.RowIndex].FindControl("txtMobileno") as TextBox).Text;

            SqlCommand cmd = new SqlCommand("spUpdate", con);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@FirstName", FirstName);
            cmd.Parameters.AddWithValue("@Lastname", LastName);
            cmd.Parameters.AddWithValue("@Age", Age);
            cmd.Parameters.AddWithValue("@Salary", Salary);
            cmd.Parameters.AddWithValue("@Mobileno", mobileNumber);
            cmd.Parameters.AddWithValue("@EmpId", EmpId);

            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            empGrid.EditIndex = -1;
            GetData();
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            TextBox1.Text = "";
            TextBox2.Text = "";
            TextBox3.Text = "";
            TextBox4.Text = "";

        }
    }
}