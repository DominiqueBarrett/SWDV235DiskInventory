<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Borrower.aspx.cs" Inherits="_Borrower" %>

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
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="BorrowerID"
            OnRowEditing="OnRowEditing" OnRowCancelingEdit="OnRowCancelingEdit" OnPageIndexChanging="GridView1_PageIndexChanging"
            OnRowUpdating="OnRowUpdating" OnRowDeleting="OnRowDeleting" EmptyDataText="No records has been added."
                AllowSorting="True" 
                BackColor="#CCCCCC" BorderColor="#999999" 
                BorderStyle="Solid" BorderWidth="3px" 
                CellPadding="4" CellSpacing="2" 
                ForeColor="Black" AllowPaging="True">
                <Columns>
                    <asp:BoundField DataField="BorrowerID" HeaderText="BorrowerID" InsertVisible="False" ReadOnly="True" SortExpression="BorrowerID">
                    <ItemStyle Width="75px" />
                </asp:BoundField>
                    <asp:TemplateField HeaderText="FirstNameEdit" SortExpression="FirstName">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtFirstNameEdit" runat="server" Text='<%# Eval("FirstName") %>'></asp:TextBox>
                            <%--Validation is required with appropiate error messages--%>
                            <asp:RequiredFieldValidator ID="rfvFirstNameEdit" runat="server" Text="*" ErrorMessage="First Name is required" ControlToValidate="txtFirstNameEdit" ValidationGroup="Edit"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("FirstName") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="200px" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="LastName" SortExpression="LastName">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtLastNameEdit" runat="server" Text='<%# Eval("LastName") %>'></asp:TextBox>
                            <%--Validation is required with appropiate error messages--%>
                            <asp:RequiredFieldValidator ID="rfvLastNameEdit" runat="server" Text="*" ErrorMessage="Last Name is required" ControlToValidate="txtLastNameEdit" ValidationGroup="Edit"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# Eval("LastName") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="200px" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="PhoneNumber" SortExpression="PhoneNumber">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtPhoneNumberEdit" runat="server" Text='<%# Eval("PhoneNumber") %>'></asp:TextBox>
                            <%--Validation is required and a regular expression was added to sure it has a phone number in a valid format with appropiate error messages--%>
                            <asp:RequiredFieldValidator ID="rfvPhoneNumberEdit" runat="server" Text="*" ErrorMessage="Phone Number is required" ControlToValidate="txtPhoneNumberEdit" ValidationGroup="Edit"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1Edit" runat="server" Display="Dynamic" ErrorMessage="Must be a valid phone number" ValidationGroup="Edit"  ControlToValidate="txtPhoneNumberEdit" ValidationExpression="^\s*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$"></asp:RegularExpressionValidator>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label3" runat="server" Text='<%# Eval("PhoneNumber") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="150px" />
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
            <%--These are the datafeilds for the add Borrower it takes all the inputs, validates them, then uses a stored procedure to insert them into the database--%>
            <table border="1" style="border-collapse: collapse">
                <tr>
                    <td style="width: 150px">
                        First Name:<br />
                        <asp:TextBox ID="txtFirstNameAdd" runat="server" Width="140" />
                        <%--Validation is required with appropiate error messages--%>
                        <asp:RequiredFieldValidator ID="rfvFirstNameAdd" runat="server" Text="*" ErrorMessage="First Name is required" ControlToValidate="txtFirstNameAdd" ValidationGroup="Add"></asp:RequiredFieldValidator>
                    </td>
                    <td style="width: 150px">
                        Last Name:<br />
                        <asp:TextBox ID="txtLastNameAdd" runat="server" Width="140" />
                        <%--Validation is required with appropiate error messages--%>
                        <asp:RequiredFieldValidator ID="rfvLastNameAdd" runat="server" Text="*" ErrorMessage="Last Name is required" ControlToValidate="txtLastNameAdd" ValidationGroup="Add"></asp:RequiredFieldValidator>
                    </td>
                    <td style="width: 150px">
                        Phone Number:<br />
                        <asp:TextBox ID="txtPhoneNumberAdd" runat="server" Width="140" />
                        <%--Validation is required and a regular expression was added to sure it has a phone number in a valid format with appropiate error messages--%>
                        <asp:RequiredFieldValidator ID="rfvPhoneNumberAdd" runat="server" Text="*" ErrorMessage="Phone Number is required" ControlToValidate="txtPhoneNumberAdd" ValidationGroup="Add"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1Add" runat="server" Display="Dynamic" ErrorMessage="Must be a valid phone number" ValidationGroup="Add"  ControlToValidate="txtPhoneNumberAdd" ValidationExpression="^\s*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$"></asp:RegularExpressionValidator>
                    </td>
                    <td style="width: 100px">
                        <asp:Button ID="btnAdd" runat="server" Text="Add" OnClick="Insert" ValidationGroup="Add"/>
                    </td>
                </tr>
            </table>    

            <%--The validation summary takes all the validations with the group of Edit and puts those errorMessages in one place--%> 
            <asp:ValidationSummary ID="vsGridViewEdit" runat="server"
            HeaderText="Please correct the following errors:" 
            ValidationGroup="Edit" CssClass="text-danger" />  
            <%--The validation summary takes all the validations with the group of Add and puts those errorMessages in one place--%> 
            <asp:ValidationSummary ID="ValidationSummaryAdd" runat="server"
            HeaderText="Please correct the following errors:" 
            ValidationGroup="Add" CssClass="text-danger" />  
        </div>
    </form>


    
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footerPlaceHolder" Runat="Server">
</asp:Content>

