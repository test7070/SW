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
        <script type="text/javascript" src="http://59.125.143.170/highslide/highslide.packed.js"></script>
		<script type="text/javascript" src="http://59.125.143.170/highslide/highslide-with-html.packed.js"></script>
		<link rel="stylesheet" type="text/css" href="http://59.125.143.170/highslide/highslide.css" /> 
		<script type="text/javascript"> hs.graphicsDir = 'http://59.125.143.170/highslide/graphics/'; hs.showCredits = false; hs.outlineType = 'rounded-white'; hs.outlineWhileAnimating = true; </script>
		<script type="text/javascript" src="http://59.125.143.170/script/WFU-ts-mix.js"></script>
		<script type="text/javascript" src="http://59.125.143.170/script/tongwen-ts.js"></script>
        <script type="text/javascript">    
            var q_name = "announce";
            var q_readonly = ['txtNoa','txtWorker','txtWorker2'];
            var bbmNum = [];
            var bbmMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwCount2 = 5;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            q_desc = 1;
            //ajaxPath = ""; //  execute in Root
            aPop = new Array();
			
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
            	bbmMask = [['txtBdate', '9999/99/99'],['txtEdate', '9999/99/99']];
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
                
                q_cmbParse("cmbTypea", ','+q_getPara('announce.typea'));
                q_cmbParse("cmbArea", ','+q_getPara('announce.area'));
                
                $('.lblLanguage1').text('繁體');
                $('.lblLanguage2').text('簡體');
                
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
							}; 
						}
						fr.onloadstart = function(e){
							$('#FileList').append('<div styly="width:100%;"><progress id="progress" max="100" value="0" ></progress><progress id="progress" max="100" value="0" ></progress><a>'+fr.fileName+'</a></div>');
						}
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
							oReq.ontimeout = function () { alert("Timed out!!!"); }
							oReq.open("POST", 'announce_upload.aspx', true);
							oReq.setRequestHeader("Content-type", "text/plain");
							oReq.setRequestHeader("FileName", escape(fr.fileName));
							oReq.send(fr.result);
						};
					}
					ShowImglbl();
				});
				
				$('.btnAtt').change(function() {
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
							}; 
						}
						fr.onloadstart = function(e){
							$('#FileList').append('<div styly="width:100%;"><progress id="progress" max="100" value="0" ></progress><progress id="progress" max="100" value="0" ></progress><a>'+fr.fileName+'</a></div>');
						}
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
							oReq.ontimeout = function () { alert("Timed out!!!"); }
							oReq.open("POST", 'announce_upload.aspx', true);
							oReq.setRequestHeader("Content-type", "text/plain");
							oReq.setRequestHeader("FileName", escape(fr.fileName));
							oReq.send(fr.result);
						};
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
						$('#'+lblimg).addClass('btn highslide ').attr('href','../images/sw/announce/'+$('#'+txtimg).val())
						.attr('onclick',"return hs.expand(this, { captionId: 'caption1', align: 'center',allowWidthReduction: true } )");
					}else{
						$('#'+lblimg).removeClass('btn highslide ').removeAttr('href').removeAttr('onclick');
					}
						
					$('#'+lblimg).bind('contextmenu', function(e) {
						/*滑鼠右鍵*/
						e.preventDefault();
                        if($('#'+txtimg).val().length>0)
                        	$('#xdownload').attr('src','announce_download.aspx?FileName='+$('#'+txtimg+'name').val()+'&TempName='+$('#'+txtimg).val());
                        else
                        	alert('無資料...');
					});
				});
				
				$('.lblAttShowDown').each(function(){
					var txtimg=replaceAll($(this).attr('id'),'lbl','txt');
					var lblimg=replaceAll($(this).attr('id'),'lbl','lbl');
					if(!emp($('#'+txtimg).val()))
						$('#'+lblimg).addClass('btn');
						
					$('#'+lblimg).bind('contextmenu', function(e) {
						/*滑鼠右鍵*/
						e.preventDefault();
                        if($('#'+txtimg).val().length>0)
                        	$('#xdownload').attr('src','announce_download.aspx?FileName='+$('#'+txtimg+'name').val()+'&TempName='+$('#'+txtimg).val());
                        else
                        	alert('無資料...');
					});
				});
           }
           
           function ChangeGB() {
				if(q_cur==1 || q_cur==2){
					$('.ChangeGB').attr('title',"點擊滑鼠左鍵，轉簡體。").addClass('btn');
					$('.ChangeGB').click(function() {
						var txtGB = replaceAll($(this).attr('id'),'lbl','txt');
						var txtBIG5 = replaceAll($(this).attr('id'),'lbl','txt');
						txtBIG5=txtBIG5.substr(0,txtBIG5.length-1)+((txtGB.indexOf('Title')>-1|| txtGB.indexOf('Memo')>-1)?'':'1');
						$('#'+txtGB).val(toSimp($('#'+txtBIG5).val()));
					});
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
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }  /// end switch
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('announce_s.aspx', q_name + '_s', "500px", "300px", q_getMsg("popSeek"));
            }

            function btnIns() {
                _btnIns();
                $('#txtTitle').focus();
                ShowImglbl();
                ChangeGB();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtTitle').focus();
                ShowImglbl();
                ChangeGB();
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
                t_err = q_chkEmpField([['cmbTypea', q_getMsg('lblTypea')],['txtTitle', q_getMsg('lblTitle')],['txtMemo', q_getMsg('lblMemo')]]);
                
                if (t_err.length > 0) {
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
                ShowImglbl();
                ChangeGB();
            }
            
            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                 if(t_para){
                 	$('.btnImg').attr('disabled', 'disabled');
                 	$('.btnAtt').attr('disabled', 'disabled');
                 	$('#txtBdate').datepicker( 'destroy' );
                 	$('#txtEdate').datepicker( 'destroy' );
                }else{
                	$('.btnImg').removeAttr('disabled', 'disabled');
                	$('.btnAtt').removeAttr('disabled', 'disabled');
                	$('#txtBdate').removeClass('hasDatepicker')
					$('#txtBdate').datepicker({ dateFormat: 'yy/mm/dd' });
					$('#txtEdate').removeClass('hasDatepicker')
					$('#txtEdate').datepicker({ dateFormat: 'yy/mm/dd' });
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
                width: 25%;
                float: left;
            }
            .txt.c3 {
                width: 85%;
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
						<td align="center" style="width:60%"><a id='vewTitle'> </a></td>
						<td align="center" style="width:20%"><a id='vewBdate'> </a></td>
						<td align="center" style="width:15%"><a id='vewTypea'> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td align="center" id="title">~title</td>
						<td align="center" id='bdate ~ edate'>~bdate ~ ~edate</td>
						<td align="center" id='typea'>~typea</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' style="float: left;">
				<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='5'>
					<tr style="height:1px;">
						<td style="width: 150px"> </td>
						<td style="width: 50px"> </td>
						<td style="width: 400px"> </td>
						<td style="width: 150px"> </td>
						<td style="width: 50px"> </td>
						<td style="width: 400px"> </td>
						<td style="width: 10px"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTitle' class="lbl"> </a></td>
						<td><span> </span><a class='lbl lblLanguage1'> </a></td>
						<td colspan="4"><input id="txtTitle"  type="text"  class="txt c1"/></td>
						<td><input id="txtNoa"  type="text" style="display: none;"/> </td>
					</tr>
					<tr>
						<td> </td>
						<td><span> </span><a id='lblTitle2' class='lbl lblLanguage2 ChangeGB'> </a></td>
						<td colspan="4"><input id="txtTitle2"  type="text"  class="txt c1"/></td>
						<td> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td><span> </span><a class='lbl lblLanguage1'> </a></td>
						<td colspan="4"><textarea id="txtMemo" cols="10" rows="5" style="width: 99%;height: 100px;"> </textarea></td>
						<td> </td>
					</tr>
					<tr>
						<td> </td>
						<td><span> </span><a id='lblMemo2' class='lbl lblLanguage2 ChangeGB'> </a></td>
						<td colspan="4"><textarea id="txtMemo2" cols="10" rows="5" style="width: 99%;height: 100px;"> </textarea></td>
						<td> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblBdate' class="lbl"> </a></td>
						<td> </td>
						<td>
							<input id="txtBdate"  type="text"  class="txt c2"/>
							<a style="float:left;">~</a>
							<input id="txtEdate"  type="text"  class="txt c2"/>
						</td>
						<td><span> </span><a id='lblIsshowdate' class="lbl"> </a></td>
						<td> </td>
						<td><input id="chkIsshowdate" type="checkbox" style="float: center;"/></td>
						<td> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTypea' class="lbl"> </a></td>
						<td> </td>
						<td><select id="cmbTypea" class="txt c2"> </select></td>
						<td><span> </span><a id='lblArea' class="lbl"> </a></td>
						<td> </td>
						<td><select id="cmbArea" class="txt c2"> </select></td>
						<td> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWeba' class="lbl"> </a></td>
						<td><span> </span><a class='lbl lblLanguage1'> </a></td>
						<td><input id="txtWeba1"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id='lblWebtitlea' class="lbl"> </a></td>
						<td><span> </span><a class='lbl lblLanguage1'> </a></td>
						<td><input id="txtWebtitlea1"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td> </td>
						<td><span> </span><a class='lbl lblLanguage2'> </a></td>
						<td><input id="txtWeba2"  type="text"  class="txt c1"/></td>
						<td> </td>
						<td><span> </span><a id='lblWebtitlea2' class='lbl lblLanguage2 ChangeGB'> </a></td>
						<td><input id="txtWebtitlea2"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWebb' class="lbl"> </a></td>
						<td><span> </span><a class='lbl lblLanguage1'> </a></td>
						<td><input id="txtWebb1"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id='lblWebtitleb' class="lbl"> </a></td>
						<td><span> </span><a class='lbl lblLanguage1'> </a></td>
						<td><input id="txtWebtitleb1"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td> </td>
						<td><span> </span><a class='lbl lblLanguage2'> </a></td>
						<td><input id="txtWebb2"  type="text"  class="txt c1"/></td>
						<td> </td>
						<td><span> </span><a id='lblWebtitleb2' class='lbl lblLanguage2 ChangeGB'> </a></td>
						<td><input id="txtWebtitleb2"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAtta' class="lbl"> </a></td>
						<td><span> </span><a id='lblAtta1' class='lbl lblLanguage1 lblAttShowDown'> </a></td>
						<td>
							<input type="file" id="btnAtta1" class="btnAtt" value="選擇檔案" />
							<input id="txtAtta1"  type="hidden"/><input id="txtAtta1name"  type="hidden"/>
						</td>
						<td><span> </span><a id='lblAtttitlea' class="lbl"> </a></td>
						<td><span> </span><a class='lbl lblLanguage1'> </a></td>
						<td><input id="txtAtttitlea1"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td> </td>
						<td><span> </span><a id='lblAtta2' class='lbl lblLanguage2 lblAttShowDown'> </a></td>
						<td>
							<input type="file" id="btnAtta2" class="btnAtt" value="選擇檔案" />
							<input id="txtAtta2"  type="hidden"/><input id="txtAtta2name"  type="hidden"/>
						</td>
						<td> </td>
						<td><span> </span><a id='lblAtttitlea2' class='lbl lblLanguage2 ChangeGB'> </a></td>
						<td><input id="txtAtttitlea2"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAttb' class="lbl"> </a></td>
						<td><span> </span><a id='lblAttb1' class='lbl lblLanguage1 lblAttShowDown'> </a></td>
						<td>
							<input type="file" id="btnAttb1" class="btnAtt" value="選擇檔案" />
							<input id="txtAttb1"  type="hidden"/><input id="txtAttb1name"  type="hidden"/>
						</td>
						<td><span> </span><a id='lblAtttitleb' class="lbl"> </a></td>
						<td><span> </span><a class='lbl lblLanguage1'> </a></td>
						<td><input id="txtAtttitleb1"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td> </td>
						<td><span> </span><a id='lblAttb2' class='lbl lblLanguage2 lblAttShowDown'> </a></td>
						<td>
							<input type="file" id="btnAttb2" class="btnAtt" value="選擇檔案" />
							<input id="txtAttb2"  type="hidden"/><input id="txtAttb2name"  type="hidden"/>
						</td>
						<td> </td>
						<td><span> </span><a id='lblAtttitleb2' class='lbl lblLanguage2 ChangeGB'> </a></td>
						<td><input id="txtAtttitleb2"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblImg1' class="lbl lblImgShowDown"> </a></td>
						<td colspan="2">
							<input type="file" id="btnImg1" class="btnImg" value="選擇檔案" accept="image/*"/>
							<input id="txtImg1"  type="hidden"/><input id="txtImg1name"  type="hidden"/>
						</td>
						<td><span> </span><a id='lblImg2' class="lbl lblImgShowDown"> </a></td>
						<td colspan="2">
							<input type="file" id="btnImg2" class="btnImg" value="選擇檔案" accept="image/*"/>
							<input id="txtImg2"  type="hidden"/><input id="txtImg2name"  type="hidden"/>
						</td>
						<td> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td colspan="2"><input id="txtWorker"  type="text"  class="txt c2"/></td>
						<td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td colspan="2"><input id="txtWorker2"  type="text"  class="txt c2"/></td>
						<td> </td>
					</tr>
					<tr style="display: none;">
						<td colspan="2"><div style="width:100%;" id="FileList"> </div></td>
					</tr>
				</table>
			</div>
		</div>
		<iframe id="xdownload" style="display:none;"> </iframe>
		<input id="q_sys" type="hidden" />
	</body>
</html>
