<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="DiskInventory.aspx.cs" Inherits="DiskInventory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainPlaceholder" Runat="Server">
    <form id="DiskForm" runat="server">
    <%-- The grid view allows for Edits and Deletes to be made for specific Disks--%>

    <h1 style="font-size:50px;font-style:italic">Disk Inventory Table</h1>
    <div style=" width:60%; margin-left:auto; margin-right:auto;">
        <asp:GridView ID="GridView1" runat="server"
            AllowSorting="True" AutoGenerateColumns="False" 
            BackColor="#CCCCCC" BorderColor="#999999" 
            BorderStyle="Solid" BorderWidth="3px" 
            CellPadding="4" CellSpacing="2"
            DataKeyNames="DiskID" DataSourceID="SqlDataSource2"
            ForeColor="Black" AllowPaging="True" PageSize="5">
            <Columns>
                <asp:BoundField DataField="DiskID" HeaderText="DiskID" InsertVisible="False" ReadOnly="True" SortExpression="DiskID">
                    <ItemStyle Width="75px" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="DiskTypeID" SortExpression="DiskTypeID">
                    <EditItemTemplate>
                        <asp:TextBox ID="txtDiskTypeIDEdit" runat="server" Text='<%# Bind("DiskTypeID") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvDiskTypeIDEdit" runat="server" Text="*" ErrorMessage="Disk Type is required" ControlToValidate="txtDiskTypeIDEdit" ValidationGroup="Edit"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1Edit" runat="server" Display="Dynamic" ErrorMessage="Must be either 1 for CD or 2 for DVD" ValidationGroup="Edit"  ControlToValidate="txtDiskTypeIDEdit" ValidationExpression="^[1-2]{1}$"></asp:RegularExpressionValidator>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("DiskTypeID") %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle Width="75px" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="DiskStatusID" SortExpression="DiskStatusID">
                    <EditItemTemplate>
                        <asp:TextBox ID="txtDiskStatusID" runat="server" Text='<%# Bind("DiskStatusID") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvDiskStatusIDEdit" runat="server" Text="*" ErrorMessage="Disk Status is required" ControlToValidate="txtDiskStatusID" ValidationGroup="Edit"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2Edit" runat="server" Display="Dynamic" ErrorMessage="Must be either 1 for available or 2 for unavailable" ValidationGroup="Edit"  ControlToValidate="txtDiskStatusID" ValidationExpression="^[1-2]{1}$"></asp:RegularExpressionValidator>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("DiskStatusID") %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle Width="75px" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="GenreID" SortExpression="GenreID">
                    <EditItemTemplate>
                        <asp:TextBox ID="txtGenreIDEdit" runat="server" Text='<%# Bind("GenreID") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvGenreIDEdit" runat="server" Text="*" ErrorMessage="Genre is required" ControlToValidate="txtGenreIDEdit" ValidationGroup="Edit"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator3Edit" runat="server" Display="Dynamic" ErrorMessage="That Genre Type does not exist" ValidationGroup="Edit"  ControlToValidate="txtGenreIDEdit" ValidationExpression="^[1-7]{1}$"></asp:RegularExpressionValidator>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("GenreID") %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle Width="75px" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="DiskName" SortExpression="DiskName">
                    <EditItemTemplate>
                        <asp:TextBox ID="txtDiskNameEdit" runat="server" Text='<%# Bind("DiskName") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvDiskNameEdit" runat="server" Text="*" ErrorMessage="Disk Name is required" ControlToValidate="txtDiskNameEdit" ValidationGroup="Edit"></asp:RequiredFieldValidator>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label4" runat="server" Text='<%# Bind("DiskName") %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle Width="250px" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="ReleasedDate" SortExpression="ReleasedDate">
                    <EditItemTemplate>
                        <asp:TextBox ID="txtReleasedDateEdit" TextMode="Date" runat="server" Text='<%# Bind("ReleasedDate", "{0:yyyy-MM-dd}") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvReleasedDateEdit" runat="server" Text="*" ErrorMessage="Released Date is required" ControlToValidate="txtReleasedDateEdit" ValidationGroup="Edit" ></asp:RequiredFieldValidator>
                        <asp:CompareValidator id="dateValidatorEdit" runat="server" Type="Date" Display="Dynamic" Operator="DataTypeCheck" ControlToValidate="txtReleasedDateEdit" ValidationGroup="Edit" ErrorMessage="Please enter a valid date."></asp:CompareValidator>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label5" runat="server" Text='<%# Bind("ReleasedDate", "{0:yyyy-MM-dd}") %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle Width="100px" />
                </asp:TemplateField>
                <asp:CommandField ButtonType="Button" ShowEditButton="True" ValidationGroup="Edit"/>
                <asp:CommandField ButtonType="Button" ShowDeleteButton="True" />
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
        <asp:ValidationSummary ID="ValidationSummary1" runat="server"
            HeaderText="Please correct the following errors:" 
            ValidationGroup="Edit" CssClass="text-danger" />  

<%--            The datasource allows for connection to the database and allows for us to add edit and delete from the Disks table--%>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DiskInventoryConnectionString2 %>" SelectCommand="SELECT [DiskID], [DiskTypeID], [DiskStatusID], [GenreID], [DiskName], [ReleasedDate] FROM [Disks]" DeleteCommand="DELETE FROM [Disks] WHERE [DiskID] = @DiskID" InsertCommand="INSERT INTO [Disks] ([DiskTypeID], [DiskStatusID], [GenreID], [DiskName], [ReleasedDate]) VALUES (@DiskTypeID, @DiskStatusID, @GenreID, @DiskName, @ReleasedDate)" UpdateCommand="UPDATE [Disks] SET [DiskTypeID] = @DiskTypeID, [DiskStatusID] = @DiskStatusID, [GenreID] = @GenreID, [DiskName] = @DiskName, [ReleasedDate] = @ReleasedDate WHERE [DiskID] = @DiskID">
            <DeleteParameters>
                <asp:Parameter Name="DiskID" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="DiskTypeID" Type="Int32" />
                <asp:Parameter Name="DiskStatusID" Type="Int32" />
                <asp:Parameter Name="GenreID" Type="Int32" />
                <asp:Parameter Name="DiskName" Type="String" />
                <asp:Parameter Name="ReleasedDate" Type="DateTime" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="DiskTypeID" Type="Int32" />
                <asp:Parameter Name="DiskStatusID" Type="Int32" />
                <asp:Parameter Name="GenreID" Type="Int32" />
                <asp:Parameter Name="DiskName" Type="String" />
                <asp:Parameter Name="ReleasedDate" Type="DateTime" />
                <asp:Parameter Name="DiskID" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server"></asp:SqlDataSource>

        <div style=" width:50%; margin-left:auto; margin-right:auto;">
<%--        The detail view is for the insert of a Disk, It is only for the insert so the default mode is insert--%>
            <asp:DetailsView ID="DetailsView1" runat="server"
                AutoGenerateRows="False" DataSourceID="SqlDataSource2"
                DefaultMode="Insert" AutoPostBack="true">
                <HeaderTemplate>
                    <p style="font-size:20px;font-style:italic">To Add a new Disk, enter the information 
                        and click insert</p>
                </HeaderTemplate>
                <HeaderStyle CssClass="bg-info"/>
                <Fields>
                    <asp:BoundField DataField="DiskID" HeaderText="DiskID" InsertVisible="False" ReadOnly="True" SortExpression="DiskID" />
                    <asp:TemplateField HeaderText="DiskTypeID" SortExpression="DiskTypeID">
                        <InsertItemTemplate>
                            <asp:TextBox ID="txtDiskTypeID" runat="server" Text='<%# Bind("DiskTypeID") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvDiskTypeID" runat="server" Text="*" ErrorMessage="Disk Type is required" ControlToValidate="txtDiskTypeID" ValidationGroup="Insert"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" Display="Dynamic" ErrorMessage="Must be either 1 for CD or 2 for DVD" ValidationGroup="Insert"  ControlToValidate="txtDiskTypeID" ValidationExpression="^[1-2]{1}$"></asp:RegularExpressionValidator>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="DiskStatusID" SortExpression="DiskStatusID">
                        <InsertItemTemplate>
                            <asp:TextBox ID="txtDiskStatusID" runat="server" Text='<%# Bind("DiskStatusID") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvDiskStatusID" runat="server" Text="*" ErrorMessage="Disk Status is required" ControlToValidate="txtDiskStatusID" ValidationGroup="Insert"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" Display="Dynamic" ErrorMessage="Must be either 1 for available or 2 for unavailable" ValidationGroup="Insert"  ControlToValidate="txtDiskTypeID" ValidationExpression="^[1-2]{1}$"></asp:RegularExpressionValidator>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="GenreID" SortExpression="GenreID">
                        <InsertItemTemplate>
                            <asp:TextBox ID="txtGenreID" runat="server" Text='<%# Bind("GenreID") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvGenreID" runat="server" Text="*" ErrorMessage="Genre is required" ControlToValidate="txtGenreID" ValidationGroup="Insert"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" Display="Dynamic" ErrorMessage="That Genre Type does not exist" ValidationGroup="Insert"  ControlToValidate="txtGenreID" ValidationExpression="^[1-7]{1}$"></asp:RegularExpressionValidator>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="DiskName" SortExpression="DiskName">
                        <InsertItemTemplate>
                            <asp:TextBox ID="txtDiskName" runat="server" Text='<%# Bind("DiskName") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvDiskName" runat="server" Text="*" ErrorMessage="Disk Name is required" ControlToValidate="txtDiskName" ValidationGroup="Insert"></asp:RequiredFieldValidator>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="ReleasedDate" SortExpression="ReleasedDate">
                        <InsertItemTemplate>
                            <asp:TextBox ID="txtReleasedDate" runat="server" Text='<%# Bind("ReleasedDate") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvReleasedDate" runat="server" Text="*" ErrorMessage="Released Date is required" ControlToValidate="txtReleasedDate" ValidationGroup="Insert" ></asp:RequiredFieldValidator>
                            <asp:CompareValidator id="dateValidator" runat="server" Type="Date" Display="Dynamic" Operator="DataTypeCheck" ControlToValidate="txtReleasedDate" ErrorMessage="Please enter a valid date."></asp:CompareValidator>
                            </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:CommandField CancelText="Refresh" ShowInsertButton="True" ValidationGroup="Insert"/>
                </Fields>
            </asp:DetailsView>
            <%--The validation summary takes all the validations with the group of insert and puts those errorMessages in one place--%>
                <asp:ValidationSummary ID="ValidationSummary2" runat="server"
                    HeaderText="Please correct the following errors:" 
                    ValidationGroup="Insert" CssClass="text-danger" />  
        </div>


    </div>
</form>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footerPlaceHolder" Runat="Server">
</asp:Content>

