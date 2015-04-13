 <%@ Page Language="C#" Debug="true"%>
    <script language="c#" runat="server">     
    	public void get_sess(){
            string a = "";
            foreach (string x in getOnlineUsers())
            {
                a = x+@",";
            }
            this.textSess.Value = a;
        }
        
        private System.Collections.Generic.List<String> getOnlineUsers()
        {
            System.Collections.Generic.List<String> activeSessions = new System.Collections.Generic.List<String>();
            object obj = typeof(HttpRuntime).GetProperty("CacheInternal", System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Static).GetValue(null, null);
            object[] obj2 = (object[])obj.GetType().GetField("_caches", System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Instance).GetValue(obj);
            for (int i = 0; i < obj2.Length; i++)
            {
                Hashtable c2 = (Hashtable)obj2[i].GetType().GetField("_entries", System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Instance).GetValue(obj2[i]);
                foreach (DictionaryEntry entry in c2)
                {
                    object o1 = entry.Value.GetType().GetProperty("Value", System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Instance).GetValue(entry.Value, null);
                    if (o1.GetType().ToString() == "System.Web.SessionState.InProcSessionState")
                    {
                        SessionStateItemCollection sess = (SessionStateItemCollection)o1.GetType().GetField("_sessionItems", System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Instance).GetValue(o1);
                        if (sess != null)
                        {
                            if (sess["USERID"] != null)
                            {
                                activeSessions.Add(sess["USERID"].ToString());
                            }
                        }
                    }
                }
            }
            return activeSessions;
        }
</script>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">

			var q_name = "loginhistory";
			aPop = new Array();
			function loginhistory() {}
			
            loginhistory.prototype = {
                data : null,
                tbCount : 15,
                curPage : -1,
                totPage : 0,
                curIndex : '',
                curCaddr : null,
                load : function(){
                    var string = "<table id='loginhistory_table' style='width:700px;'>";
                    string+='<tr id="loginhistory_header">';
                    string+='<td id="loginhistory_clear" align="center" style="width:55px;color:black;"></td>';
                    string+='<td id="loginhistory_id" onclick="loginhistory.sort(\'id\',false)" title="帳號" align="center" style="width:150px; color:black;">帳號</td>';
                    string+='<td id="loginhistory_ipaddress" onclick="loginhistory.sort(\'ipaddress\',false)" title="上線IP" align="center" style="width:150px; color:black;">上線IP</td>';
                    string+='<td id="loginhistory_datea" onclick="loginhistory.sort(\'datea\',false)" title="登入時間" align="center" style="color:black;">登入時間</td>';
                    string+='</tr>';
                    
                    var t_color = ['DarkBlue','DarkRed'];
                    for(var i=0;i<this.tbCount;i++){
                        string+='<tr id="loginhistory_tr'+i+'">';
                        string+='<td id="loginhistory_clear'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'"><input class="loginhistory_btn" id="btnClear_'+i+'" type="button" value="清除" style=" width: 50px;" /></td>';
                        string+='<td id="loginhistory_id'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'"></td>';
                        string+='<td id="loginhistory_ipaddress'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'"></td>';
                        string+='<td id="loginhistory_datea'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'"></td>';
                        string+='</tr>';
                    }
                    string+='</table>';
                    
                    $('#loginhistory').append(string);
                    string='';
                    //string+='<a style="float:left;">車號</a><input id="textCarno"  type="text" style="float:left;width:100px;"/>';
                    //string+='<a id="lblDriver" style="float:left;">司機編號</a><input id="textDriverno"  type="text" style="float:left;width:100px;"/>';
                    //string+='<a id="lblDriver" style="float:left;">司機姓名</a><input id="textDriver"  type="text" style="float:left;width:100px;"/>';
                    //string+='<input id="btnloginhistory_refresh"  type="button" style="float:left;width:100px;" value="任務刷新"/>';
                    string+='<input id="btnloginhistory_previous" onclick="loginhistory.previous()" type="button" style="float:left;width:100px;" value="上一頁"/>';
                    string+='<input id="btnloginhistory_next" onclick="loginhistory.next()" type="button" style="float:left;width:100px;" value="下一頁"/>';
                    string+='<input id="textCurPage" onchange="loginhistory.page(parseInt($(this).val()))" type="text" style="float:left;width:100px;text-align: right;"/>';
                    string+='<span style="float:left;display:block;width:10px;font-size: 25px;">/</span>';
                    string+='<input id="textTotPage"  type="text" readonly="readonly" style="float:left;width:100px;color:green;"/>';
                    $('#loginhistory_control').append(string);
                },
                init : function(obj) {
                    //清除
                    $('.loginhistory_btn').click(function(e) {
                        //顯示BBS的資料
                        var n=$(this).attr('id').replace('btnEnda_','')
                        loginhistory_n=n;
                        
                    });
                    
                    this.data = new Array();
                    if (obj[0] != undefined) {
                        for (var i in obj)
                            if (obj[i]['id'] != undefined ){
                                this.data.push(obj[i]);
                            }
                    }
                    
                    this.totPage = Math.ceil(this.data.length / this.tbCount);
                    $('#textTotPage').val(this.totPage);
                    this.sort('id', false);
                    Unlock();
                },
                sort : function(index, isFloat) {
                    this.curIndex = index;

                    if (isFloat) {
                        this.data.sort(function(a, b) {
                            var m = parseFloat(a[loginhistory.curIndex] == undefined ? "0" : a[loginhistory.curIndex]);
                            var n = parseFloat(b[loginhistory.curIndex] == undefined ? "0" : b[loginhistory.curIndex]);
                            if (m == n) {
                                if (a['id'] < b['id'])
                                    return 1;
                                if (a['id'] > b['id'])
                                    return -1;
                                return 0;
                            } else
                                return n - m;
                        });
                    } else {
                        this.data.sort(function(a, b) {
                            var m = a[loginhistory.curIndex] == undefined ? "" : a[loginhistory.curIndex];
                            var n = b[loginhistory.curIndex] == undefined ? "" : b[loginhistory.curIndex];
                            if (m == n) {
                                if (a['id'] < b['id'])
                                    return 1;
                                if (a['id'] > b['id'])
                                    return -1;
                                return 0;
                            } else {
                                if (m < n)
                                    return 1;
                                if (m > n)
                                    return -1;
                                return 0;
                            }
                        });
                    }
                    this.page(1);
                },
                next : function() {
                    if (this.curPage >= this.totPage) {
                        alert('最末頁。');
                        return;
                    }
                    this.curPage++;
                    $('#textCurPage').val(this.curPage);
                    this.refresh();
                },
                previous : function() {
                    if (this.curPage == 1) {
                        alert('最前頁。');
                        return;
                    }
                    this.curPage--;
                    $('#textCurPage').val(this.curPage);
                    this.refresh();
                },
                page : function(n) {
                    if (n <= 0 || n > this.totPage) {
                        this.curPage = 1;
                        $('#textCurPage').val(this.curPage);
                        this.refresh();
                        return;
                    }
                    this.curPage = n;
                    $('#textCurPage').val(this.curPage);
                    this.refresh();
                },
                refresh : function() {
                    //頁面更新
                    var n = (this.curPage - 1) * this.tbCount;
                    for (var i = 0; i < this.tbCount; i++) {
                        if ((n + i) < this.data.length) {
                        	$('#btnClear_' + i).removeAttr('disabled');
                            $('#loginhistory_id' + i).html(this.data[n+i]['id']);
                            $('#loginhistory_ipaddress' + i).html(this.data[n+i]['ipaddress']);
                            $('#loginhistory_datea' + i).html(this.data[n+i]['datea']);
                        } else {
                            $('#btnClear_' + i).attr('disabled', 'disabled');
                            $('#loginhistory_id' + i).text('');
                            $('#loginhistory_ipaddress' + i).text('');
                            $('#loginhistory_datea' + i).text('');
                        }
                    }
                }
            };
            loginhistory = new loginhistory();

			$(document).ready(function() {		
				_q_boxClose();
                q_getId();
                q_gf('', q_name);
                loginhistory.load();
			});
			
			var sess;
			function q_gfPost() {
				q_getFormat();
                q_langShow();
                q_popAssign();
                q_cur=2;
                <% get_sess(); %>
                t_where="where=^^1=1 ^^";
				q_gt('loginhistory', t_where, 0, 0, 0,'loginhistory_init', r_accy);
            }
            
			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
				b_pop = '';
			}
			
			var mouse_point;
			var loginhistory_n='';//目前loginhistory的列數
			function q_gtPost(t_name) {
				switch (t_name) {
                    case 'loginhistory_init':
                        var as = _q_appendData("loginhistory", "", true);
                        loginhistory.init(as);
                        if (as[0] == undefined){
                            Unlock();
                            alert('無會員登入資料。');
                        }
                        break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
					default:
                        break;
				}
			}
			
			function q_funcPost(t_func, result) {
                switch(t_func) {
                	
                }
			}
			
		</script>
		<style type="text/css">
			#dmain {
				overflow: hidden;
			}
			.dview {
				float: left;
				width: 98%;
			}
			.tview {
				margin: 0;
				padding: 2px;
				border: 1px black double;
				border-spacing: 0;
				font-size: medium;
				background-color: #FFFF66;
				color: blue;
			}
			.tview td {
				padding: 2px;
				text-align: center;
				border: 1px black solid;
			}
			.dbbm {
				float: left;
				width: 98%;
				margin: -1px;
				border: 1px black solid;
				border-radius: 5px;
			}
			.tbbm {
				padding: 0px;
				border: 1px white double;
				border-spacing: 0;
				border-collapse: collapse;
				font-size: medium;
				color: blue;
				background: #cad3ff;
				width: 100%;
			}
			.tbbm tr {
				height: 35px;
			}
			.tbbm tr td {
				width: 9%;
			}
			.tbbm .tdZ {
				width: 2%;
			}
			.tbbm tr td span {
				float: right;
				display: block;
				width: 5px;
				height: 10px;
			}
			.tbbm tr td .lbl {
				float: right;
				color: blue;
				font-size: medium;
			}
			.tbbm tr td .lbl.btn {
				color: #4297D7;
				font-weight: bolder;
				font-size: medium;
			}
			.tbbm tr td .lbl.btn:hover {
				color: #FF8F19;
			}
			.txt.c1 {
				width: 98%;
				float: left;
			}
			.txt.c2 {
				width: 38%;
				float: left;
			}
			.txt.c3 {
				width: 60%;
				float: left;
			}
			.txt.num {
				text-align: right;
			}
			.tbbm td {
				margin: 0 -1px;
				padding: 0;
			}
			.tbbm td input[type="text"] {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
				float: left;
			}
			.tbbm select {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
				font-size: medium;
			}

			input[type="text"], input[type="button"] {
				font-size: medium;
			}
			.dbbs .tbbs {
				margin: 0;
				padding: 2px;
				border: 2px lightgrey double;
				border-spacing: 1px;
				border-collapse: collapse;
				font-size: medium;
				color: blue;
				background: #cad3ff;
				width: 100%;
			}
			.dbbs .tbbs tr {
				height: 35px;
			}
			.dbbs .tbbs tr td {
				text-align: center;
				border: 2px lightgrey double;
			}
			#loginhistory_table {
                border: 5px solid gray;
                font-size: medium;
                background-color: white;
            }
            #loginhistory_table tr {
                height: 30px;
            }
            #loginhistory_table td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                background-color: pink;
                color: blue;
            }
            #loginhistory_header td:hover{
                background : yellow;
                cursor : pointer;
            }
		</style>
	</head>
	<body>
		<div id='q_menu'> </div>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type='button' id='btnAuthority' name='btnAuthority' style='font-size:16px;' value='權限'/>
		<p> </p>
		<div id="loginhistory" style="float:left;width:1260px;"> </div> 
		<p style="float: left;width: 1260px;"> </p>
		<div id="loginhistory_control" style="width:1200px;"> </div> 
		<input id="textSess" type="hidden" class="txt c1" value="" runat="server"/>
	</body>
</html>