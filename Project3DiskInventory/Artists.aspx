<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Artists.aspx.cs" Inherits="_Artists" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
        <script src="Scripts/jquery-1.9.1.min.js"></script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainPlaceholder" Runat="Server">
    <form id="form1" runat="server">
        <%-- The grid view allows for Edits and Deletes to be made for specific Artist--%>
        <h1 style="font-size:50px;font-style:italic">Artist Table</h1>
        <div style=" width:50%; margin-left:auto; margin-right:auto;">
            <asp:GridView ID="grdArtist" runat="server" AutoGenerateColumns="False" DataKeyNames="ArtistID" 
                OnRowEditing="OnRowEditing" OnRowCancelingEdit="OnRowCancelingEdit" OnPageIndexChanging="GridView1_PageIndexChanging"
                OnRowUpdating="OnRowUpdating" OnRowDeleting="OnRowDeleting" EmptyDataText="No records has been added."
                BackColor="#CCCCCC" BorderColor="#999999" 
                BorderStyle="Solid" BorderWidth="3px" 
                CellPadding="4" CellSpacing="2" AllowSorting="True" 
                ForeColor="Black" AllowPaging="True" PageSize="10">
                <Columns>
                    <asp:BoundField DataField="ArtistID" HeaderText="ArtistID" InsertVisible="False" ReadOnly="True" SortExpression="ArtistID">
                        <ItemStyle Width="75px" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="ArtistTypeID" SortExpression="ArtistTypeID">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtArtistTypeEdit" runat="server" Text='<%# Eval("ArtistTypeID") %>'></asp:TextBox>
                            <%--Validation is required and a regular expression was added to make it either a 1 or 2 with appropiate error messages--%>
                            <asp:RequiredFieldValidator ID="rfvArtistEdit" runat="server" Text="*" ErrorMessage="Artist Type is required" ControlToValidate="txtArtistTypeEdit" ValidationGroup="Edit"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1Edit" runat="server" Display="Dynamic" ErrorMessage="Must be either 1 for group artist or 2 for solo artist" ValidationGroup="Edit"  ControlToValidate="txtArtistTypeEdit" ValidationExpression="^[1-2]{1}$"></asp:RegularExpressionValidator>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("ArtistTypeID") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="100px" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="FirstName" SortExpression="FirstName">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtFirstNameEdit" runat="server" Text='<%# Eval("FirstName") %>'></asp:TextBox>
                            <%--Validation is required with appropiate error messages--%>
                            <asp:RequiredFieldValidator ID="rfvFirstEdit" runat="server" Text="*" ErrorMessage="First Name is required" ControlToValidate="txtFirstNameEdit" ValidationGroup="Edit"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# Eval("FirstName") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="100px" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="LastName" SortExpression="LastName">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtLastNameEdit" runat="server" Text='<%# Eval("LastName") %>'></asp:TextBox>
                            <%--Validation is required with appropiate error messages--%>
                            <asp:RequiredFieldValidator ID="rfvLastEdit" runat="server" Text="*" ErrorMessage="Last Name is required" ControlToValidate="txtLastNameEdit" ValidationGroup="Edit"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label3" runat="server" Text='<%# Eval("LastName") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="100px" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="GroupName" SortExpression="GroupName">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtGroupNameEdit" runat="server" Text='<%# Eval("GroupName") %>'></asp:TextBox>
                            <%--Validation is required with appropiate error messages--%>
                            <asp:RequiredFieldValidator ID="rfvGroupEdit" runat="server" Text="*" ErrorMessage="Group Name is required" ControlToValidate="txtGroupNameEdit" ValidationGroup="Edit"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label4" runat="server" Text='<%# Eval("GroupName") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="100px" />
                    </asp:TemplateField>
                    <%--edit and delete buttons--%>
                    <asp:CommandField ButtonType="Button" ShowEditButton="True" ValidationGroup="Edit"/>
                    <asp:CommandField ButtonType="Button" ShowDeleteButton="True"  ValidationGroup="Edit"/>
                </Columns>
                <FooterStyle BackColor="#CCCCCC" />
                <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                <RowStyle BackColor="White" />
                <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#F1F1F1" />
                <SortedAscendingHeaderStyle BackColor="#808080" />
                <SortedDescendingCellStyle BackColor="#CAC9C9" />
                <SortedDescendingHeaderStyle BackColor="#383838" />
            </asp:GridView>
        <%--These are the datafeilds for the add Artist it takes all the inputs, validates them, then uses a stored procedure to insert them into the database--%>
        <table border="1" style="border-collapse: collapse">
            <tr>
                <td style="width: 150px">
                    Artist Type:<br />
                    <asp:TextBox ID="txtArtistTypeAdd" runat="server" Width="140"/>
                    <%--Validation is required and a regular expression was added to make it either a 1 or 2 with appropiate error messages--%>
                    <asp:RequiredFieldValidator ID="rfvArtistAdd" runat="server" Text="*" ErrorMessage="Artist Type is required" ControlToValidate="txtArtistTypeAdd" ValidationGroup="Add"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1Add" runat="server" Display="Dynamic" ErrorMessage="Must be either 1 for group artist or 2 for solo artist" ValidationGroup="Add"  ControlToValidate="txtArtistTypeAdd" ValidationExpression="^[1-2]{1}$"></asp:RegularExpressionValidator>
                </td>
                <%--There is no validation on the names because any two out of the three can be null (it checks for that in the code behind)--%>
                <td style="width: 150px">
                    First Name:<br />
                    <asp:TextBox ID="txtFirstNameAdd" runat="server"/>
                </td>
                <td style="width: 150px">
                    Last Name:<br />
                    <asp:TextBox ID="txtLastNameAdd" runat="server" Width="140"/>
                </td>
                <td style="width: 150px">
                    Group Name:<br />
                    <asp:TextBox ID="txtGroupNameAdd" runat="server" Width="140" ValidationGroup="Add"/>
                </td>
                <td style="width: 100px">
                    <asp:Button ID="btnAdd" runat="server" Text="Add" OnClick="Insert" ValidationGroup="Add"/>
                </td>
            </tr>
        </table>    
            <%--The validation summary takes all the validations with the group of Edit and puts those errorMessages in one place--%>
            <asp:ValidationSummary ID="ValidationSummary1Edit" runat="server"
                HeaderText="Please correct the following errors:" 
                ValidationGroup="Edit" CssClass="text-danger" />  

            <%--The validation summary takes all the validations with the group of Add and puts those errorMessages in one place--%>
            <asp:ValidationSummary ID="ValidationSummary2" runat="server"
                HeaderText="Please correct the following errors:" 
                ValidationGroup="Add" CssClass="text-danger"/>
            <asp:Label runat="server" ID="ErrorMessage" CssClass="text-danger"></asp:Label>

            </div>
    </form>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footerPlaceHolder" Runat="Server">
</asp:Content>

