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
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
            var q_name = "img";
            var q_readonly = [];
            var bbmNum = [];
            var bbmMask = [];
     
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
			brwCount2 =8;
			aPop = new Array();
            				
            $(document).ready(function() {
                bbmKey = ['noa'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1);
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(0);
            }

            function mainPost() {
                q_mask(bbmMask);
                $('#txtNoa').change(function(e) {			
					t_where = "where=^^ noa='" + $(this).val() + "'^^";
					q_gt('img', t_where, 0, 0, 0, "checkNoa_change", r_accy);				
				});
				$('#btnFile').change(function(e){
					event.stopPropagation(); 
				    event.preventDefault();
					file = $('#btnFile')[0].files[0];
					if(file){
						fr = new FileReader();
					    fr.readAsDataURL(file);
					    fr.onloadend = function(e){
					    	$('#imgPic').attr('src',fr.result);
					    	$('#btnFile').val('');
					    	refreshImg(true);
					    };
					}
				});
				$('#textPara').change(function(e){
					if(q_cur==1 || q_cur==2){
						refreshPara();
					}
				});
				$('#textPara').focusout(function(e){
					if(q_cur==1 || q_cur==2){
						refreshPara();
					}
				});
            }
            function refreshPara(){
            	var string = $.trim($('#textPara').val());
				var t_para = new Array();
				var value = string.split('\n');
				for(var i=0;i<value.length;i++){
					if(value[i].split(',').length==4){
						try{
							t_para.push({key:value[i].split(',')[0]
								,top:parseInt(value[i].split(',')[1])
								,left:parseInt(value[i].split(',')[2])
								,fontsize:value[i].split(',')[3]});
						}catch(e){
						}
					}
				}
				$('#txtPara').val(JSON.stringify(t_para));
				refreshImg(false);
            }
			function refreshImg(isOrg){
				if(!isOrg){
					$('#imgPic').attr('src',$('#txtOrg').val());
				}
				var imgwidth = $('#imgPic').width();
                var imgheight = $('#imgPic').height();
                $('#canvas').width(imgwidth).height(imgheight);
                var c = document.getElementById("canvas");
				var ctx = c.getContext("2d");		
				c.width = imgwidth;
				c.height = imgheight;
				ctx.drawImage($('#imgPic')[0],0,0,imgwidth,imgheight);
				if(!isOrg && $('#textPara').val().length>0){
					t_para = JSON.parse($('#txtPara').val());
					$('#textPara').val('');
					for(var i=0;i<t_para.length;i++){
						ctx.font = t_para[i].fontsize+"px times new roman";
						ctx.fillStyle = 'red';
						ctx.fillText(t_para[i].key,t_para[i].left,t_para[i].top);
						if($('#textPara').val().length>0)
							$('#textPara').val($('#textPara').val()+'\n');
						$('#textPara').val($('#textPara').val()+t_para[i].key+','+t_para[i].top+','+t_para[i].left+','+t_para[i].fontsize);
					}
				}
				$('#imgPic').attr('src',c.toDataURL());
				if(isOrg){
					//縮放為300*100
					$('#canvas').width(300).height(100);
					c.width = 300;
					c.height = 100;
					$("#canvas")[0].getContext("2d").drawImage($('#imgPic')[0],0,0,imgwidth,imgheight,0,0,300,100);
					$('#txtOrg').val(c.toDataURL());
					refreshImg(false);
				}
				else
					$('#txtData').val(c.toDataURL());
				
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
                	case 'checkNoa_change':
						var as = _q_appendData("img", "", true);
						if (as[0] != undefined) {
							alert('已存在 ' + as[0].noa + ' ' + as[0].namea);
							Unlock(1);
							return;
						}
						break;
                	case 'checkNoa_btnOk':
						var as = _q_appendData("img", "", true);
						if (as[0] != undefined) {
							alert('已存在 ' + as[0].noa + ' ' + as[0].namea);
							Unlock(1);
							return;
						} else {
							wrServer($('#txtNoa').val());
						}
						break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('imgfe_s.aspx', q_name + '_s', "500px", "310px", q_getMsg("popSeek"));
            }

            function btnIns() {
                _btnIns();
                refreshBbm();
                $('#txtNoa').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                refreshBbm();
                $('#txtNamea').focus();
            }

            function btnPrint() {

            }
			function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                Unlock(1);
            }
            function btnOk() {
            	Lock(1,{opacity:0});
            	if($('#txtNoa').val().length==0){
            		alert('請輸入'+q_getMsg("lblNoa"));
            		Unlock(1);
            		return;
            	}
				if (q_cur == 1) {
					t_where = "where=^^ noa='" + $('#txtNoa').val() + "'^^";
					q_gt('img', t_where, 0, 0, 0, "checkNoa_btnOk");
				} else {
					wrServer($('#txtNoa').val());
				}          	
            }

            function wrServer(key_value) {
                var i;

                xmlSql = '';
                if (q_cur == 2)/// popSave
                    xmlSql = q_preXml();

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], '', '', 2);
            }

            function refresh(recno) {
                _refresh(recno);     
                refreshBbm();
            }
			function refreshBbm(){
            	if(q_cur==1){
            		$('#txtNoa').css('color','black').css('background','white').removeAttr('readonly');
            	}else{
            		$('#txtNoa').css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
            	}
            	if(q_cur==1 || q_cur==2)
                	$('#btnFile').removeAttr('disabled');
                else
                	$('#btnFile').attr('disabled','disabled');
            	$('#imgPic').attr('src',$('#txtData').val());
                for(var i=0;i<brwCount2;i++){
                	$('#vtimg_'+i).children().attr('src',$('#vtdata_'+i).text());
                }
                try{
                	t_para = JSON.parse($('#txtPara').val());
					$('#textPara').val('');
					for(var i=0;i<t_para.length;i++){
						if($('#textPara').val().length>0)
							$('#textPara').val($('#textPara').val()+'\n');
						$('#textPara').val($('#textPara').val()+t_para[i].key+','+t_para[i].top+','+t_para[i].left+','+t_para[i].fontsize);
					}
                }catch(e){
                	
                }
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
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
                width: 350px; 
                border-width: 0px; 
            }
            .tview {
                border: 5px solid gray;
                font-size: medium;
                background-color: black;
            }
            .tview tr {
                height: 30px;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                background-color: #FFFF66;
                color: blue;
            }
            .dbbm {
                float: left;
                width: 600px;
                /*margin: -1px;        
                border: 1px black solid;*/
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
                width: 20%;
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
            }
            .tbbm tr td .lbl.btn:hover {
                color: #FF8F19;
            }
            .txt.c1 {
                width: 100%;
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
            }
            .tbbs input[type="text"] {
                width: 98%;
            }
            .tbbs a {
                font-size: medium;
            }
            .num {
                text-align: right;
            }
            .bbs {
                float: left;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            select {
                font-size: medium;
            }
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<div style="overflow: auto;display:block;width:1050px;">
			<!--#include file="../inc/toolbar.inc"-->
		</div>
		<div style="overflow: auto;display:block;width:1280px;">
			<div class="dview" id="dview" >
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:120px; color:black;"><a id='vewImg'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewNoa'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewNamea'> </a></td>
						<td align="center" style="display:none;"><a id='vewData'> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
						<td id='img' style="text-align: center;"><img src="" style="width:120px;height:40px;"/></td>
						<td id='noa' style="text-align: center;">~noa</td>
						<td id='namea' style="text-align: left;">~namea</td>
						<td id='data' style="display:none;">~data</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' >
				<table class="tbbm"  id="tbbm">
					<tbody>
						<tr style="height:1px;">
							<td> </td>
							<td> </td>
							<td> </td>
							<td class="tdZ"> </td>
						</tr>
						<tr>
							<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
							<td colspan="2"><input id="txtNoa"  type="text"  class="txt c1"/></td>
						</tr>
						<tr>
							<td><span> </span><a id='lblNamea' class="lbl"> </a></td>
							<td colspan="2">
								<input id="txtNamea"  type="text" class="txt c1" />	
								<input id="txtData"  type="text" style="display:none;" />
								<input id="txtOrg"  type="text" style="display:none;"/>
								<input id="txtPara"  type="text" style="display:none;" />	
							</td>
						</tr>
						<tr>
							<td></td>
							<td colspan="2"><a style="color:#8A4B08;">代號,TOP,LEFT,字形大小</a></td>
						</tr>
						<tr> 
							<td><span> </span><a id='lblPara' class="lbl"> </a></td>
							<td colspan="2"rowspan="3">
								<textarea id="textPara" class="txt c1" rows="6"> </textarea>
							</td>
						</tr>
						<tr> </tr>
						<tr> </tr>
						<tr> </tr>
						<tr>
							<td><span> </span><a id='lblImgpci' class="lbl"> </a></td>
							<td colspan="2" rowspan="4">
								<img id="imgPic" src="" style="width:300px;height:100px;"/>
								<canvas id="canvas" style="display:none"> </canvas>
							</td>
						</tr>
						<tr> </tr>
						<tr> </tr>
						<tr> </tr>
						<tr>
							<td></td>
							<td colspan="3">
								<input type="file" id="btnFile" value="上傳"/>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>

		<input id="q_sys" type="hidden" />
	</body>
</html>
