 <%@ Page Language="C#" Debug="true"%>
  <%@ import Namespace="System.Web.Script.Serialization"%>
	<%@ import Namespace="System.Net.Mail"%>
	<%@ import Namespace="System.Security.Cryptography.X509Certificates"%>
    <script language="c#" runat="server">     
        string connString;
        System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
        
        public class ParaIn {
            public string subject;
            public string contents;
            public string emailaddr;
        }

        public static bool ValidateServerCertificate(System.Object sender, X509Certificate certificate, X509Chain chain, System.Net.Security.SslPolicyErrors sslPolicyErrors)
        {
            return true;
        }

        public string email_send(string subject, string body, string mailto)
        {
            // 這段一定要, 要寫這個才可以跳過 "根據驗證程序,遠端憑證是無效的" 的錯誤
            System.Net.ServicePointManager.ServerCertificateValidationCallback =
                new System.Net.Security.RemoteCertificateValidationCallback(ValidateServerCertificate);

            string t_from = "service@steelworld.com.tw", t_passwd = "steel321";
            //string t_from = "test@dachang.com.tw", t_passwd = "";
            System.Net.Mail.MailMessage mail;
            System.Net.Mail.SmtpClient SmtpServer;
            try
            {
                mail = new System.Net.Mail.MailMessage();
                SmtpServer = new System.Net.Mail.SmtpClient("mail.steelworld.com.tw");
                //SmtpServer = new SmtpClient("dachang.com.tw");
                mail.From = new System.Net.Mail.MailAddress(t_from, "Steelworld全球鋼訊網");
                mail.IsBodyHtml = true;
                mail.Subject = subject;
                mail.Body = body;
                mail.To.Add(mailto);

                //SmtpServer.Port = 587;
                SmtpServer.Port = 25;
                SmtpServer.Credentials = new System.Net.NetworkCredential(t_from, t_passwd);
                SmtpServer.EnableSsl = false;

                SmtpServer.Send(mail);
            }
            catch (System.Exception e)
            {
                return e.Message;
            }
            finally
            {
                SmtpServer = null;
                mail = null;
            }
            return "";
        }
        
        public void Page_Load()
        {
            System.Text.Encoding encoding = System.Text.Encoding.UTF8;
            Response.ContentEncoding = encoding;

            int formSize = Request.TotalBytes;
            byte[] formData = Request.BinaryRead(formSize);
            System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
            var itemIn = serializer.Deserialize<ParaIn>(encoding.GetString(formData));


            email_send(itemIn.subject, itemIn.contents, itemIn.emailaddr);
        } 
      
    </script>