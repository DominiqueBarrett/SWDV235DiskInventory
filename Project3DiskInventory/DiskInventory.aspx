<%--/*********************
 * 12-04-2018                     *
 * Dominique Barrett              *
 * Added Labe for error Message   *    
 ************************ */--%>
<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="DiskInventory.aspx.cs" Inherits="_DiskInventory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainPlaceholder" Runat="Server">
    <form id="DiskForm" runat="server">
    <%-- The grid view allows for Edits and Deletes to be made for specific Disks--%>
    <h1 style="font-size:50px;font-style:italic">Disk Inventory Table</h1>
    <div style=" width:60%; margin-left:auto; margin-right:auto;">
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="DiskID"
            OnRowEditing="OnRowEditing" OnRowCancelingEdit="OnRowCancelingEdit" OnPageIndexChanging="GridView1_PageIndexChanging"
            OnRowUpdating="OnRowUpdating" OnRowDeleting="OnRowDeleting" EmptyDataText="No records has been added."
            AllowSorting="True" BackColor="#CCCCCC" BorderColor="#999999" 
            BorderStyle="Solid" BorderWidth="3px" 
            CellPadding="4" CellSpacing="2" ForeColor="Black"
            AllowPaging="True">
            <Columns>
                <asp:BoundField DataField="DiskID" HeaderText="DiskID" InsertVisible="False" ReadOnly="True" SortExpression="DiskID">
                    <ItemStyle Width="75px" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="DiskTypeID" SortExpression="DiskTypeID">
                    <EditItemTemplate>
                        <asp:TextBox ID="txtDiskTypeEdit" runat="server" Text='<%# Eval("DiskTypeID") %>'></asp:TextBox>
                        <%--Validation is required and a regular expression was added to make it either a 1 or 2 with appropiate error messages--%>
                        <asp:RequiredFieldValidator ID="rfvDiskType" runat="server" Text="*" ErrorMessage="Disk Type is required" ControlToValidate="txtDiskTypeEdit" ValidationGroup="Edit"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1Edit" runat="server" Display="Dynamic" ErrorMessage="Must be either 1 for CD or 2 for DVD" ValidationGroup="Edit"  ControlToValidate="txtDiskTypeEdit" ValidationExpression="^[1-2]{1}$"></asp:RegularExpressionValidator>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("DiskTypeID") %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle Width="75px" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="DiskStatusID" SortExpression="DiskStatusID">
                    <EditItemTemplate>
                        <asp:TextBox ID="txtDiskStatusEdit" runat="server" Text='<%# Eval("DiskStatusID") %>'></asp:TextBox>
                        <%--Validation is required and a regular expression was added to make it either a 1 or 2 with appropiate error messages--%>
                        <asp:RequiredFieldValidator ID="rfvDiskStatus" runat="server" Text="*" ErrorMessage="Disk Status is required" ControlToValidate="txtDiskStatusEdit" ValidationGroup="Edit"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RvEdit" runat="server" Display="Dynamic" ErrorMessage="Must be either 1 for available or 2 for unavailable" ValidationGroup="Edit"  ControlToValidate="txtDiskStatusEdit" ValidationExpression="^[1-2]{1}$"></asp:RegularExpressionValidator>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Eval("DiskStatusID") %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle Width="75px" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="GenreID" SortExpression="GenreID">
                    <EditItemTemplate>
                        <asp:TextBox ID="txtGenreEdit" runat="server" Text='<%# Eval("GenreID") %>'></asp:TextBox>
                        <%--Validation is required and a regular expression was added to make it one of the existing Genres with appropiate error messages--%>
                        <asp:RequiredFieldValidator ID="rfvGenre" runat="server" Text="*" ErrorMessage="Genre is required" ControlToValidate="txtGenreEdit" ValidationGroup="Edit"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator3Edit" runat="server" Display="Dynamic" ErrorMessage="That Genre Type does not exist" ValidationGroup="Edit"  ControlToValidate="txtGenreEdit" ValidationExpression="^[1-7]{1}$"></asp:RegularExpressionValidator>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Eval("GenreID") %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle Width="75px" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="DiskName" SortExpression="DiskName">
                    <EditItemTemplate>
                        <asp:TextBox ID="txtDiskNameEdit" runat="server" Text='<%# Eval("DiskName") %>'></asp:TextBox>
                        <%--Validation is required with appropiate error messages--%>
                        <asp:RequiredFieldValidator ID="rfvDiskName" runat="server" Text="*" ErrorMessage="Disk Name is required" ControlToValidate="txtDiskNameEdit" ValidationGroup="Edit"></asp:RequiredFieldValidator>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label4" runat="server" Text='<%# Eval("DiskName") %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle Width="250px" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="ReleasedDate" SortExpression="ReleasedDate">
                    <EditItemTemplate>
                        <asp:TextBox ID="txtReleasedDateEdit" TextMode="Date" runat="server" Text='<%# Bind("ReleasedDate", "{0:yyyy-MM-dd}") %>'></asp:TextBox>
                        <%--Validation is required and a compare to make sure it is a date with appropiate error messages--%>
                        <asp:RequiredFieldValidator ID="rfvReleasedDate" runat="server" Text="*" ErrorMessage="Released Date is required" ControlToValidate="txtReleasedDateEdit" ValidationGroup="Edit" ></asp:RequiredFieldValidator>
                        <asp:CompareValidator id="dateValidator" runat="server" Type="Date" Display="Dynamic" Operator="DataTypeCheck" ControlToValidate="txtReleasedDateEdit" ValidationGroup="Edit" ErrorMessage="Please enter a valid date."></asp:CompareValidator>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label5" runat="server" Text='<%# Eval("ReleasedDate", "{0:yyyy-MM-dd}") %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle Width="100px" />
                </asp:TemplateField>
                <%--edit and delete buttons for the first gridview--%>
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
        <asp:Label ID="PageErrorMessage" runat="server" Text="" CssClass="text-danger"></asp:Label>
        <%--These are the datafeilds for the add disk it takes all the inputs, validates them, then uses a stored procedure to insert them into the database--%>
        <table border="1" style="border-collapse: collapse">
            <tr>
                <td style="width: 150px">
                    Type:<br />
                    <asp:TextBox ID="txtDiskTypeAdd" runat="server" Width="140"/>
                    <%--Validation is required and a regular expression was added to make it either a 1 or 2 with appropiate error messages--%>
                    <asp:RequiredFieldValidator ID="rfvDiskTypeAdd" runat="server" Text="*" Display="Dynamic" ErrorMessage="Disk Type is required" ControlToValidate="txtDiskTypeAdd" ValidationGroup="Add"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RvDiskTypeAdd" runat="server" Display="Dynamic" ErrorMessage="Must be either 1 for CD or 2 for DVD" ValidationGroup="Add"  ControlToValidate="txtDiskTypeAdd" ValidationExpression="^[1-2]{1}$"></asp:RegularExpressionValidator>
                </td>
                <td style="width: 150px">
                    Status:<br />
                    <asp:TextBox ID="txtDiskStatusAdd" runat="server"/>
                    <%--Validation is required and a regular expression was added to make it either a 1 or 2 with appropiate error messages--%>
                    <asp:RequiredFieldValidator ID="rfvDiskStatusAdd" runat="server" Text="*" Display="Dynamic" ErrorMessage="Disk Status is required" ControlToValidate="txtDiskStatusAdd" ValidationGroup="Add"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RvDiskStatusAdd" runat="server" Display="Dynamic" ErrorMessage="Must be either 1 for available or 2 for unavailable" ValidationGroup="Add"  ControlToValidate="txtDiskStatusAdd" ValidationExpression="^[1-2]{1}$"></asp:RegularExpressionValidator>
                </td>
                <td style="width: 150px">
                    Genre:<br />
                    <asp:TextBox ID="txtGenreAdd" runat="server" Width="140"/>
                    <%--Validation is required and a regular expression was added to make it one of the existing Genres with appropiate error messages--%>
                    <asp:RequiredFieldValidator ID="rfvGenreAdd" runat="server" Text="*" Display="Dynamic" ErrorMessage="Genre is required" ControlToValidate="txtGenreAdd" ValidationGroup="Add"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3Add" runat="server" Display="Dynamic" ErrorMessage="That Genre Type does not exist" ValidationGroup="Add"  ControlToValidate="txtGenreAdd" ValidationExpression="^[1-7]{1}$"></asp:RegularExpressionValidator>
                </td>
                <td style="width: 150px">
                    Name:<br />
                    <asp:TextBox ID="txtDiskNameAdd" runat="server" Width="140"/>
                    <%--Validation is required with appropiate error messages--%>
                    <asp:RequiredFieldValidator ID="rfvDiskNameAdd" runat="server" Text="*" Display="Dynamic" ErrorMessage="Disk Name is required" ControlToValidate="txtDiskNameAdd" ValidationGroup="Add"></asp:RequiredFieldValidator>
                </td>
                <td style="width: 150px">
                    Released Date:<br />
                    <asp:TextBox ID="txtReleasedDateAdd" runat="server" Width="140" ValidationGroup="Add"/>
                    <%--Validation is required and a compare to make sure it is a date with appropiate error messages--%>
                    <asp:RequiredFieldValidator ID="rfvReleasedDateAdd" runat="server" Display="Dynamic" Text="*" ErrorMessage="Released Date is required" ControlToValidate="txtReleasedDateAdd" ValidationGroup="Add" ></asp:RequiredFieldValidator>
                    <asp:CompareValidator id="dateValidatorAdd" runat="server" Type="Date" Display="Dynamic" Operator="DataTypeCheck" ControlToValidate="txtReleasedDateAdd" ValidationGroup="Add" ErrorMessage="Please enter a valid date."></asp:CompareValidator>
                </td>
                <td style="width: 100px">
                    <asp:Button ID="btnAdd" runat="server" Text="Add" OnClick="Insert" ValidationGroup="Add"/>
                </td>
            </tr>
        </table>  
        <%--The validation summary takes all the validations with the group of Edit and puts those errorMessages in one place--%>
        <asp:ValidationSummary ID="ValidationSummaryEdit" runat="server"
            HeaderText="Please correct the following errors:" 
            ValidationGroup="Edit" CssClass="text-danger" />  
        <asp:ValidationSummary ID="ValidationSummaryAdd" runat="server"
            HeaderText="Please correct the following errors:" 
            ValidationGroup="Add" CssClass="text-danger" /> 
    </div>

        <br />
        <div style=" width:60%; margin-left:auto; margin-right:auto;">
        <h1 style="font-size:40px;font-style:italic">On Loan</h1>
        <%--The second gridview is to show all the disks that are on loan or unavailable--%>
        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource5"
            BackColor="#CCCCCC" BorderColor="#999999" 
                BorderStyle="Solid" BorderWidth="3px" 
                CellPadding="4" CellSpacing="2" AllowSorting="True" 
                ForeColor="Black" AllowPaging="True">
            <Columns>
                <asp:TemplateField HeaderText="DiskName" SortExpression="DiskName">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("DiskName") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("DiskName") %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle Width="300px" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="BorrowedDate" SortExpression="BorrowedDate">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("BorrowedDate") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("BorrowedDate", "{0:yyyy-MM-dd}") %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle Width="150px" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="FirstName" SortExpression="FirstName">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("FirstName") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("FirstName") %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle Width="150px" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="LastName" SortExpression="LastName">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("LastName") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("LastName") %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle Width="150px" />
                </asp:TemplateField>
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
            <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:DiskInventoryConnectionString2 %>" SelectCommand="SELECT D.DiskName, DB.BorrowedDate, B.FirstName, B.LastName, D.DiskID, B.BorrowerID FROM Disks AS D INNER JOIN DiskHasBorrower AS DB ON D.DiskID = DB.DiskID INNER JOIN Borrower AS B ON DB.BorrowerID = B.BorrowerID WHERE (DB.ReturnedDate IS NULL) ORDER BY B.FirstName"></asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DiskInventoryConnectionString2 %>" 
            SelectCommand="SELECT D.DiskName, DB.BorrowedDate, B.FirstName, B.LastName, D.DiskID, B.BorrowerID FROM Disks AS D INNER JOIN DiskHasBorrower AS DB ON D.DiskID = DB.DiskID INNER JOIN Borrower AS B ON DB.BorrowerID = B.BorrowerID WHERE (DB.ReturnedDate IS NULL) ORDER BY B.FirstName"></asp:SqlDataSource>
    </div>
    <div style=" width:70%; margin-left:auto; margin-right:auto;">
        <table border="1" style="border-collapse: collapse">
            <tr>
                <td style="width: 50px">
                    Disk:<br />
                    <%--The dropdown finds all disk that are available to be borrowed and allows you to select one out of that list (it uses a nested select statement to find them)--%>
                    <asp:DropDownList ID="DiskLoan" runat="server" DataSourceID="SqlDataSource2" DataTextField="DiskName" DataValueField="DiskID"></asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DiskInventoryConnectionString2 %>" SelectCommand="SELECT *
                    FROM Disks
                    WHERE DiskID NOT IN (
	                    SELECT DiskID
	                    FROM DiskHasBorrower
	                    WHERE ReturnedDate IS NULL OR ReturnedDate &gt;= GETDATE()
                    )"></asp:SqlDataSource>
                </td>
                <td style="width: 150px">
                    Borrower:<br />
                    <%--This dropdown finds all the borrowers and allows you to select one. it also put both the first and last names into the same dropdown--%> 
                    <asp:DropDownList ID="BorrowerLoan" runat="server" DataSourceID="SqlDataSource3" DataTextField="Name" DataValueField="BorrowerID"></asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:DiskInventoryConnectionString2 %>" 
                        SelectCommand="SELECT [BorrowerID], [FirstName] + ' ' + [LastName] AS Name FROM [Borrower]"></asp:SqlDataSource>
                </td>
                <td style="width: 150px">
                    Borrowed Date:<br />
                    <asp:TextBox ID="txtBorrowerDateLoan" runat="server"></asp:TextBox>
                    <%--Validation is required and a compare to make sure it is a date with appropiate error messages--%>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" Text="*" ErrorMessage="Borrowed Date is required" ControlToValidate="txtBorrowerDateLoan" ValidationGroup="Loan" ></asp:RequiredFieldValidator>
                    <asp:CompareValidator id="CompareValidator1" runat="server" Type="Date" Display="Dynamic" Operator="DataTypeCheck" ControlToValidate="txtBorrowerDateLoan" ValidationGroup="Loan" ErrorMessage="Please enter a valid date."></asp:CompareValidator>

                </td>
                <td>
                    <asp:Button ID="btnLoan" runat="server" Text="Loan" OnClick="btnLoan_Click"  ValidationGroup="Loan"/>
                </td>
            </tr>
        </table> 
            <%--The validation summary takes all the validations with the group of Loan and puts those errorMessages in one place--%>
            <asp:ValidationSummary ID="ValidationSummary2" runat="server"
                HeaderText="Please correct the following errors:" 
                ValidationGroup="Loan" CssClass="text-danger"/>
            <asp:Label runat="server" ID="ErrorMessage" CssClass="text-danger"></asp:Label>

    </div>
</form>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footerPlaceHolder" Runat="Server">
</asp:Content>

