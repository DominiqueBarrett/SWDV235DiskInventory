using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;

public partial class _Artists : System.Web.UI.Page
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
            //This is the stored procedure Artist_SP with the actionn of SELECT that find all Artist and puts them into this list
            using (SqlCommand cmd = new SqlCommand("Artist_SP"))
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
                        grdArtist.DataSource = dt;
                        grdArtist.DataBind();
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
        //This validates to make sure at least one name is inputed but any one or two can be null if all three are it executes this and returns with an error message
        else if (txtFirstNameAdd.Text == "" && txtFirstNameAdd.Text == "" && txtGroupNameAdd.Text == "")
        {
            ErrorMessage.Text = "You must at least one name inputed";
            return;
        }
        else
        {
            //This uses the same stored procedure Artist_SP but with a different action in order to INSERT into the database
            string ArtistTypeID = txtArtistTypeAdd.Text;
            string FirstName = txtFirstNameAdd.Text;
            string LastName = txtLastNameAdd.Text;
            string GroupName = txtGroupNameAdd.Text;
            using (SqlConnection con = new SqlConnection(
                        @"Server=F18SERVERB15\SQLDEV01;Database=DiskInventory;User Id=sa; Password=Pa$$w0rd;"))
            {
                using (SqlCommand cmd = new SqlCommand("Artist_SP"))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Action", "INSERT");
                    cmd.Parameters.AddWithValue("@ArtistTypeID", ArtistTypeID);
                    cmd.Parameters.AddWithValue("@FirstName", FirstName);
                    cmd.Parameters.AddWithValue("@LastName", LastName);
                    cmd.Parameters.AddWithValue("@GroupName", GroupName);
                    cmd.Connection = con;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }
            txtArtistTypeAdd.Text = null;
            txtFirstNameAdd.Text = null;
            txtLastNameAdd.Text = null;
            txtGroupNameAdd.Text = null;
            this.BindGrid();

        }
    }
    protected void OnRowEditing(object sender, GridViewEditEventArgs e)
    {
        grdArtist.EditIndex = e.NewEditIndex;
        this.BindGrid();
    }
    protected void OnRowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        //This uses the same stored procedure Disks_SP but with an action of UPDATE in order to update the Disk based on the DiskID
        GridViewRow row = grdArtist.Rows[e.RowIndex];
        int ArtistID = Convert.ToInt32(grdArtist.DataKeys[e.RowIndex].Values[0]);
        string ArtistTypeID = (row.FindControl("txtArtistTypeEdit") as TextBox).Text;
        string FirstName = (row.FindControl("txtFirstNameEdit") as TextBox).Text;
        string LastName = (row.FindControl("txtLastNameEdit") as TextBox).Text;
        string GroupName = (row.FindControl("txtGroupNameEdit") as TextBox).Text;
        //string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        using (SqlConnection con = new SqlConnection(
                    @"Server=F18SERVERB15\SQLDEV01;Database=DiskInventory;User Id=sa; Password=Pa$$w0rd;"))
        {
            using (SqlCommand cmd = new SqlCommand("Artist_SP"))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Action", "UPDATE");
                cmd.Parameters.AddWithValue("@ArtistID", ArtistID);
                cmd.Parameters.AddWithValue("@ArtistTypeID", ArtistTypeID);
                cmd.Parameters.AddWithValue("@FirstName", FirstName);
                cmd.Parameters.AddWithValue("@LastName", LastName);
                cmd.Parameters.AddWithValue("@GroupName", GroupName);
                cmd.Connection = con;
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }
        grdArtist.EditIndex = -1;
        this.BindGrid();
    }
    protected void OnRowCancelingEdit(object sender, EventArgs e)
    {
        grdArtist.EditIndex = -1;
        this.BindGrid();
    }
    protected void OnRowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        //This uses the same stored procedure Artist_SP but with an action of DELETE that deletes the Artist bases on what ArtistID it is
        int ArtistID = Convert.ToInt32(grdArtist.DataKeys[e.RowIndex].Values[0]);
        using (SqlConnection con = new SqlConnection(
                    @"Server=F18SERVERB15\SQLDEV01;Database=DiskInventory;User Id=sa; Password=Pa$$w0rd;"))
        {
            using (SqlCommand cmd = new SqlCommand("Artist_SP"))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Action", "DELETE");
                cmd.Parameters.AddWithValue("@ArtistID", ArtistID);
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
        //Everytime the page index is changed it re does the Stored procedure Artist_SP with the action of select that gets all Artist
        grdArtist.PageIndex = e.NewPageIndex;
        using (SqlConnection con = new SqlConnection(
            @"Server=F18SERVERB15\SQLDEV01;Database=DiskInventory;User Id=sa; Password=Pa$$w0rd;"))
        {
            using (SqlCommand cmd = new SqlCommand("Artist_SP"))
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
                        grdArtist.DataSource = dt;
                        grdArtist.DataBind();
                    }
                }
            }
        }
    }
}