using System;
using System.Collections.Generic;
using System.Text;
using System.Web;
using System.Web.Security;
using System.Web.UI.WebControls;
using DotNetCasClient;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        HttpCookie ticketCookie = Request.Cookies[FormsAuthentication.FormsCookieName];
        if (ticketCookie != null)
        {
            if (!string.IsNullOrEmpty(ticketCookie.Value))
            {
                FormsAuthenticationTicket ticket = FormsAuthentication.Decrypt(ticketCookie.Value);

                if (CasAuthentication.ServiceTicketManager != null)
                {
                    CasAuthenticationTicket casTicket = CasAuthentication.ServiceTicketManager.GetTicket(ticket.UserData);
                    if (casTicket != null)
                    {
                        CasNetId.Text = casTicket.NetId;
                        CasServiceTicket.Text = casTicket.ServiceTicket;
                        CasOriginatingServiceName.Text = casTicket.OriginatingServiceName;
                        CasClientHostAddress.Text = casTicket.ClientHostAddress;
                        CasValidFromDate.Text = casTicket.ValidFromDate.ToString();
                        CasValidUntilDate.Text = casTicket.ValidUntilDate.ToString();
                    }
                }
            }
        }
    }
}