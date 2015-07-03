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
        <link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker.js"></script>
        <script type="text/javascript">    
            var q_name = "webmail";
            var q_readonly = ['txtNoa','txtWorker','txtWorker2','txtDatea'];
            var bbmNum = [];
            var bbmMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwCount2 = 8;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            //ajaxPath = ""; //  execute in Root
            aPop = new Array();
			
			q_desc=1;
            $(document).ready(function() {
                bbmKey = ['noa'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1)
                $('#txtNoa').focus();
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(1);
                // 1=Last  0=Top
            }
			
            function mainPost() {
            	bbmMask = [];
                q_mask(bbmMask);
                q_cmbParse("combChgtemplate", '@選擇範本');
                
                q_gt('webmail', "where=^^ isnull(template,0)='1' and noa!='"+$('#txtNoa').val()+"' ^^", 0, 0, 0, "gettemplateselect");
                //$('#btnModi').hide();
                
                $('#combChgtemplate').change(function() {
                	if($('#combChgtemplate').val()!='' && q_cur==1){
                		q_gt('webmail', "where=^^ noa='"+$('#combChgtemplate').val()+"' ^^", 0, 0, 0, "gettemplate");
                	}
                	$('#combChgtemplate').get(0).selectedIndex=0;
				});
				
				$('#lblEmailaddr').click(function() {
					var t_where="1=1"
					q_box("cust_b2.aspx?"+ r_userno + ";" + r_name + ";" + q_time + ";" + t_where,'cust', "500px", "90%", q_getMsg("lblEmailaddr"));
				});
            }
            
            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                	case 'cust':
                		if (q_cur > 0 && q_cur < 4) {
							b_ret = getb_ret();
							if (!b_ret || b_ret.length == 0)
								return;
							var t_addr='',t_recipient='',t_unemail='';
							for(var i=0;i<b_ret.length;i++){
								if(b_ret[i].email.length>0){
									//t_addr=t_addr+(t_addr.length>0?',':'')+(b_ret[i].nick.length>0?b_ret[i].nick:b_ret[i].comp)+'<'+b_ret[i].email+'>';
									t_addr=t_addr+(t_addr.length>0?',':'')+b_ret[i].email;
									t_recipient=t_recipient+(t_recipient.length>0?',':'')+b_ret[i].noa;
								}else{
									t_unemail=t_unemail+(t_unemail.length>0?',':'')+(b_ret[i].nick.length>0?b_ret[i].nick:b_ret[i].comp);
								}
							}
							if(t_unemail.length)
								alert("【"+t_unemail+"】無電子信箱!!");
							$('#txtEmailaddr').val(t_addr);
							$('#txtRecipient').val(t_recipient);
						}
                		break;
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;

                }
                b_pop='';
            }
			
            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'gettemplateselect':
                		var as = _q_appendData("webmail", "", true);
						if (as[0] != undefined) {
							$('#combChgtemplate').text('');
							var t_item = "@選擇範本";
							for (i = 0; i < as.length; i++) {
								t_item = t_item + (t_item.length > 0 ? ',' : '') + $.trim(as[i].noa) + '@' + $.trim(as[i].templatename);
							}
							q_cmbParse("combChgtemplate", t_item);
						}
                		break;
                	case 'gettemplate':
                		var as = _q_appendData("webmail", "", true);
						if (as[0] != undefined) {
							$('#txtSubject').val(as[0].subject);
							$('#txtContents').val(as[0].contents);
							$('#txtContents').val(replaceAll($('#txtContents').val(),'chr(10)','\n'));
						}
                		break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }  /// end switch
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('webmail_s.aspx', q_name + '_s', "500px", "350px", q_getMsg("popSeek"));
            }

            function btnIns() {
                _btnIns();
                $('#txtDatea').val(q_date());
                $('#txtEmailaddr').focus();
                
                //重新抓取新的範本
                q_gt('webmail', "where=^^ isnull(template,0)='1' and noa!='"+$('#txtNoa').val()+"' ^^", 0, 0, 0, "gettemplateselect");
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtEmailaddr').focus();
                //重新抓取新的範本
                q_gt('webmail', "where=^^ isnull(template,0)='1' and noa!='"+$('#txtNoa').val()+"' ^^", 0, 0, 0, "gettemplateselect");
            }

            function btnPrint() {

            }

            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                    
				$('#txtContents').val(replaceAll($('#txtContents').val(),'chr(10)','\n'));
				if(!emp($('#txtEmailaddr').val())){
					var t_mailaddr=$('#txtEmailaddr').val().split(',');
					for(var i=0;i<t_mailaddr.length;i++){
						var x_mailaddr=t_mailaddr[i];
						//寄信
						var t_data = Array({
							subject:$('#txtSubject').val(),
							contents:replaceAll($('#txtContents').val(),'\n','<BR>'),
							emailaddr: x_mailaddr
						});
			                    
						$.ajax({
							url: 'webmail_send.aspx',
							headers: { 'database': q_db },
							type: 'POST',
							data: JSON.stringify(t_data[0]),
							dataType: 'text',
							timeout: 10000,
							success: function (data) {
								if (data.length > 0) {
									alert(data)
								}
							},
							complete: function () {
								
							},
							error: function (jqXHR, exception) {
								var errmsg = this.url + '資料寫入異常 SEQ:' + this.seq + '。\n';
								if (jqXHR.status === 0) {
									alert(errmsg + 'Not connect.\n Verify Network.');
								} else if (jqXHR.status == 404) {
									alert(errmsg + 'Requested page not found. [404]');
								} else if (jqXHR.status == 500) {
									alert(errmsg + 'Internal Server Error [500].');
								} else if (exception === 'parsererror') {
									alert(errmsg + 'Requested JSON parse failed.');
								} else if (exception === 'timeout') {
									alert(errmsg + 'Time out error.');
								} else if (exception === 'abort') {
									alert(errmsg + 'Ajax request aborted.');
								} else {
									alert(errmsg + 'Uncaught Error.\n' + jqXHR.responseText);
								}
							}
						});
					}
				}
                    
                Unlock();
            }

            function btnOk() {
                Lock(1,{opacity:0});
            	var t_err = '';
                t_err = q_chkEmpField([['txtSubject', q_getMsg('lblSubject')],['txtContents', q_getMsg('lblContents')]]);
                
                if (t_err.length > 0) {
                    alert(t_err);
                    Unlock(1);
                    return;
                }
                
                if($('#chkTemplate').prop('checked') && emp($('#txtTemplatename').val())){
                	t_err = '';
                	t_err = q_chkEmpField([['txtTemplatename', q_getMsg('lblTemplatename')]]);
                	alert(t_err);
                    Unlock(1);
                    return;
                }
                            	
				if(q_cur==1){
					$('#txtWorker').val(r_name);
				}else{
					$('#txtWorker2').val(r_name);
				}

				var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
				if (s1.length == 0 || s1 == "AUTO")
					q_gtnoa(q_name, replaceAll(q_date(), '/', ''));
				else
					wrServer(s1);

            }

            function wrServer(key_value) {
                var i;

                xmlSql = '';
                if (q_cur == 2)
                    xmlSql = q_preXml();

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], '', '', 2);
            }

            function refresh(recno) {
                _refresh(recno);
                $('#txtContents').val(replaceAll($('#txtContents').val(),'chr(10)','\n'));
            }
            
            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                 if(t_para){
                 	$('#combChgtemplate').attr('disabled', 'disabled');
                }else{
					$('#combChgtemplate').removeAttr('disabled', 'disabled');
                }
            }

            function btnMinus(id) {
                _btnMinus(id);
            }

            function btnPlus(org_htm, dest_tag, afield) {
                _btnPlus(org_htm, dest_tag, afield);
            }

            function q_appendData(t_Table) {
                return _q_appendData(t_Table);
            }

            function btnSeek() {
                _btnSeek();
            }

            function btnTop() {
                _btnTop();
            }

            function btnPrev() {
                _btnPrev();
            }

            function btnPrevPage() {
                _btnPrevPage();
            }

            function btnNext() {
                _btnNext();
            }

            function btnNextPage() {
                _btnNextPage();
            }

            function btnBott() {
                _btnBott();
            }

            function q_brwAssign(s1) {
                _q_brwAssign(s1);
            }

            function btnDele() {
                _btnDele();
            }

            function btnCancel() {
                _btnCancel();
            }
		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 1250px;
            }
            .tview {
            	width:100%;
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
                width: 1250px;
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
                width: 99%;
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
            .txt.c4 {
                width: 18%;
                float: left;
            }
            .txt.c5 {
                width: 80%;
                float: left;
            }
            .txt.c6 {
                width: 50%;
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
            .tbbm textarea {
                font-size: medium;
            }

            input[type="text"], input[type="button"] {
                font-size: medium;
            }
		</style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' style="overflow:hidden;">
			<div class="dview" id="dview" style="float: left; "  >
				<table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:3%"><a id='vewChk'> </a></td>
						<td align="center" style="width:15%"><a id='vewDatea'> </a></td>
						<td align="center" style="width:80%"><a id='vewSubject'> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td align="center" id="datea">~datea</td>
						<td align="center" id='subject'>~subject</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' style="float: left;">
				<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='5'>
					<tr style="height:1px;">
						<td style="width: 130px"> </td>
						<td style="width: 180px"> </td>
						<td style="width: 130px"> </td>
						<td style="width: 180px"> </td>
						<td style="width: 130px"> </td>
						<td style="width: 180px"> </td>
						<td style="width: 10px"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id='lblEmailaddr' class="lbl btn"> </a></td>
						<td><input id="txtEmailaddr"  type="text"  class="txt c1"/></td>
						<td> </td>
						<td><select id="combChgtemplate" class="txt c1"> </select></td>
						<td>
							<input id="txtNoa"  type="text" style="display: none;"/>
							<input id="txtRecipient"  type="hidden" />
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblSubject' class="lbl"> </a></td>
						<td colspan="5"><input id="txtSubject"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblContents' class="lbl"> </a></td>
						<td colspan="5"><textarea id="txtContents" cols="10" rows="10" style="width: 99%;height: 500px;"> </textarea></td>
						<td> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id='lblTemplate' class="lbl"> </a></td>
						<td><input id="chkTemplate" type="checkbox" style="float: center;"/></td>
						<td><span> </span><a id='lblTemplatename' class="lbl"> </a></td>
						<td><input id="txtTemplatename"  type="text"  class="txt c3"/></td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
