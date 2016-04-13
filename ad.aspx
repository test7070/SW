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
		<script type="text/javascript" src="../highslide/highslide.packed.js"></script>
		<script type="text/javascript" src="../highslide/highslide-with-html.packed.js"></script>
		<link rel="stylesheet" type="text/css" href="../highslide/highslide.css" /> 
		<script type="text/javascript"> hs.graphicsDir = '../highslide/graphics/'; hs.showCredits = false; hs.outlineType = 'rounded-white'; hs.outlineWhileAnimating = true; </script>
        <script type="text/javascript">    
            var q_name = "ad";
            var q_readonly = ['txtNoa','txtWorker','txtWorker2'];
            var bbmNum = [];
            var bbmMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwCount2 = 16;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            //ajaxPath = ""; //  execute in Root
            aPop = new Array(['txtCustno', '', 'cust', 'noa,comp', '0txtCustno,txtComp', '']);
			q_copy = 1;

			q_desc=1;
            $(document).ready(function() {
                bbmKey = ['noa'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1);
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
            	bbmMask = [['txtBdate', '9999/99/99'],['txtEdate', '9999/99/99'],['txtVipedate', '9999/99/99'],['txtMon', '9999/99']];
                q_mask(bbmMask);
                
                $.datepicker.regional['zh-TW']={
				   dayNames:["星期日","星期一","星期二","星期三","星期四","星期五","星期六"],
				   dayNamesMin:["日","一","二","三","四","五","六"],
				   monthNames:["一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"],
				   monthNamesShort:["一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"],
				   prevText:"上月",
				   nextText:"次月",
				   weekHeader:"週"
				};
				//將預設語系設定為中文
				$.datepicker.setDefaults($.datepicker.regional["zh-TW"]);
                
                q_cmbParse("cmbTypea", '@,'+q_getPara('ad.typea'));
                q_cmbParse("cmbTypeb", '@,'+q_getPara('ad.typeb'));
                q_cmbParse("cmbGroupa", '1,2,3');
                
                $('#cmbTypea').change(function() {
                	Typeachange();
				});
				
				$('.btnImg').change(function() {
					event.stopPropagation(); 
					event.preventDefault();
					if(q_cur==1 || q_cur==2){}else{return;}
					var txtName = replaceAll($(this).attr('id'),'btn','txt');
					var btnName = $(this).attr('id');
					file = $(this)[0].files[0];
					
					if(file){
						Lock(1);
						var ext = '';
						var extindex = file.name.lastIndexOf('.');
						if(extindex>=0){
							ext = file.name.substring(extindex,file.name.length);
						}
						$('#'+txtName+'name').val(file.name);
						$('#'+txtName).val(guid()+Date.now()+ext);
						
						fr = new FileReader();
						fr.fileName = $('#'+txtName).val();
					    fr.readAsDataURL(file);
					    fr.onprogress = function(e){
							if ( e.lengthComputable ) { 
								var per = Math.round( (e.loaded * 100) / e.total) ; 
								$('#FileList').children().last().find('progress').eq(0).attr('value',per);
							}
						};
						fr.onloadstart = function(e){
							$('#FileList').append('<div styly="width:100%;"><progress id="progress" max="100" value="0" ></progress><progress id="progress" max="100" value="0" ></progress><a>'+fr.fileName+'</a></div>');
						};
						fr.onloadend = function(e){
							$('#FileList').children().last().find('progress').eq(0).attr('value',100);
							console.log(fr.fileName+':'+fr.result.length);
							var oReq = new XMLHttpRequest();
							oReq.upload.addEventListener("progress",function(e) {
								if (e.lengthComputable) {
									percentComplete = Math.round((e.loaded / e.total) * 100,0);
									$('#FileList').children().last().find('progress').eq(1).attr('value',percentComplete);
								}
							}, false);
							oReq.upload.addEventListener("load",function(e) {
								Unlock(1);
							}, false);
							oReq.upload.addEventListener("error",function(e) {
								alert("資料上傳發生錯誤!");
							}, false);
							oReq.addEventListener("loadend", function(e) {
								$('#'+btnName).val('');
							}, false);
								
							oReq.timeout = 360000;
							oReq.ontimeout = function () { alert("Timed out!!!"); };
							oReq.open("POST", 'ad_upload.aspx', true);
							oReq.setRequestHeader("Content-type", "text/plain");
							oReq.setRequestHeader("FileName", escape(fr.fileName));
							oReq.send(fr.result);
						};
					}
					ShowImglbl();
				});
				
				$('.btnPage').change(function() {
					event.stopPropagation(); 
					event.preventDefault();
					if(q_cur==1 || q_cur==2){}else{return;}
					var txtName = replaceAll($(this).attr('id'),'btn','txt');
					file = $(this)[0].files[0];
					if(file && file.name.indexOf('.zip')>-1){
						Lock(1);
						var ext = '';
						var extindex = file.name.lastIndexOf('.');
						if(extindex>=0){
							ext = file.name.substring(extindex,file.name.length);
						}
						$('#'+txtName+'name').val(file.name);
						$('#'+txtName).val(guid()+Date.now()+ext);
						
						fr = new FileReader();
						fr.fileName = $('#'+txtName).val();
					    fr.readAsDataURL(file);
					    fr.onprogress = function(e){
							if ( e.lengthComputable ) { 
								var per = Math.round( (e.loaded * 100) / e.total) ; 
								$('#FileList').children().last().find('progress').eq(0).attr('value',per);
							}
						};
						fr.onloadstart = function(e){
							$('#FileList').append('<div styly="width:100%;"><progress id="progress" max="100" value="0" ></progress><progress id="progress" max="100" value="0" ></progress><a>'+fr.fileName+'</a></div>');
						};
						fr.onloadend = function(e){
							$('#FileList').children().last().find('progress').eq(0).attr('value',100);
							console.log(fr.fileName+':'+fr.result.length);
							var oReq = new XMLHttpRequest();
							oReq.upload.addEventListener("progress",function(e) {
								if (e.lengthComputable) {
									percentComplete = Math.round((e.loaded / e.total) * 100,0);
									$('#FileList').children().last().find('progress').eq(1).attr('value',percentComplete);
								}
							}, false);
							oReq.upload.addEventListener("load",function(e) {
								Unlock(1);
							}, false);
							oReq.upload.addEventListener("error",function(e) {
								alert("資料上傳發生錯誤!");
							}, false);
								
							oReq.timeout = 360000;
							oReq.ontimeout = function () { alert("Timed out!!!"); };
							oReq.open("POST", 'page_upload.aspx', true);
							oReq.setRequestHeader("Content-type", "text/plain");
							oReq.setRequestHeader("FileName", escape(fr.fileName));
							oReq.send(fr.result);
						};
					}else{
						alert("非ZIP檔!");
					}
					
					ShowImglbl();
				});
            }
            
            var guid = (function() {
				function s4() {return Math.floor((1 + Math.random()) * 0x10000).toString(16).substring(1);}
				//return function() {return s4() + s4() + '-' + s4() + '-' + s4() + '-' +s4() + '-' + s4() + s4() + s4();};
				return function() {return s4() + s4() + s4() + s4();};
			})();
			
			function ShowImglbl() {
				$('.lblImgShowDown').each(function(){
					var txtimg=replaceAll($(this).attr('id'),'lbl','txt');
					var lblimg=replaceAll($(this).attr('id'),'lbl','lbl');
					if(!emp($('#'+txtimg).val())){
						$('#'+lblimg).addClass('btn highslide ').attr('href','../doc/ad/'+$('#'+txtimg).val())
						.attr('onclick',"return hs.expand(this, { captionId: 'caption1', align: 'center',allowWidthReduction: true } )");
					}else{
						$('#'+lblimg).removeClass('btn highslide ').removeAttr('href').removeAttr('onclick');
					}
						
					$('#'+lblimg).bind('contextmenu', function(e) {
						/*滑鼠右鍵*/
						e.preventDefault();
                        if($('#'+txtimg).val().length>0)
                        	$('#xdownload').attr('src','ad_download.aspx?FileName='+$('#'+txtimg+'name').val()+'&TempName='+$('#'+txtimg).val());
                        else
                        	alert('無資料...');
					});
				});
				
				$('.PageDown').each(function(){
					var txtpage=replaceAll($(this).attr('id'),'lbl','txt');
					var lblpage=replaceAll($(this).attr('id'),'lbl','lbl');
					if(!emp($('#'+txtpage).val())){
						$('#'+lblpage).addClass('btn');
					}else{
						$('#'+lblpage).removeClass('btn');
					}
					$('#'+lblpage).click(function() {
                        if(txtpage.length>0)
                        	$('#xdownload').attr('src','page_download.aspx?FileName='+$('#'+txtpage+'name').val()+'&TempName='+$('#'+txtpage).val());
                        else
                        	alert('無資料...'+n);
					});
				});
			}
            
            function Typeachange() {
				if($('#cmbTypea').val()!=''){
					if($('#cmbTypea').val()=='1')
						$('.typeb').show();
					else
						$('.typeb').hide();
						
					if($('#cmbTypea').val()=='4' || $('#cmbTypea').val()=='5')
						$('.groupa').show();
					else
						$('.groupa').hide();
						
					if($('#cmbTypea').val()=='4')
						$('.vip').show();
					else
						$('.vip').hide();
						
					if($('#cmbTypea').val()=='5')
						$('#lblGroupa').text(q_getMsg('lblGroupa')+q_getMsg('lblWatermark'));
					else
						$('#lblGroupa').text(q_getMsg('lblGroupa'));
					
				}else{
					$('.typeb').hide();
					$('.groupa').hide();
					$('.vip').hide();
					$('#lblWatermark').hide();
				}	
			}

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;

                }
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                	case "get_custss":
                		var as = _q_appendData("cust", "", true);
                		var ass = _q_appendData("custs", "", true);
						var rowslength=document.getElementById("table_custs").rows.length-1;
						for (var j = 1; j < rowslength; j++) {
							document.getElementById("table_custs").deleteRow(1);
						}
						var custs_typea=q_getPara('custs.typea').split(',');
						if(as[0]!=undefined){
							for (var i = 0; i < ass.length; i++) {
								var custtypea='';
								for (var j = 0; j< custs_typea.length; j++) {
									if(custs_typea[0].split('@')[0]==ass[i].typea){
										custtypea=$.trim(custs_typea[0].split('@')[1]);
										break;	
									}
								}
								
								var tr = document.createElement("tr");
								tr.id = "bbs_"+i;
								tr.innerHTML= "<td align='center'>"+dec(i+1)+"</td>";
								tr.innerHTML+= "<td align='center'>"+ass[i].id+"</td>";
								tr.innerHTML+="<td align='center'>"+as[0].comp+"</td>";
								tr.innerHTML+="<td align='center'>"+(ass[i].groupa=="true"?'是':'否')+"</td>";
								tr.innerHTML+="<td align='center'>"+custtypea+"</td>";
								tr.innerHTML+="<td align='center'>"+(ass[i].master=="true"?'是':'否')+"/"+(ass[i].sconn=="true"?'是':'否')+"</td>";
								
								var tmp = document.getElementById("custs_end");
								tmp.parentNode.insertBefore(tr,tmp);
							}
							if(ass.length>0)
								$('#div_custs').show();
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
                q_box('ad_s.aspx', q_name + '_s', "500px", "300px", q_getMsg("popSeek"));
            }
			
            function btnIns() {
                _btnIns();
                //複製時排除
                $('#txtNoa').val('');
                $('#txtWorker').val('');
                $('#txtWorker2').val('');
                
                $('#txtCustno').focus();
                ShowImglbl();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtCustno').focus();
                ShowImglbl();
            }

            function btnPrint() {

            }

            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                Unlock();
            }

            function btnOk() {
                Lock(1,{opacity:0});
            	var t_err = '';
                t_err = q_chkEmpField([['txtCustno', q_getMsg('lblCust')],['txtComp', q_getMsg('lblCust')]
                ,['txtBdate', q_getMsg('lblBdate')],['txtEdate', q_getMsg('lblBdate')],['cmbTypea', q_getMsg('lblTypea')]
                ,['txtImage1', q_getMsg('lblImage1')]]);
                
                if (t_err.length > 0) {
                    alert(t_err);
                    Unlock(1);
                    return;
                }
                
                if($('#txtWeb1').val().length==0 && $('#txtPage1').val().length==0){
            		alert('請輸入'+q_getMsg("lblPage1")+'或'+q_getMsg("lblWeb1"));
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
                ShowImglbl();
                Typeachange();
                $('#div_custs').hide();
                var t_where = "where=^^ noa='"+$("#txtCustno").val()+"' ^^";
				q_gt('cust', t_where, 0, 0, 0, "get_custss", r_accy);
            }
            
            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                 if(t_para){
                	$('.btnImg').attr('disabled', 'disabled');
                	$('.btnPage').attr('disabled', 'disabled');
                	$('#txtBdate').datepicker( 'destroy' );
                	$('#txtEdate').datepicker( 'destroy' );
                	$('#txtVipedate').datepicker( 'destroy' );
                }else{
                	$('.btnImg').removeAttr('disabled', 'disabled');
                	$('.btnPage').removeAttr('disabled', 'disabled');
                	$('#txtBdate').removeClass('hasDatepicker');
					$('#txtBdate').datepicker({ dateFormat: 'yy/mm/dd' });
					$('#txtEdate').removeClass('hasDatepicker');
					$('#txtEdate').datepicker({ dateFormat: 'yy/mm/dd' });
					$('#txtVipedate').removeClass('hasDatepicker');
					$('#txtVipedate').datepicker({ dateFormat: 'yy/mm/dd' });
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
                width: 400px;
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
                width: 840px;
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
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:28%"><a id='vewComp'> </a></td>
						<td align="center" style="width:23%"><a id='vewTypea'> </a></td>
						<td align="center" style="width:45%"><a id='vewBdate'> </a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td align="center" id='comp,6'>~comp,6</td>
						<td align="center" id="typea=ad.typea">~typea=ad.typea</td>
						<td align="center" id='bdate ~ edate'>~bdate ~ ~edate</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' style="float: left;">
				<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='5'>
					<tr style="height:1px;">
						<td style="width: 160px"> </td>
						<td style="width: 90px"> </td>
						<td style="width: 90px"> </td>
						<td style="width: 140px"> </td>
						<td style="width: 90px"> </td>
						<td style="width: 90px"> </td>
						<td style="width: 90px"> </td>
						<td style="width: 90px"> </td>
						<td style="width: 10px"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblCust' class="lbl"> </a></td>
						<td><input id="txtCustno"  type="text"  class="txt c1"/></td>
						<td colspan="5">
							<input id="txtComp"  type="text"  class="txt c1"/>
							<input id="txtNoa"  type="text"  class="txt c1" style="display: none;"/>
						</td>
						<td> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTypea' class="lbl"> </a></td>
						<td><select id="cmbTypea" class="txt c1"> </select></td>
						<td><span> </span><a id='lblTypeb' class="lbl typeb"> </a></td>
						<td colspan="2"><select id="cmbTypeb" class="txt c1 typeb"> </select></td>
						<td> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblBdate' class="lbl"> </a></td>
						<td colspan="2">
							<input id="txtBdate"  type="text"  class="txt c2"/>
							<a style="float: left;">~</a>
							<input id="txtEdate"  type="text"  class="txt c2"/>
						</td>
						<td> </td>
						<td> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblImage1' class="lbl lblImgShowDown"> </a></td>
						<td colspan="2">
							<input type="file" id="btnImage1" class="btnImg" value="選擇檔案" accept="image/*"/>
							<input id="txtImage1"  type="hidden"/><input id="txtImage1name"  type="hidden"/>
						</td>
						<td><span> </span><a id='lblImage2' class="lbl lblImgShowDown"> </a></td>
						<td colspan="2">
							<input type="file" id="btnImage2" class="btnImg" value="選擇檔案" accept="image/*"/>
							<input id="txtImage2"  type="hidden"/><input id="txtImage2name"  type="hidden"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblPage1' class="lbl PageDown"> </a></td>
						<td colspan="2">
							<input type="file" id="btnPage1" class="btnPage" value="選擇檔案" accept="application/x-zip-compressed"/>
							<input id="txtPage1"  type="hidden"/><input id="txtPage1name"  type="hidden"/>
						</td>
						<td><span> </span><a id='lblPage2' class="lbl PageDown"> </a></td>
						<td colspan="2">
							<input type="file" id="btnPage2" class="btnPage" value="選擇檔案" accept="application/x-zip-compressed"/>
							<input id="txtPage2"  type="hidden"/><input id="txtPage2name"  type="hidden"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWeb1' class="lbl"> </a></td>
						<td colspan="2"><input id="txtWeb1"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id='lblWeb2' class="lbl"> </a></td>
						<td colspan="2"><input id="txtWeb2"  type="text"  class="txt c1"/></td>
					</tr>
					<tr class="groupa">
						<td><span> </span><a id='lblGroupa' class="lbl"> </a></td>
						<td><select id="cmbGroupa" class="txt c1"> </select></td>
						<td><span> </span><a id='lblIsvip' class="lbl vip"> </a></td>
						<td><input id="chkIsvip" type="checkbox" class="vip"/></td>
						<td><span> </span><a id='lblVipedate' class="lbl vip"> </a></td>
						<td><input id="txtVipedate"  type="text"  class="txt c1 vip"/></td>
					</tr>
					<tr>
						<td rowspan="4"><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td><span> </span><a id='lblMon' class="lbl"> </a></td>
						<td><input id="txtMon"  type="text"  class="txt num c1"/></td>
						<td><a id='lblMon2' class="lbl" style="float: left;"> </a><span> </span><a id='lblMoney' class="lbl"> </a></td>
						<td><input id="txtMoney"  type="text"  class="txt num c1"/></td>
						<td><a id='lblMoney2' class="lbl" style="float: left;"> </a></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblConn1' class="lbl"> </a></td>
						<td><input id="txtConn1"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id='lblTel1' class="lbl"> </a></td>
						<td><input id="txtTel1"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id='lblMobile1' class="lbl"> </a></td>
						<td colspan="2"><input id="txtMobile1"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblConn2' class="lbl"> </a></td>
						<td><input id="txtConn2"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id='lblTel2' class="lbl"> </a></td>
						<td><input id="txtTel2"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id='lblMobile2' class="lbl"> </a></td>
						<td colspan="2"><input id="txtMobile2"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblOuther' class="lbl"> </a></td>
						<td colspan="6"><input id="txtMemo"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td><input id="txtWorker2"  type="text"  class="txt c1"/></td>
					</tr>
					<tr style="display: none;">
						<td colspan="7"><div style="width:100%;" id="FileList"> </div></td>
					</tr>
				</table>
			</div>
		</div>
		<div id="div_custs" style="width:720px; background-color: aliceblue; border: 2px solid aliceblue;">
			<table id="table_custs" style="width:100%;" border="1" cellpadding='2'  cellspacing='0'>
				<tr id='custs_head'>
					<td style="background-color: plum;width: 20px;" align="center">序</td>
					<td style="background-color: plum;width: 100px;" align="center">帳號</td>
					<td style="background-color: plum;width: 280px;" align="center">公司名稱</td>
					<td style="background-color: plum;width: 85px;" align="center">前端群組</td>
					<td style="background-color: plum;width: 85px;" align="center">會員屬性</td>
					<td style="background-color: plum;width: 150px;" align="center">主帳號/業務聯絡人</td>
				</tr>
				<tr id='custs_end' style="display: none;">
					<td> </td>
				</tr>
			</table>
		</div>
		<iframe id="xdownload" style="display:none;"> </iframe>
		<input id="q_sys" type="hidden" />
	</body>
</html>
