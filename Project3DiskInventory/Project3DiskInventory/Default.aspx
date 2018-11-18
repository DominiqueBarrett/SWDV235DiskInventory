<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainPlaceholder" Runat="Server">




    <form id="form1" runat="server">
        <h1> Welcome to My Disk Inventory</h1>
        <p style="font-size:20px;">
            This is where I keep track of all the disks I own, including Cds and Dvds.
            <br />
            Please feel free to submit your Name and Phone Number to become a borrower, or browse my Inventory and Artist
        </p>
        <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/Images/Artist.jpg" Width="225px" OnClick="ArtistImage_Click"/>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Images/Disks2.jpg" Width="225px" OnClick="DiskImage_Click"/>
    </form>

    <div style="position:relative;z-index:99;">
        <p>Or take a moment to enjoy some Confetti</p>
      <button id="startConfetti">Start</button>
    </div>
    

<script src="//code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="jquery.confetti.js"></script>


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footerPlaceHolder" Runat="Server">
</asp:Content>

