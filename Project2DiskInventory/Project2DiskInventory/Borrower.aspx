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
<asp:Content ID="Content2" ContentPlaceHolderID="MainPlaceholder" Runat="Server">
    <form runat="server">
        <p style="font-size: 20px;">
            Please fill out this form in order to become a Borrower.
        </p>
        <table style="margin-left:auto; margin-right: auto;">
                <tr>
                <td><label>First Name:&nbsp;</label></td>
                <td>
                    <asp:TextBox ID="txtFirstName" runat="server" AutoPostBack="True" class="textbox" OnTextChanged="txtFirstName_TextChanged"></asp:TextBox>
                </td>
                <td>
                    <asp:Label ID="lblFirstNameError" runat="server" Text="" class="errorMesssage"></asp:Label>

                </td>
                </tr>
                <tr>
                <td><label>Last Name:&nbsp;&nbsp;</label></td>
                <td>
                    <asp:TextBox ID="txtLastName" runat="server" AutoPostBack="True" Class="textbox" OnTextChanged="txtLastName_TextChanged"></asp:TextBox>
                    <br/>
                </td>
                <td>
                    <asp:Label ID="lblLastNameError" runat="server" Text="" class="errorMesssage"></asp:Label>
                </td>
                </tr>
                <tr>
                <td><label>Phone Number:&nbsp;&nbsp;</label></td>
                <td>
                    <asp:TextBox ID="txtPhoneNumber" runat="server" AutoPostBack="True" Class="textbox" OnTextChanged="txtPhoneNumber_TextChanged"></asp:TextBox>
                    <br/>
                </td>
                <td>
                    <asp:Label ID="lblPhoneNumber" runat="server" Text="" class="errorMesssage"></asp:Label>
                </td>
                </tr>
                <tr>
                <td></td>
                <td>
                    <%--The Submit has an OnClick event that will trigger all the validations calls--%>
                    <asp:Button ID="newsLetterSubmit" runat="server" Text="Submit" OnClick="newsLetterSubmit_Click" />
                    <br/></td>
                </tr>
        </table>
    </form>
    <asp:Label ID="lblCompleteMessage" runat="server" Text=""></asp:Label>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footerPlaceHolder" Runat="Server">
</asp:Content>

