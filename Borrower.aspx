<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Borrower.aspx.cs" Inherits="Borrower" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        .errorMesssage {
    color: darkred !important;
}
        /*body{    background-color: lightgray !important;
}*/
    </style>
</asp:Content>
<%--the Content2 is for the master page to use--%>
<asp:Content ID="Content2" ContentPlaceHolderID="MainPlaceholder" Runat="Server">
    <form runat="server">
        <%-- The grid view allows for Edits and Deletes to be made for specific Borrowers--%>
    <h1 style="font-size:50px;font-style:italic">Borrower Table</h1>
        <div style=" width:60%; margin-left:auto; margin-right:auto;">
            <asp:GridView ID="GridView1" runat="server" 
                AllowSorting="True" AutoGenerateColumns="False" 
                BackColor="#CCCCCC" BorderColor="#999999" 
                BorderStyle="Solid" BorderWidth="3px" 
                CellPadding="4" CellSpacing="2" 
                DataKeyNames="BorrowerID" DataSourceID="Borrower1" 
                ForeColor="Black" AllowPaging="True">
                <Columns>
                    <asp:BoundField DataField="BorrowerID" HeaderText="BorrowerID" InsertVisible="False" ReadOnly="True" SortExpression="BorrowerID">
                    <ItemStyle Width="75px" />
                </asp:BoundField>
                    <asp:TemplateField HeaderText="FirstName" SortExpression="FirstName">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtFirstNameEdit" runat="server" Text='<%# Bind("FirstName") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvFirstNameEdit" runat="server" Text="*" ErrorMessage="First Name is required" ControlToValidate="txtFirstNameEdit" ValidationGroup="Edit"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("FirstName") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="200px" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="LastName" SortExpression="LastName">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtLastNameEdit" runat="server" Text='<%# Bind("LastName") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvLastNameEdit" runat="server" Text="*" ErrorMessage="Last Name is required" ControlToValidate="txtLastNameEdit" ValidationGroup="Edit"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("LastName") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="200px" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="PhoneNumber" SortExpression="PhoneNumber">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtPhoneNumberEdit" runat="server" Text='<%# Bind("PhoneNumber") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvPhoneNumberEdit" runat="server" Text="*" ErrorMessage="Phone Number is required" ControlToValidate="txtPhoneNumberEdit" ValidationGroup="Edit"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1Edit" runat="server" Display="Dynamic" ErrorMessage="Must be a valid phone number" ValidationGroup="Edit"  ControlToValidate="txtPhoneNumberEdit" ValidationExpression="^\s*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$"></asp:RegularExpressionValidator>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("PhoneNumber") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="150px" />
                    </asp:TemplateField>
                    <asp:CommandField ButtonType="Button" ShowEditButton="True" ValidationGroup="Edit"/>
                    <asp:CommandField ButtonType="Button" ShowDeleteButton="True"/>
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
        <%--The validation summary takes all the validations with the group of Edit and puts those errorMessages in one place--%> 
            <asp:ValidationSummary ID="vsGridView" runat="server"
            HeaderText="Please correct the following errors:" 
            ValidationGroup="Edit" CssClass="text-danger" />  

<%--        The datasource allows for connection to the database and allows for us to add edit and delete from the borrower table--%>
            <asp:SqlDataSource ID="Borrower2" runat="server"></asp:SqlDataSource>
            <asp:SqlDataSource ID="Borrower1" runat="server" ConnectionString="<%$ ConnectionStrings:DiskInventoryConnectionString2 %>" DeleteCommand="DELETE FROM [Borrower] WHERE [BorrowerID] = @BorrowerID" InsertCommand="INSERT INTO [Borrower] ([FirstName], [LastName], [PhoneNumber]) VALUES (@FirstName, @LastName, @PhoneNumber)" SelectCommand="SELECT [BorrowerID], [FirstName], [LastName], [PhoneNumber] FROM [Borrower]" UpdateCommand="UPDATE [Borrower] SET [FirstName] = @FirstName, [LastName] = @LastName, [PhoneNumber] = @PhoneNumber WHERE [BorrowerID] = @BorrowerID">
                <DeleteParameters>
                    <asp:Parameter Name="BorrowerID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="FirstName" Type="String" />
                    <asp:Parameter Name="LastName" Type="String" />
                    <asp:Parameter Name="PhoneNumber" Type="String" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="FirstName" Type="String" />
                    <asp:Parameter Name="LastName" Type="String" />
                    <asp:Parameter Name="PhoneNumber" Type="String" />
                    <asp:Parameter Name="BorrowerID" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>

        </div>

    <div style=" width:50%; margin-left:auto; margin-right:auto;">
<%--        The detail view is for the insert of a borrower, It is only for the insert so the default mode is insert--%>
        <asp:DetailsView ID="DetailsView1" runat="server"  DefaultMode="Insert" AutoPostBack="true" AutoGenerateRows="False" DataSourceID="Borrower1">
            <HeaderTemplate>
                <p style="font-size:20px;font-style:italic">To Add a new Borrrower, enter the information 
                    and click insert</p>
            </HeaderTemplate>
            <HeaderStyle CssClass="bg-info"/>
            <Fields>
                <asp:BoundField DataField="BorrowerID" HeaderText="BorrowerID" InsertVisible="False" ReadOnly="True" SortExpression="BorrowerID" />
                <asp:TemplateField HeaderText="FirstName" SortExpression="FirstName">
                    <InsertItemTemplate>
                        <asp:TextBox ID="txtFirstName" runat="server" Text='<%# Bind("FirstName") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvFirstName" runat="server" Text="*" ErrorMessage="First Name is required" ControlToValidate="txtFirstName" ValidationGroup="Insert"></asp:RequiredFieldValidator>
                    </InsertItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="LastName" SortExpression="LastName">
                    <InsertItemTemplate>
                        <asp:TextBox ID="txtLastName" runat="server" Text='<%# Bind("LastName") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvLastName" runat="server" Text="*" ErrorMessage="Last Name is required" ControlToValidate="txtLastName" ValidationGroup="Insert"></asp:RequiredFieldValidator>
                    </InsertItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="PhoneNumber" SortExpression="PhoneNumber">
                    <InsertItemTemplate>
                        <asp:TextBox ID="txtPhoneNumber" runat="server" Text='<%# Bind("PhoneNumber") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvPhoneNumber" runat="server" Text="*" ErrorMessage="Phone Number is required" ControlToValidate="txtPhoneNumber" ValidationGroup="Insert"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" Display="Dynamic" ErrorMessage="Must be a valid phone number" ValidationGroup="Insert"  ControlToValidate="txtPhoneNumber" ValidationExpression="^\s*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$"></asp:RegularExpressionValidator>
                    </InsertItemTemplate>
                </asp:TemplateField>
                <asp:CommandField CancelText="Refresh" ShowInsertButton="True" ValidationGroup="Insert"/>
            </Fields>
        </asp:DetailsView>
        <%--The validation summary takes all the validations with the group of insert and puts those errorMessages in one place--%> 
                <asp:ValidationSummary ID="vsDetailView" runat="server"
            HeaderText="Please correct the following errors:" 
            ValidationGroup="Insert" CssClass="text-danger" />  
    </div>

    </form>


    
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footerPlaceHolder" Runat="Server">
</asp:Content>

