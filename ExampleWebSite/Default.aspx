<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
   <title>CAS Client</title>
</head>
<body>
    <form id="form1" runat="server">
        <div class="body">
            <div class="innerBody">
                <div class="logout">
                    <asp:LoginStatus ID="LoginStatus1" runat="server" LogoutAction="Redirect" LogoutPageUrl="~/Default.aspx" />
                    <asp:LoginName ID="LoginName1" runat="server" />
                </div>

                <div class="left">

                    <table class="block" cellpadding="0" cellspacing="0">
                        <tr>
                            <th colspan="2">CAS Authentication Ticket</th>
                        </tr>
                        <tr>
                            <td width="25%">NetId</td>
                            <td>
                                <asp:Label ID="CasNetId" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td>Service Ticket</td>
                            <td>
                                <asp:Label ID="CasServiceTicket" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td>Originating Service Name</td>
                            <td>
                                <asp:Label ID="CasOriginatingServiceName" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td>Client Host Address</td>
                            <td>
                                <asp:Label ID="CasClientHostAddress" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td>Valid From Date</td>
                            <td>
                                <asp:Label ID="CasValidFromDate" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td>Valid Until Date</td>
                            <td>
                                <asp:Label ID="CasValidUntilDate" runat="server" />
                            </td>
                        </tr>
                    </table>
                </div>

            </div>
        </div>
    </form>
</body>
</html>
