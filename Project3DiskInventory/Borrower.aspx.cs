/*********************
 * 12-04-2018                     *
 * Dominique Barrett              *
 * Added try catches to           *    
 * Error Check all database calls *
 ************************ */
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;

public partial class _Borrower : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!this.IsPostBack)
        {
            this.BindGrid();
        }
    }

    private void BindGrid()
    {
        try
        {
            //This is To bind the grid in order to display the correct information.
            using (SqlConnection con = new SqlConnection(
                        @"Server=F18SERVERB15\SQLDEV01;Database=DiskInventory;User Id=sa; Password=Pa$$w0rd;"))
            {
                //This is the stored procedure Borrower_SP with the actionn of SELECT that find all Borrowers and puts them into this list
                using (SqlCommand cmd = new SqlCommand("Borrower_SP"))
                {
                    cmd.Parameters.AddWithValue("@Action", "SELECT");
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Connection = con;
                        sda.SelectCommand = cmd;
                        using (DataTable dt = new DataTable())
                        {
                            sda.Fill(dt);
                            GridView1.DataSource = dt;
                            GridView1.DataBind();
                        }
                    }
                }
            }
        }
        catch
        {
            PageErrorMessage.Text = "We apoligize for the inconvenience but we are unable to load the database at this time.<br/> Please check back later!";
            return;
        }
    }
    protected void Insert(object sender, EventArgs e)
    {
        try
        {
            //The isValid makes sure the validation has run and if it has an error returns so you can view and fix the errors
            if (!IsValid)
            {
                return;
            }
            else
            {
                string FirstName = txtFirstNameAdd.Text;
                string LastName = txtLastNameAdd.Text;
                string PhoneNumber = txtPhoneNumberAdd.Text;
                //This uses the same stored procedure Borrower_SP but with a different action in order to INSERT into the database
                using (SqlConnection con = new SqlConnection(
                            @"Server=F18SERVERB15\SQLDEV01;Database=DiskInventory;User Id=sa; Password=Pa$$w0rd;"))
                {
                    using (SqlCommand cmd = new SqlCommand("Borrower_SP"))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@Action", "INSERT");
                        cmd.Parameters.AddWithValue("@FirstName", FirstName);
                        cmd.Parameters.AddWithValue("@LastName", LastName);
                        cmd.Parameters.AddWithValue("@PhoneNumber", PhoneNumber);
                        cmd.Connection = con;
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                    }
                }
                txtFirstNameAdd.Text = null;
                txtLastNameAdd.Text = null;
                txtPhoneNumberAdd.Text = null;
                this.BindGrid();

            }
        }
        catch
        {
            PageErrorMessage.Text = "We apoligize for the inconvenience but we are unable to add to the database at this time.<br/> Please check back later!";
            return;
        }
    }
    protected void OnRowEditing(object sender, GridViewEditEventArgs e)
    {
        GridView1.EditIndex = e.NewEditIndex;
        this.BindGrid();
    }
    protected void OnRowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        try
        {
            //This uses the same stored procedure Borrower_SP but with an action of UPDATE in order to update the Borrower based on the DiskID
            GridViewRow row = GridView1.Rows[e.RowIndex];
            int BorrowerID = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values[0]);
            string FirstName = (row.FindControl("txtFirstNameEdit") as TextBox).Text;
            string LastName = (row.FindControl("txtLastNameEdit") as TextBox).Text;
            string PhoneNumber = (row.FindControl("txtPhoneNumberEdit") as TextBox).Text;
            using (SqlConnection con = new SqlConnection(
                        @"Server=F18SERVERB15\SQLDEV01;Database=DiskInventory;User Id=sa; Password=Pa$$w0rd;"))
            {
                using (SqlCommand cmd = new SqlCommand("Borrower_SP"))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Action", "UPDATE");
                    cmd.Parameters.AddWithValue("@BorrowerID", BorrowerID);
                    cmd.Parameters.AddWithValue("@FirstName", FirstName);
                    cmd.Parameters.AddWithValue("@LastName", LastName);
                    cmd.Parameters.AddWithValue("@PhoneNumber", PhoneNumber);
                    cmd.Connection = con;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }
            GridView1.EditIndex = -1;
            this.BindGrid();
        }
        catch
        {
            PageErrorMessage.Text = "We apoligize for the inconvenience but we are unable to Update the database at this time.<br/> Please check back later!";
            return;
        }
    }
    protected void OnRowCancelingEdit(object sender, EventArgs e)
    {
        GridView1.EditIndex = -1;
        this.BindGrid();
    }
    protected void OnRowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        try
        {
            int BorrowerID = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values[0]);
            //This uses the same stored procedure Borrower_SP but with an action of DELETE that deletes the Borrower bases on what BorrowerID it is
            using (SqlConnection con = new SqlConnection(
                        @"Server=F18SERVERB15\SQLDEV01;Database=DiskInventory;User Id=sa; Password=Pa$$w0rd;"))
            {
                using (SqlCommand cmd = new SqlCommand("Borrower_SP"))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Action", "DELETE");
                    cmd.Parameters.AddWithValue("@BorrowerID", BorrowerID);
                    cmd.Connection = con;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }
            this.BindGrid();
        }
        catch
        {
            PageErrorMessage.Text = "We apoligize for the inconvenience but we are unable to delete this borrower at this time.<br/> Please check back later!";
            return;
        }
    }
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            //Everytime the page index is changed it re does the Stored procedure Borrower_SP with the action of select that gets all Borrowers
            GridView1.PageIndex = e.NewPageIndex;
            using (SqlConnection con = new SqlConnection(
                @"Server=F18SERVERB15\SQLDEV01;Database=DiskInventory;User Id=sa; Password=Pa$$w0rd;"))
            {
                using (SqlCommand cmd = new SqlCommand("Borrower_SP"))
                {
                    cmd.Parameters.AddWithValue("@Action", "SELECT");
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Connection = con;
                        sda.SelectCommand = cmd;
                        using (DataTable dt = new DataTable())
                        {
                            sda.Fill(dt);
                            GridView1.DataSource = dt;
                            GridView1.DataBind();
                        }
                    }
                }
            }
        }
        catch
        {
            PageErrorMessage.Text = "We apoligize for the inconvenience but we are unable to load the database at this time.<br/> Please check back later!";
            return;
        }
    }
}