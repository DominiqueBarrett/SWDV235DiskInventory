using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;

public partial class _DiskInventory : Page
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
        //This is To bind the grid in order to display the correct information.
        using (SqlConnection con = new SqlConnection(
                    @"Server=F18SERVERB15\SQLDEV01;Database=DiskInventory;User Id=sa; Password=Pa$$w0rd;"))
        {
            //This is the stored procedure Disks_SP with the actionn of SELECT that find all disks and puts them into this list
            using (SqlCommand cmd = new SqlCommand("Disks_SP"))
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
            //This finds all of the Disks that are currently on loan (not available) so they can be used in the dropdown list for the adding a diskhasborrower
            //it uses a nested select statement to do so
            using (SqlCommand cmd = new SqlCommand("DiskOnLoan_SP"))
            {
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
    protected void Insert(object sender, EventArgs e)
    {
        //The isValid makes sure the validation has run and if it has an error returns so you can view and fix the errors
        if (!IsValid)
        {
            return;
        }
        else
        {
            //This uses the same stored procedure Disks_SP but with a different action in order to INSERT into the database
            string DiskTypeID = txtDiskTypeAdd.Text;
            string DiskStatusID = txtDiskStatusAdd.Text;
            string GenreID = txtGenreAdd.Text;
            string DiskName = txtDiskNameAdd.Text;
            string ReleasedDate = txtReleasedDateAdd.Text;
            using (SqlConnection con = new SqlConnection(
                        @"Server=F18SERVERB15\SQLDEV01;Database=DiskInventory;User Id=sa; Password=Pa$$w0rd;"))
            {
                using (SqlCommand cmd = new SqlCommand("Disks_SP"))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Action", "INSERT");
                    cmd.Parameters.AddWithValue("@DiskTypeID", DiskTypeID);
                    cmd.Parameters.AddWithValue("@DiskStatusID", DiskStatusID);
                    cmd.Parameters.AddWithValue("@GenreID", GenreID);
                    cmd.Parameters.AddWithValue("@DiskName", DiskName);
                    cmd.Parameters.AddWithValue("@ReleasedDate", ReleasedDate);
                    cmd.Connection = con;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }
            txtDiskNameAdd.Text = null;
            txtDiskStatusAdd.Text = null;
            txtDiskTypeAdd.Text = null;
            txtGenreAdd.Text = null;
            txtReleasedDateAdd.Text = null;
            this.BindGrid();
        }
        //I was having some issues with the page not updating correctly so I added a response redirect to give the page a refresh
        Response.Redirect("DiskInventory.aspx");

    }
    protected void OnRowEditing(object sender, GridViewEditEventArgs e)
    {
        GridView1.EditIndex = e.NewEditIndex;
        this.BindGrid();
    }
    protected void OnRowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        //This uses the same stored procedure Disks_SP but with an action of UPDATE in order to update the Disk based on the DiskID
        GridViewRow row = GridView1.Rows[e.RowIndex];
        int DiskID = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values[0]);
        string DiskTypeID = (row.FindControl("txtDiskTypeEdit") as TextBox).Text;
        string DiskStatusID = (row.FindControl("txtDiskStatusEdit") as TextBox).Text;
        string GenreID = (row.FindControl("txtGenreEdit") as TextBox).Text;
        string DiskName = (row.FindControl("txtDiskNameEdit") as TextBox).Text;
        string ReleasedDate = (row.FindControl("txtReleasedDateEdit") as TextBox).Text;
        using (SqlConnection con = new SqlConnection(
                    @"Server=F18SERVERB15\SQLDEV01;Database=DiskInventory;User Id=sa; Password=Pa$$w0rd;"))
        {
            using (SqlCommand cmd = new SqlCommand("Disks_SP"))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Action", "UPDATE");
                cmd.Parameters.AddWithValue("@DiskID", DiskID);
                cmd.Parameters.AddWithValue("@DiskTypeID", DiskTypeID);
                cmd.Parameters.AddWithValue("@DiskStatusID", DiskStatusID);
                cmd.Parameters.AddWithValue("@GenreID", GenreID);
                cmd.Parameters.AddWithValue("@DiskName", DiskName);
                cmd.Parameters.AddWithValue("@ReleasedDate", ReleasedDate);
                cmd.Connection = con;
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }
        GridView1.EditIndex = -1;
        this.BindGrid();
    }
    protected void OnRowCancelingEdit(object sender, EventArgs e)
    {
        GridView1.EditIndex = -1;
        this.BindGrid();
    }
    protected void OnRowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        //This uses the same stored procedure Disks_SP but with an action of DELETE that deletes the disk bases on what DiskID it is
        int DiskID = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values[0]);
        using (SqlConnection con = new SqlConnection(
                    @"Server=F18SERVERB15\SQLDEV01;Database=DiskInventory;User Id=sa; Password=Pa$$w0rd;"))
        {
            using (SqlCommand cmd = new SqlCommand("Disks_SP"))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Action", "DELETE");
                cmd.Parameters.AddWithValue("@DiskID", DiskID);
                cmd.Connection = con;
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }
        this.BindGrid();
    }

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        //Everytime the page index is changed it re does the Stored procedure Disks_SP with the action of select that gets all Disks
        GridView1.PageIndex = e.NewPageIndex;
        using (SqlConnection con = new SqlConnection(
            @"Server=F18SERVERB15\SQLDEV01;Database=DiskInventory;User Id=sa; Password=Pa$$w0rd;"))
        {
            using (SqlCommand cmd = new SqlCommand("Disks_SP"))
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
    protected void btnLoan_Click(object sender, EventArgs e)
    {
        //The isValid makes sure the validation has run and if it has an error returns so you can view and fix the errors
        if (!IsValid)
        {
            return;
        }
        else
        {
            string BorrowerID = BorrowerLoan.Text;
            string DiskID = DiskLoan.Text;
            string BorrowedDate = txtBorrowerDateLoan.Text;
            //This uses a stored procedure of DiskHasBorrower_SP that inserts into the HasBorrower Page
            using (SqlConnection con = new SqlConnection(
                        @"Server=F18SERVERB15\SQLDEV01;Database=DiskInventory;User Id=sa; Password=Pa$$w0rd;"))
            {
                using (SqlCommand cmd = new SqlCommand("DiskHasBorrower_SP"))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@BorrowerID", BorrowerID);
                    cmd.Parameters.AddWithValue("@DiskID", DiskID);
                    cmd.Parameters.AddWithValue("@BorrowedDate", BorrowedDate);
                    cmd.Parameters.Add("@ReturnedDate", SqlDbType.DateTime).Value = DBNull.Value;
                    cmd.Connection = con;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }
            
            this.BindGrid();
            Response.Redirect("DiskInventory.aspx");
            
        }

    }
}