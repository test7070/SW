 <%@ Page Language="C#" Debug="true"%>
    <script language="c#" runat="server">     
    	public void get_sess(){
            string a = "";
            foreach (string x in getOnlineUsers())
            {
                a =a+x+@",";
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
			function custslogin() {};
			
            custslogin.prototype = {
                data : null,
                tbCount : 15,
                curPage : -1,
                totPage : 0,
                curIndex : '',
                curCaddr : null,
                load : function(){
                    var string = "<table id='custslogin_table'>";
                    string+='<tr id="custslogin_header">';
                    string+='<td id="custslogin_clear" align="center" style="width:55px;color:black;"></td>';
                    string+='<td id="custslogin_id" onclick="custslogin.sort(\'id\',false)" title="帳號" align="center" style="width:190px; color:black;">帳號</td>';
                    string+='<td id="custslogin_ipaddress" onclick="custslogin.sort(\'ipaddress\',false)" title="上線IP" align="center" style="width:190px; color:black;">上線IP</td>';
                    string+='<td id="custslogin_datea" onclick="custslogin.sort(\'datea\',false)" title="登入時間" align="center" style="width:190px;color:black;">登入時間</td>';
                    string+='</tr>';
                    
                    var t_color = ['DarkBlue','DarkRed'];
                    for(var i=0;i<this.tbCount;i++){
                        string+='<tr id="custslogin_tr'+i+'">';
                        string+='<td id="custslogin_clear'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'"><input class="custslogin_btn" id="btnLoginClear_'+i+'" type="button" value="清除" style=" width: 50px;" /></td>';
                        string+='<td id="custslogin_id'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'"></td>';
                        string+='<td id="custslogin_ipaddress'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'"></td>';
                        string+='<td id="custslogin_datea'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'"></td>';
                        string+='</tr>';
                    }
                    string+='</table>';
                    
                    $('#custslogin').append(string);
                    string='';
                    string+='<input id="btncustslogin_previous" onclick="custslogin.previous()" type="button" style="float:left;width:100px;" value="上一頁"/>';
                    string+='<input id="btncustslogin_next" onclick="custslogin.next()" type="button" style="float:left;width:100px;" value="下一頁"/>';
                    string+='<input id="textLoginCurPage" onchange="custslogin.page(parseInt($(this).val()))" type="text" style="float:left;width:100px;text-align: right;"/>';
                    string+='<span style="float:left;display:block;width:10px;font-size: 25px;">/</span>';
                    string+='<input id="textLoginTotPage"  type="text" readonly="readonly" style="float:left;width:100px;color:green;"/>';
                    $('#custslogin_control').append(string);
                },
                init : function(obj) {
                    //清除
                    $('.custslogin_btn').click(function(e) {
                        //顯示BBS的資料
                        var n=$(this).attr('id').replace('btnLoginClear_','')
                        custslogin_n=n;
                        
                        if($('#custslogin_id'+n).text()=='')
							return;
						
						if(!confirm("確定要刪除帳號【"+$('#custslogin_id'+n).text()+"】的登入資訊?"))
							return;
                        
                        var datea=[];
						datea[0]={
							typea:'single',
							id:$('#custslogin_id'+n).text()
						}
						
						Lock(1,{opacity:0});
						$.ajax({
		                    url: 'loginhistory_update.aspx',
		                    headers: { 'database': q_db },
		                    type: 'POST',
		                    data: JSON.stringify(datea[0]),
		                    dataType: 'text',
		                    timeout: 10000,
		                    success: function(data){
		                        if(data.length>0){
		                        	alert(data)
		                        }
		                        //重新載入資料
		                    	t_where="where=^^exists (select * from custt where id=a.id and '"+q_date()+"' between bdate and edate) ^^";
								q_gt('custs_login', t_where, 0, 0, 0,'custslogin_init', r_accy);
		                    },
		                    complete: function(){ 
		                    	Unlock(1);
		                    },
		                    error: function(jqXHR, exception) {
		                        var errmsg = this.url+'資料清除異常。\n';
		                        if (jqXHR.status === 0) {
		                            alert(errmsg+'Not connect.\n Verify Network.');
		                        } else if (jqXHR.status == 404) {
		                            alert(errmsg+'Requested page not found. [404]');
		                        } else if (jqXHR.status == 500) {
		                            alert(errmsg+'Internal Server Error [500].');
		                        } else if (exception === 'parsererror') {
		                            alert(errmsg+'Requested JSON parse failed.');
		                        } else if (exception === 'timeout') {
		                            alert(errmsg+'Time out error.');
		                        } else if (exception === 'abort') {
		                            alert(errmsg+'Ajax request aborted.');
		                        } else {
		                            alert(errmsg+'Uncaught Error.\n' + jqXHR.responseText);
		                        }
		                    }
		                });
                    });
                    
                    this.data = new Array();
                    if (obj[0] != undefined) {
                        for (var i in obj)
                            if (obj[i]['id'] != undefined ){
                                this.data.push(obj[i]);
                            }
                    }
                    
                    this.totPage = Math.ceil(this.data.length / this.tbCount);
                    $('#textLoginTotPage').val(this.totPage);
                    this.sort('id', false);
                    Unlock();
                },
                sort : function(index, isFloat) {
                    this.curIndex = index;

                    if (isFloat) {
                        this.data.sort(function(a, b) {
                            var m = parseFloat(a[custslogin.curIndex] == undefined ? "0" : a[custslogin.curIndex]);
                            var n = parseFloat(b[custslogin.curIndex] == undefined ? "0" : b[custslogin.curIndex]);
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
                            var m = a[custslogin.curIndex] == undefined ? "" : a[custslogin.curIndex];
                            var n = b[custslogin.curIndex] == undefined ? "" : b[custslogin.curIndex];
                            if (m == n) {
                                if (a['id'] > b['id'])
                                    return 1;
                                if (a['id'] < b['id'])
                                    return -1;
                                return 0;
                            } else {
                                if (m > n)
                                    return 1;
                                if (m < n)
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
                    $('#textLoginCurPage').val(this.curPage);
                    this.refresh();
                },
                previous : function() {
                    if (this.curPage == 1) {
                        alert('最前頁。');
                        return;
                    }
                    this.curPage--;
                    $('#textLoginCurPage').val(this.curPage);
                    this.refresh();
                },
                page : function(n) {
                    if (n <= 0 || n > this.totPage) {
                        this.curPage = 1;
                        $('#textLoginCurPage').val(this.curPage);
                        this.refresh();
                        return;
                    }
                    this.curPage = n;
                    $('#textLoginCurPage').val(this.curPage);
                    this.refresh();
                },
                refresh : function() {
                    //頁面更新
                    var n = (this.curPage - 1) * this.tbCount;
                    for (var i = 0; i < this.tbCount; i++) {
                        if ((n + i) < this.data.length) {
                        	$('#btnLoginClear_' + i).removeAttr('disabled');
                            $('#custslogin_id' + i).html(this.data[n+i]['id']);
                            $('#custslogin_ipaddress' + i).html(this.data[n+i]['ipaddress']);
                            if(this.data[n+i]['datea']==''){
                            	$('#custslogout_datea' + i).html('');
                            }else{
	                            var t_date=new Date(this.data[n+i]['datea']);
	                            $('#custslogin_datea' + i).html(t_date.getFullYear()+'-'
	                            											+('00'+(t_date.getMonth()+1)).substr(-2)+'-'
	                            											+('00'+t_date.getDate()).substr(-2)+' '
	                            											+('00'+t_date.getHours()).substr(-2)+':'+('00'+t_date.getMinutes()).substr(-2));
							}
                        } else {
                            $('#btnLoginClear_' + i).attr('disabled', 'disabled');
                            $('#custslogin_id' + i).text('');
                            $('#custslogin_ipaddress' + i).text('');
                            $('#custslogin_datea' + i).text('');
                        }
                    }
                }
            };
            
            function custslogout() {};
            custslogout.prototype = {
                data : null,
                tbCount : 15,
                curPage : -1,
                totPage : 0,
                curIndex : '',
                curCaddr : null,
                load : function(){
                    var string = "<table id='custslogout_table'>";
                    string+='<tr id="custslogout_header">';
                    string+='<td id="custslogout_clear" align="center" style="width:55px;color:black;"></td>';
                    string+='<td id="custslogout_id" onclick="custslogout.sort(\'id\',false)" title="帳號" align="center" style="width:190px; color:black;">帳號</td>';
                    string+='<td id="custslogout_status" onclick="custslogout.sort(\'status\',false)" title="狀態" align="center" style="width:190px; color:black;">狀態</td>';
                    string+='<td id="custslogout_datea" onclick="custslogout.sort(\'datea\',false)" title="離線時間" align="center" style="width:190px;color:black;">離線時間</td>';
                    string+='</tr>';
                    
                    var t_color = ['DarkBlue','DarkRed'];
                    for(var i=0;i<this.tbCount;i++){
                        string+='<tr id="custslogout_tr'+i+'">';
                        string+='<td id="custslogout_clear'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'"><input class="custslogout_btn" id="btnLogoutClear_'+i+'" type="button" value="清除" style=" width: 50px;" /></td>';
                        string+='<td id="custslogout_id'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'"></td>';
                        string+='<td id="custslogout_status'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'"></td>';
                        string+='<td id="custslogout_datea'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'"></td>';
                        string+='</tr>';
                    }
                    string+='</table>';
                    
                    $('#custslogout').append(string);
                    string='';
                    string+='<input id="btnCustslogout_previous" onclick="custslogout.previous()" type="button" style="float:left;width:100px;" value="上一頁"/>';
                    string+='<input id="btnCustslogout_next" onclick="custslogout.next()" type="button" style="float:left;width:100px;" value="下一頁"/>';
                    string+='<input id="textLogoutCurPage" onchange="custslogout.page(parseInt($(this).val()))" type="text" style="float:left;width:100px;text-align: right;"/>';
                    string+='<span style="float:left;display:block;width:10px;font-size: 25px;">/</span>';
                    string+='<input id="textLogoutTotPage"  type="text" readonly="readonly" style="float:left;width:100px;color:green;"/>';
                    $('#custslogout_control').append(string);
                },
                init : function(obj) {
                    //清除
                    $('.custslogout_btn').click(function(e) {
                        //顯示BBS的資料
                        var n=$(this).attr('id').replace('btnLogoutClear_','')
                        custslogout_n=n;
                        
                        if($('#custslogout_id'+n).text()=='')
							return;
						
						if(!confirm("確定要刪除帳號【"+$('#custslogout_id'+n).text()+"】的登入資訊?"))
							return;
                        
                        var datea=[];
						datea[0]={
							typea:'single',
							id:$('#custslogout_id'+n).text()
						}
						
						Lock(1,{opacity:0});
						$.ajax({
		                    url: 'loginhistory_update.aspx',
		                    headers: { 'database': q_db },
		                    type: 'POST',
		                    data: JSON.stringify(datea[0]),
		                    dataType: 'text',
		                    timeout: 10000,
		                    success: function(data){
		                        if(data.length>0){
		                        	alert(data)
		                        }
		                        //重新載入資料
		                    	t_where="where=^^exists (select * from custt where id=a.id and '"+q_date()+"' between bdate and edate) ^^";
								q_gt('custs_login', t_where, 0, 0, 0,'custslogin_init', r_accy);
		                    },
		                    complete: function(){ 
		                    	Unlock(1);
		                    },
		                    error: function(jqXHR, exception) {
		                        var errmsg = this.url+'資料清除異常。\n';
		                        if (jqXHR.status === 0) {
		                            alert(errmsg+'Not connect.\n Verify Network.');
		                        } else if (jqXHR.status == 404) {
		                            alert(errmsg+'Requested page not found. [404]');
		                        } else if (jqXHR.status == 500) {
		                            alert(errmsg+'Internal Server Error [500].');
		                        } else if (exception === 'parsererror') {
		                            alert(errmsg+'Requested JSON parse failed.');
		                        } else if (exception === 'timeout') {
		                            alert(errmsg+'Time out error.');
		                        } else if (exception === 'abort') {
		                            alert(errmsg+'Ajax request aborted.');
		                        } else {
		                            alert(errmsg+'Uncaught Error.\n' + jqXHR.responseText);
		                        }
		                    }
		                });
                    });
                    
                    this.data = new Array();
                    if (obj[0] != undefined) {
                        for (var i in obj)
                            if (obj[i]['id'] != undefined ){
                                this.data.push(obj[i]);
                            }
                    }
                    
                    this.totPage = Math.ceil(this.data.length / this.tbCount);
                    $('#textLogoutTotPage').val(this.totPage);
                    this.sort('id', false);
                    Unlock();
                },
                sort : function(index, isFloat) {
                    this.curIndex = index;

                    if (isFloat) {
                        this.data.sort(function(a, b) {
                            var m = parseFloat(a[custslogout.curIndex] == undefined ? "0" : a[custslogout.curIndex]);
                            var n = parseFloat(b[custslogout.curIndex] == undefined ? "0" : b[custslogout.curIndex]);
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
                            var m = a[custslogout.curIndex] == undefined ? "" : a[custslogout.curIndex];
                            var n = b[custslogout.curIndex] == undefined ? "" : b[custslogout.curIndex];
                            if (m == n) {
                                if (a['id'] > b['id'])
                                    return 1;
                                if (a['id'] < b['id'])
                                    return -1;
                                return 0;
                            } else {
                                if (m > n)
                                    return 1;
                                if (m < n)
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
                    $('#textLogoutCurPage').val(this.curPage);
                    this.refresh();
                },
                previous : function() {
                    if (this.curPage == 1) {
                        alert('最前頁。');
                        return;
                    }
                    this.curPage--;
                    $('#textLogoutCurPage').val(this.curPage);
                    this.refresh();
                },
                page : function(n) {
                    if (n <= 0 || n > this.totPage) {
                        this.curPage = 1;
                        $('#textLogoutCurPage').val(this.curPage);
                        this.refresh();
                        return;
                    }
                    this.curPage = n;
                    $('#textLogoutCurPage').val(this.curPage);
                    this.refresh();
                },
                refresh : function() {
                    //頁面更新
                    var n = (this.curPage - 1) * this.tbCount;
                    for (var i = 0; i < this.tbCount; i++) {
                        if ((n + i) < this.data.length) {
                        	$('#btnLogoutClear_' + i).removeAttr('disabled');
                            $('#custslogout_id' + i).html(this.data[n+i]['id']);
                            //$('#custslogout_ipaddress' + i).html(this.data[n+i]['ipaddress']);
                            if(this.data[n+i]['datea']==''){
                            	$('#custslogout_datea' + i).html('');
                            }else{
	                            var t_date=new Date(this.data[n+i]['datea']);
	                            $('#custslogout_datea' + i).html(t_date.getFullYear()+'-'
	                            											+('00'+(t_date.getMonth()+1)).substr(-2)+'-'
	                            											+('00'+t_date.getDate()).substr(-2)+' '
	                            											//+('00'+t_date.getHours()).substr(-2)+':'+('00'+t_date.getMinutes()).substr(-2)
	                            											);
							}
                        } else {
                            $('#btnLogoutClear_' + i).attr('disabled', 'disabled');
                            $('#custslogout_id' + i).text('');
                            //$('#custslogout_ipaddress' + i).text('');
                            $('#custslogout_datea' + i).text('');
                        }
                    }
                }
            };
            
            custslogin = new custslogin();
            custslogout = new custslogout();

			$(document).ready(function() {		
				_q_boxClose();
                q_getId();
                q_gf('', q_name);
                custslogin.load();
                custslogout.load();
			});
			
			var sess;
			function q_gfPost() {
				q_getFormat();
                q_langShow();
                q_popAssign();
                q_cur=2;
                t_where="where=^^exists (select * from custt where id=a.id and '"+q_date()+"' between bdate and edate) ^^";
				q_gt('custs_login', t_where, 0, 0, 0,'custslogin_init', r_accy);
				
				$('#btnClearAll').click(function() {
					if(!confirm('確定要刪除全部登入資訊?'))
						return;
					var datea=[];
					datea[0]={
						typea:'all',
						id:''
					}
						
					Lock(1,{opacity:0});
					$.ajax({
						url: 'loginhistory_update.aspx',
						headers: { 'database': q_db },
						type: 'POST',
						data: JSON.stringify(datea[0]),
						dataType: 'text',
						timeout: 10000,
						success: function(data){
							if(data.length>0){
								alert(data)
							}
							//重新載入資料
							t_where="where=^^exists (select * from custt where id=a.id and '"+q_date()+"' between bdate and edate) ^^";
							q_gt('custs_login', t_where, 0, 0, 0,'custslogin_init', r_accy);
						},
						complete: function(){ 
							Unlock(1);
						},
						error: function(jqXHR, exception) {
							var errmsg = this.url+'資料清除異常。\n';
							if (jqXHR.status === 0) {
								alert(errmsg+'Not connect.\n Verify Network.');
							} else if (jqXHR.status == 404) {
								alert(errmsg+'Requested page not found. [404]');
							} else if (jqXHR.status == 500) {
								alert(errmsg+'Internal Server Error [500].');
							} else if (exception === 'parsererror') {
								alert(errmsg+'Requested JSON parse failed.');
							} else if (exception === 'timeout') {
								alert(errmsg+'Time out error.');
							} else if (exception === 'abort') {
								alert(errmsg+'Ajax request aborted.');
							} else {
								alert(errmsg+'Uncaught Error.\n' + jqXHR.responseText);
							}
						}
					});
				});
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
			var custslogin_n='';//目前custslogin的列數
			function q_gtPost(t_name) {
				switch (t_name) {
                    case 'custslogin_init':
                    	var as = _q_appendData("custs", "", true);
                        var cust_login = [].concat(as);
                        var cust_logout = [].concat(as);
                        <% get_sess(); %>
                        var sess=$('#textSess').val().split(',');
                        
                        for(var i=0;i<cust_login.length;i++){
                        	var t_login=false;
                        	for(var j=0;j<sess.length;j++){
                        		if(cust_login[i].id==sess[j]){
                        			t_login=true;
                        			break;
                        		}
                        	}
                        	if(!t_login || (cust_login[i].memo=="" && cust_login[i].datea=="") || cust_login[i].status=="logout"){
                        		cust_login.splice(i, 1);
								i--;
                        	}
                        }
                        
                        for(var i=0;i<cust_logout.length;i++){
                        	var t_login=false;
                        	for(var j=0;j<sess.length;j++){
                        		if(cust_logout[i].id==sess[j] && (cust_logout[i].memo!="" && cust_logout[i].datea!="") && cust_logout[i].status=="success"){
                        			t_login=true;
                        			break;
                        		}
                        	}
                        	if(t_login ){
                        		cust_logout.splice(i, 1);
								i--;
                        	}
                        }
                        custslogin.init(cust_login);
                        custslogout.init(cust_logout);
                        
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
			#custslogin_table {
                border: 5px solid gray;
                font-size: medium;
                background-color: white;
            }
            #custslogin_table tr {
                height: 30px;
            }
            #custslogin_table td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                background-color: pink;
                color: blue;
            }
            #custslogin_header td:hover{
                background : yellow;
                cursor : pointer;
            }
            
            #custslogout_table {
                border: 5px solid gray;
                font-size: medium;
                background-color: white;
            }
            #custslogout_table tr {
                height: 30px;
            }
            #custslogout_table td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                background-color: bisque;
                color: blue;
            }
            #custslogout_header td:hover{
                background : yellow;
                cursor : pointer;
            }
		</style>
	</head>
	<body>
		<div id='q_menu'> </div>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type='button' id='btnAuthority' name='btnAuthority' style='font-size:16px;' value='權限'/>
		<input type='button' id='btnClearAll' style='font-size:16px;' value='清除所有資訊'/>
		<table style="width: 1250px;text-align: center;">
			<tr>
				<td style="width: 50%"><a style="color: blue;font-size: 20px;font-weight: bold;">線上會員</a></td>
				<td style="width: 50%"><a style="color: blue;font-size: 20px;font-weight: bold;">離線會員</a></td>
			</tr>
			<tr>
				<td><div id="custslogin" style="float:left;width:100%;"> </div> </td>
				<td><div id="custslogout" style="float:left;width:100%;"> </div> </td>
			</tr>
			<tr>
				<td><div id="custslogin_control" style="width:100%;"> </div></td>
				<td><div id="custslogout_control" style="width:100%;"> </div> </td>
			</tr>
		</table>
		<input id="textSess" type="hidden" class="txt c1" value="" runat="server"/>
	</body>
</html>