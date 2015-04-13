 <%@ Page Language="C#" Debug="true"%>
    <script language="c#" runat="server">     
        public class ParaIn
        {
            public string typea,id;
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
                    
                    string queryString="";
                    //清除資料
                    if (itemIn.id=="all"){
                    	queryString = @"SET QUOTED_IDENTIFIER OFF declare @cmd nvarchar(max)  
                    	delete loginhistory ";
                    }else{
                    	queryString = @"SET QUOTED_IDENTIFIER OFF declare @cmd nvarchar(max)  
                    	delete loginhistory where id=@id ";	
                    }
					
                    System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(queryString, connSource);
                    cmd.Parameters.AddWithValue("@id", itemIn.id);                    
                    
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
