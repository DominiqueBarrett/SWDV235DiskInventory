<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Artists.aspx.cs" Inherits="Artists" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
        <script src="Scripts/jquery-1.9.1.min.js"></script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainPlaceholder" Runat="Server">
    <form id="form1" runat="server">
                <%-- The grid view allows for Edits and Deletes to be made for specific Artist--%>

        <h1 style="font-size:50px;font-style:italic">Artist Table</h1>
        <div style=" width:50%; margin-left:auto; margin-right:auto;">
            <asp:GridView ID="grdArtist" runat="server" 
                AllowSorting="True" AutoGenerateColumns="False" 
                BackColor="#CCCCCC" BorderColor="#999999" 
                BorderStyle="Solid" BorderWidth="3px" 
                CellPadding="4" CellSpacing="2" 
                DataKeyNames="ArtistID" DataSourceID="SqlDataSource1" 
                ForeColor="Black" AllowPaging="True">
                <Columns>
                    <asp:BoundField DataField="ArtistID" HeaderText="ArtistID" InsertVisible="False" ReadOnly="True" SortExpression="ArtistID">
                        <ItemStyle Width="75px" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="ArtistTypeID" SortExpression="ArtistTypeID">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtArtistTypeIDEdit" runat="server" Text='<%# Bind("ArtistTypeID") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvArtistEdit" runat="server" Text="*" ErrorMessage="Artist Type is required" ControlToValidate="txtArtistTypeIDEdit" ValidationGroup="Edit"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1Edit" runat="server" Display="Dynamic" ErrorMessage="Must be either 1 for group artist or 2 for solo artist" ValidationGroup="Edit"  ControlToValidate="txtArtistTypeIDEdit" ValidationExpression="^[1-2]{1}$"></asp:RegularExpressionValidator>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("ArtistTypeID") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="100px" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="FirstName" SortExpression="FirstName">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtFirstNameEdit" runat="server" Text='<%# Bind("FirstName") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvFirstEdit" runat="server" Text="*" ErrorMessage="First Name is required" ControlToValidate="txtFirstNameEdit" ValidationGroup="Edit"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("FirstName") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="100px" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="LastName" SortExpression="LastName">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtLastNameEdit" runat="server" Text='<%# Bind("LastName") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvLastEdit" runat="server" Text="*" ErrorMessage="Last Name is required" ControlToValidate="txtLastNameEdit" ValidationGroup="Edit"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("LastName") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="100px" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="GroupName" SortExpression="GroupName">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtGroupNameEdit" runat="server" Text='<%# Bind("GroupName") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvGroupEdit" runat="server" Text="*" ErrorMessage="Group Name is required" ControlToValidate="txtGroupNameEdit" ValidationGroup="Edit"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label4" runat="server" Text='<%# Bind("GroupName") %>'></asp:Label>
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
            <asp:ValidationSummary ID="ValidationSummary1Edit" runat="server"
                HeaderText="Please correct the following errors:" 
                ValidationGroup="Edit" CssClass="text-danger" />  

<%--            The datasource allows for connection to the database and allows for us to add edit and delete from the artist table--%>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DiskInventoryConnectionString2 %>" DeleteCommand="DELETE FROM [Artist] WHERE [ArtistID] = @ArtistID" InsertCommand="INSERT INTO [Artist] ([ArtistTypeID], [FirstName], [LastName], [GroupName]) VALUES (@ArtistTypeID, @FirstName, @LastName, @GroupName)" SelectCommand="SELECT [ArtistID], [ArtistTypeID], [FirstName], [LastName], [GroupName] FROM [Artist]" UpdateCommand="UPDATE [Artist] SET [ArtistTypeID] = @ArtistTypeID, [FirstName] = @FirstName, [LastName] = @LastName, [GroupName] = @GroupName WHERE [ArtistID] = @ArtistID">
                <DeleteParameters>
                    <asp:Parameter Name="ArtistID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="ArtistTypeID" Type="Int32" />
                    <asp:Parameter Name="FirstName" Type="String" />
                    <asp:Parameter Name="LastName" Type="String" />
                    <asp:Parameter Name="GroupName" Type="String" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="ArtistTypeID" Type="Int32" />
                    <asp:Parameter Name="FirstName" Type="String" />
                    <asp:Parameter Name="LastName" Type="String" />
                    <asp:Parameter Name="GroupName" Type="String" />
                    <asp:Parameter Name="ArtistID" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <div style=" width:50%; margin-left:auto; margin-right:auto;">
<%--        The detail view is for the insert of a Artist, It is only for the insert so the default mode is insert--%>
                <asp:DetailsView ID="DetailsView1" runat="server" 
                    AutoGenerateRows="False" DataSourceID="SqlDataSource1"
                    DefaultMode="Insert" AutoPostBack="true">
                    <HeaderTemplate>
                        <p style="font-size:20px;font-style:italic">To Add a new Artist, enter the information 
                            and click insert</p>
                    </HeaderTemplate>
                    <HeaderStyle CssClass="bg-info"/>
                    <Fields>
                        <asp:BoundField DataField="ArtistID" HeaderText="ArtistID" InsertVisible="False" ReadOnly="True" SortExpression="ArtistID" />
                        <asp:TemplateField HeaderText="ArtistTypeID" SortExpression="ArtistTypeID">
                            <InsertItemTemplate>
                                <asp:TextBox ID="txtArtistType" runat="server" Text='<%# Bind("ArtistTypeID") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvArtist" runat="server" Text="*" ErrorMessage="Artist Type is required" ControlToValidate="txtArtistType" ValidationGroup="Insert"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" Display="Dynamic" ErrorMessage="Must be either 1 for group artist or 2 for solo artist" ValidationGroup="Insert"  ControlToValidate="txtArtistType" ValidationExpression="^[1-2]{1}$"></asp:RegularExpressionValidator>
                            </InsertItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="FirstName" SortExpression="FirstName">
                            <InsertItemTemplate>
                                <asp:TextBox ID="txtFirstName" runat="server" Text='<%# Bind("FirstName") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvFirst" runat="server" Text="*" ErrorMessage="First Name is required" ControlToValidate="txtFirstName" ValidationGroup="Insert"></asp:RequiredFieldValidator>
                            </InsertItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="LastName" SortExpression="LastName">
                            <InsertItemTemplate>
                                <asp:TextBox ID="txtLastName" runat="server" Text='<%# Bind("LastName") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvLast" runat="server" Text="*" ErrorMessage="Last Name is required" ControlToValidate="txtLastName" ValidationGroup="Insert"></asp:RequiredFieldValidator>
                            </InsertItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="GroupName" SortExpression="GroupName">
                            <InsertItemTemplate>
                                <asp:TextBox ID="txtGroupName" runat="server" Text='<%# Bind("GroupName") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvGroup" runat="server" Text="*" ErrorMessage="Group Name is required" ControlToValidate="txtGroupName" ValidationGroup="Insert"></asp:RequiredFieldValidator>

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

