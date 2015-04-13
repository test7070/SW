 <%@ Page Language="C#" Debug="true"%>
    <script language="c#" runat="server">     
        public class ParaIn
        {
            public int seq;
            public string field, sendtime;
            public string caseno, caseno2,cardno, po,miles,receivetime;
        }
        
        //連接字串   
        string DCConnectionString = "";   
        public void Page_Load()
        {
        	DCConnectionString = "Data Source=127.0.0.1,1799;Persist Security Info=True;User ID=sa;Password=artsql963;Database=" + HttpUtility.UrlDecode(Request.Headers["database"]);
            try
            {
                //參數
                System.Text.Encoding encoding = System.Text.Encoding.UTF8;
                Response.ContentEncoding = encoding;
                int formSize = Request.TotalBytes;
                byte[] formData = Request.BinaryRead(formSize);
                System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                var itemIn = serializer.Deserialize<ParaIn>(encoding.GetString(formData));
                //資料寫入
                
                System.Data.DataTable tranvcce = new System.Data.DataTable();
                using (System.Data.SqlClient.SqlConnection connSource = new System.Data.SqlClient.SqlConnection(DCConnectionString))
                {
                    System.Data.SqlClient.SqlDataAdapter adapter = new System.Data.SqlClient.SqlDataAdapter();
                    connSource.Open();
                    
                    //更新資料
                    string queryString = @"SET QUOTED_IDENTIFIER OFF declare @cmd nvarchar(max) 
                        update loginhistory
	                    set caseno=@caseno,caseno2=@caseno2,cardno=@cardno,po=@po,miles=@miles,receivetime=@receivetime
	                    where seq=@seq and field=@field and sendtime=@sendtime";
					";
                    System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(queryString, connSource);
                    cmd.Parameters.AddWithValue("@seq", itemIn.seq);
                    cmd.Parameters.AddWithValue("@field", itemIn.field);
                    cmd.Parameters.AddWithValue("@sendtime", itemIn.sendtime);
                    cmd.Parameters.AddWithValue("@caseno", itemIn.caseno);
                    cmd.Parameters.AddWithValue("@caseno2", itemIn.caseno2);
                    cmd.Parameters.AddWithValue("@cardno", itemIn.cardno);
                    cmd.Parameters.AddWithValue("@po", itemIn.po);
                    cmd.Parameters.AddWithValue("@miles", itemIn.miles);
                    cmd.Parameters.AddWithValue("@receivetime", itemIn.receivetime);
                    cmd.ExecuteNonQuery();
                    connSource.Close();
                }
                Response.Write("");
            }
            catch (Exception e) {
                Response.Write(e.Message);
            }
        }
       
    </script>
