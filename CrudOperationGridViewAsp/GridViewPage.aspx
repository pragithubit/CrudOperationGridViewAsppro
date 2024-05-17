<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GridViewPage.aspx.cs" Inherits="CrudOperationGridViewAsp.GridViewPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            width: 100%;
            
        }
        .auto-style2 {
            width: 231px;
            margin:auto;
        }
        .auto-style4{
            text-align:center;
            font-size:larger;
        }
        table{
            margin:auto;
            width:450px;
        }
    </style>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
</head>
<body>
    <form id="form1" runat="server">
        <div>
        </div>
            <table cellpadding="2">
                <tr>
                    <td class="auto-style4">Employee Details</td>
                </tr>
                <tr>
                    <td class="auto-style2">First Name</td>
                    <td>
                        <asp:TextBox ID="TextBox1" runat="server" Width="209px" ></asp:TextBox>
                        <asp:RequiredFieldValidator ValidationGroup="Submit" ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox1" ErrorMessage=" Enter F Name first  uppercase later" ForeColor="#ff0000" SetFocusOnError="true">*</asp:RequiredFieldValidator>
                    
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">Last Name</td>
                    <td>
                        <asp:TextBox ID="TextBox2" runat="server" Width="209px"></asp:TextBox>
                        <asp:RequiredFieldValidator ValidationGroup="Submit" ID="RequiredFieldValidator2" runat="server" ControlToValidate="TextBox2" ErrorMessage="Enter L Name" ForeColor="Red" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">Age </td>
                    <td>
                        <asp:TextBox ID="TextBox3" runat="server" Width="209px" TextMode="Number"></asp:TextBox>
                        <asp:RequiredFieldValidator ValidationGroup="Submit" ID="RequiredFieldValidator3" runat="server" ControlToValidate="TextBox3" ErrorMessage=" Enter Age" ForeColor="Red" SetFocusOnError="true">*</asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">Salary</td>
                    <td>
                        <asp:TextBox ID="TextBox4" runat="server" Width="209px" TextMode="Number"></asp:TextBox>
                        <asp:RequiredFieldValidator ValidationGroup="Submit" ID="RequiredFieldValidator4" runat="server"  ControlToValidate="TextBox4" ErrorMessage="Enter  Salary" ForeColor="Red" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">Mobileno</td>
                    <td>
                        <asp:TextBox ID="txtMobileno" runat="server" Width="209px"></asp:TextBox>
                      <asp:RequiredFieldValidator ValidationGroup="Submit" ID="RequiredFieldValidator5" runat="server"  ControlToValidate="txtMobileno" ErrorMessage="Enter  Mobileno" ForeColor="Red" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">
                        <asp:Button ValidationGroup="Submit" ID="btnSubmit" runat="server" BackColor="#33CC33" Text="Submit" Width="118px" OnClick="btnSubmit_Click"/>
                    </td>
                    <td>
                        <asp:Button ID="btnClear" runat="server" BackColor="#FF3300" Text="Clear" Width="118px" OnClick="btnClear_Click" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="IblMsg" runat="server"></asp:Label></td>
                </tr>
            </table>
        <div class="auto-style1">
            <asp:GridView ID="empGrid" runat="server" CssClass="table" OnRowDeleting="empGrid_RowDeleting" OnRowEditing="empGrid_RowEditing" OnRowCancelingEdit="empGrid_RowCancelingEdit" OnRowUpdating="empGrid_RowUpdating" DataKeyNames="EmpId" AutoGenerateColumns="false">
                
                <Columns>
                    <asp:BoundField HeaderText="EmpId" DataField="EmpId" ReadOnly="true" />
                    <asp:TemplateField HeaderText="FirstName">
                        <ItemTemplate>
                            <asp:Label runat="server" Text='<%# Eval("FirstName") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:Textbox ID="TextBox1" runat="server" Text='<%# Bind("FirstName") %>'></asp:Textbox>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    
                    <asp:TemplateField HeaderText="LastName">
                        <ItemTemplate>
                            <asp:Label runat="server" Text='<%# Eval("LastName") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                             <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("LastName") %>'></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    
                    <asp:TemplateField HeaderText="Age">
                        <ItemTemplate>
                            <asp:Label runat="server" Text='<%# Eval("Age") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("Age") %>'></asp:TextBox>
                        </EditItemTemplate>
                        
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Salary">
                        <ItemTemplate>
                            <asp:Label runat="server" Text='<%# Eval("Salary") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox4"  runat="server" Text='<%#Bind("Salary") %>'></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Mobileno">
                        <ItemTemplate>
                          <asp:Label runat="server" Text='<%# Eval("Mobileno") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtMobileno" runat="server" Text='<%# Bind("Mobileno") %>'></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:CommandField ShowDeleteButton="true" ControlStyle-CssClass="btn btn-danger" HeaderText="Remove Record" />
                    <asp:CommandField ShowEditButton="true" ControlStyle-CssClass="btn btn-primary" HeaderText="Edit Record" />
                </Columns>
            </asp:GridView>

            <tr>
                <td>
                    <asp:ValidationSummary ValidationGroup="Submit" ID="ValidationSummary1" BackColor="#ccff66" Font-Size="Larger" ForeColor="Red" runat="server" />
                </td>
            </tr>
        </div>
        
        
    </form>
</body>
</html>
