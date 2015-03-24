<%@ Page Language="C#" Debug="true"%>
    <script language="c#" runat="server">     
        string savepath = @"c:\inetpub\wwwroot\images\sw\ad\page\";
        
        public void Page_Load()
        {
            System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
            try
            {
                System.Text.Encoding encoding = System.Text.Encoding.UTF8;
                Response.ContentEncoding = encoding;
                int formSize = Request.TotalBytes;
                byte[] formData = Request.BinaryRead(formSize);

                if (System.IO.Directory.Exists(savepath))
                {
                    //資料夾存在
                }
                else
                {
                    //新增資料夾
                    System.IO.Directory.CreateDirectory(savepath);
                }
                
                parseFile(HttpUtility.UrlDecode(Request.Headers["FileName"]),encoding.GetString(formData));
                
                if (HttpUtility.UrlDecode(Request.Headers["FileName"]).IndexOf(".zip") > 0)
                {
                    string sourceFile = savepath + HttpUtility.UrlDecode(Request.Headers["FileName"]);

                    System.Diagnostics.Process Process1 = new System.Diagnostics.Process();
                    Process1.StartInfo.FileName = "Winrar.exe";
                    Process1.StartInfo.CreateNoWindow = true;
                    Process1.StartInfo.Arguments = " x -o+ " + sourceFile + " " + sourceFile.Replace(".zip", "") + @"\";

                    Process1.Start();
                    if (Process1.HasExited)
                    {
                        int iExitCode = Process1.ExitCode;
                        if (iExitCode == 0)
                        {
                            Response.Write(iExitCode.ToString() + " 正常完成");
                        }
                        else
                        {
                            Response.Write(iExitCode.ToString() + " 有錯完成");
                        }
                    }
                }

            }
            catch (Exception e) {
                Response.Write(e.Message);
            }
        }
        public void parseFile(string filename,string data)
        {
            byte[] formData = Convert.FromBase64String(data.Substring(data.IndexOf("base64") + 7));
 
            System.IO.FileStream aax = new System.IO.FileStream(savepath + filename, System.IO.FileMode.OpenOrCreate);
            System.IO.BinaryWriter aay = new System.IO.BinaryWriter(aax);
            aay.Write(formData);
            aax.Close();
        }
        
        
    </script>
