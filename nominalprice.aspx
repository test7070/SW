﻿<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker.js"></script>
		<script type="text/javascript" src="../script/WFU-ts-mix.js"></script>
		<script type="text/javascript" src="../script/tongwen-ts.js"></script>
		<script type="text/javascript">
		    this.errorHandler = null;
		    function onPageError(error) {
		        alert("An error occurred:\r\n" + error.Message);
		    }
		    
		    q_tables = 's';
		    var q_name = "nominalprice";
		    var q_readonly = ['txtNoa', 'txtWorker', 'txtWorker2'];
		    var q_readonlys = [];
		    var bbmNum = [];
		    var bbsNum = [];
		    var bbmMask = [];
		    var bbsMask = [];
		    q_sqlCount = 6;
		    brwCount = 6;
		    brwList = [];
		    brwNowPage = 0;
		    brwKey = 'noa';
		    q_desc = 1;
		    aPop = new Array();
		    
		    brwCount2 = 5;

		    $(document).ready(function () {
		        bbmKey = ['noa'];
		        bbsKey = ['noa', 'noq'];
		        q_brwCount();

		        q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
		    });
		    
		    function main() {
		        if (dataErr) {
		            dataErr = false;
		            return;
		        }
		        mainForm(1);
		    }
		    
		    function currentData() {
			}

			currentData.prototype = {
				data : [],
				exclude : ['txtNoa','txtWorker','txtWorker2'], //bbm
				excludes : [], //bbs
				copy : function() {
					this.data = new Array();
					for (var i in fbbm) {
						var isExclude = false;
						for (var j in this.exclude) {
							if (fbbm[i] == this.exclude[j]) {
								isExclude = true;
								break;
							}
						}
						if (!isExclude) {
							this.data.push({
								field : fbbm[i],
								value : $('#' + fbbm[i]).val()
							});
						}
					}
					//bbs
					for (var i in fbbs) {
						for (var j = 0; j < q_bbsCount; j++) {
							var isExcludes = false;
							for (var k in this.excludes) {
								if (fbbs[i] == this.excludes[k]) {
									isExcludes = true;
									break;
								}
							}
							if (!isExcludes) {
								this.data.push({
									field : fbbs[i] + '_' + j,
									value : $('#' + fbbs[i] + '_' + j).val()
								});
							}
						}
					}
				},
				/*貼上資料*/
				paste : function() {
					for (var i in this.data) {
						$('#' + this.data[i].field).val(this.data[i].value);
					}
				}
			};
			var curData = new currentData();

		    function mainPost() {
		        bbmMask = [['txtMon', '9999/99']];
		        q_mask(bbmMask);
		        
		        q_cmbParse("cmbSteel", q_getPara('nominalprice.steel'));
		        q_cmbParse("cmbSeason", '第一季,第二季,第三季,第四季');
		        
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
		        
		        $('#cmbSteel').change(function() {
		        	bbschange();
				});
				
				//上方插入空白行
				$('#lblTop_row').mousedown(function(e) {
					if (e.button == 0) {
						q_bbs_addrow(row_bbsbbt, row_b_seq, 0);
					}
				});
				//下方插入空白行
				$('#lblDown_row').mousedown(function(e) {
					if (e.button == 0) {
						q_bbs_addrow(row_bbsbbt, row_b_seq, 1);
					}
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

		    function q_gtPost(t_name) {
		        switch (t_name) {
		            case q_name:
		                if (q_cur == 4)
		                    q_Seek_gtPost();
		                break;
		            default:
		                break;
		        }
		    }

		    function btnOk() {
		        Lock(1,{opacity:0});
            	if($('#txtMon').val().length==0){
            		alert('請輸入'+q_getMsg("lblMon"));
            		Unlock(1);
            		return;
            	}
            	if($('#cmbSteel').val().length==0){
            		alert('請輸入'+q_getMsg("lblSteel"));
            		Unlock(1);
            		return;
            	}
            	
            	//重新寫入noq
            	for (var i = 0; i < q_bbsCount; i++) {
            		$('#txtNoq_'+i).val(('000'+(i+1)).substr(-3));
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

		    function _btnSeek() {
		        if (q_cur > 0 && q_cur < 4)
		            return;

		        q_box('nominalprice_s.aspx', q_name + '_s', "550px", "300px", q_getMsg("popSeek"));
		    }

		    function bbsAssign() {
		        for (var i = 0; i < q_bbsCount; i++) {
		            $('#lblNo_' + i).text(i + 1);
		            if (!$('#btnMinus_' + i).hasClass('isAssign')) {
		            	$('#btnMinus_'+i).bind('contextmenu',function(e) {
							e.preventDefault();
	                    	if(e.button==2){
								////////////控制顯示位置
								$('#div_row').css('top', e.pageY);
								$('#div_row').css('left', e.pageX);
								//////////////
								t_IdSeq = -1;
								q_bodyId($(this).attr('id'));
								b_seq = t_IdSeq;
								$('#div_row').show();
								//顯示選單
								row_b_seq = b_seq;
								//儲存選取的row
								row_bbsbbt = 'bbs';
								//儲存要新增的地方
							}
                    	});
                    	
                    	$('#txtHmoney_'+i).change(function() {
                    		t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
                    		if(dec($('#txtHmoney_'+b_seq).val())<dec($('#txtLmoney_'+b_seq).val())
                    		){
                    			var tmp=$('#txtHmoney_'+b_seq).val();
                    			$('#txtHmoney_'+b_seq).val($('#txtLmoney_'+b_seq).val());
                    			$('#txtLmoney_'+b_seq).val(tmp);
                    		}
						});
						$('#txtLmoney_'+i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(dec($('#txtHmoney_'+b_seq).val())<dec($('#txtLmoney_'+b_seq).val())
                    		){
                    			var tmp=$('#txtHmoney_'+b_seq).val();
                    			$('#txtHmoney_'+b_seq).val($('#txtLmoney_'+b_seq).val());
                    			$('#txtLmoney_'+b_seq).val(tmp);
                    		}
						});
		            }
		        }
		        _bbsAssign();
		        bbschange();
		        ChangeGB();
		    }
		    
		    function ChangeGB() {
		    	if(q_cur==1 || q_cur==2){
		    		$('.ChangeGB').attr('title',"點擊滑鼠右鍵，轉簡體。")
		    		$('.ChangeGB').bind('contextmenu', function(e) {
		    			/*滑鼠右鍵*/
						e.preventDefault();
		    			var txtGB = $(this).attr('id');
						var txtBIG5 = replaceAll($(this).attr('id'),'2_','_');
						$('#'+txtGB).val(toSimp($('#'+txtBIG5).val()));
		    		});
		    	}
		    }
		    
		    function AllChangeGB() {
		    	if(q_cur==1 || q_cur==2){
		    		$('.ChangeGB').each(function(){
		    			var txtGB = $(this).attr('id');
						var txtBIG5 = replaceAll($(this).attr('id'),'2_','_');
						$('#'+txtGB).val(toSimp($('#'+txtBIG5).val()));
		    		});
		    	}
		    }
		    
		    function bbschange() {
		    	$('.lblLanguage_s').html('繁<BR>簡').css('line-height','23px');
		    	$('.spec').hide();
		    	$('.hmoney').hide();
		    	$('.lmoney').hide();
		    	$('.amoney').hide();
		        switch ($('#cmbSteel').val()) {
					case 'csc'://中鋼
						$('.spec').show();
						$('.hmoney').show();
		    			$('.lmoney').show();
						break;
					case 'fs'://豐興
						$('.hmoney').show();
		    			$('.lmoney').show();
						break;
					case 'bao'://寶鋼
						$('.amoney').show();
						break;
		            default:
		                break;
		        }
		    }
		    
		    function btnIns() {
		    	var t_bbscounts=q_bbsCount;
				if ($('#checkCopy').is(':checked')){
					curData.copy();
				}
		        _btnIns();
		        if ($('#checkCopy').is(':checked')){
					while(t_bbscounts>=q_bbsCount){
						q_bbs_addrow('bbs',0,0);
					}
					curData.paste();
				}
		        $('#txtNoa').val('AUTO');
				$('#txtMon').val(q_date().substr(0,7));
				$('#cmbSteel').focus();
				ChangeGB();
				bbschange();
		    }

		    function btnModi() {
		        if (emp($('#txtNoa').val()))
		            return;
		        _btnModi();
		        $('#cmbSteel').focus();
		        ChangeGB();
		        bbschange();
		    }

		    function btnPrint() {
		    	
		    }
			
			var issave=false;
		    function wrServer(key_value) {
		        var i;

		        $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
		        _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
		        issave=true;
		    }

		    function bbsSave(as) {
		        if (!as['product']&&!as['spec']) {
		            as[bbsKey[1]] = '';
		            return;
		        }
		        q_nowf();
		        as['mon'] = abbm2['mon'];
		        as['steel'] = abbm2['steel'];
		        as['season'] = abbm2['season'];
		        return true;
		    }

		    function refresh(recno) {
		        _refresh(recno);
		        bbschange();
		    }

		    function readonly(t_para, empty) {
		        _readonly(t_para, empty);
		        if (t_para) {
		        	$('#checkCopy').removeAttr('disabled');
		        	//$('#txtMon').datepicker( 'destroy' );
		        }else{
					$('#checkCopy').attr('disabled', 'disabled');
					//$('#txtMon').removeClass('hasDatepicker')
					//$('#txtMon').datepicker({ dateFormat: 'yy/mm/dd' });
				}
				if(issave){
            		issave=false;
            		var s2=new Array(q_name + '_s',"where=^^noa<='"+$('#txtNoa').val()+"' ^^ ");
					q_boxClose2(s2);
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
		    	if (q_chkClose())
					return;
		        _btnDele();
		    }

		    function btnCancel() {
		        _btnCancel();
		    }
		    
		    //判斷是bbs或bbt增加欄位
			var row_bbsbbt = '';
			//判斷第幾個row
			var row_b_seq = '';
		    //插入欄位
			function q_bbs_addrow(bbsbbt,row,topdown){
	        	//取得目前行
				var rows_b_seq=dec(row)+dec(topdown);
				if(bbsbbt=='bbs'){
					q_gridAddRow(bbsHtm, 'tbbs', 'txtNoq', 1);
					//目前行的資料往下移動
					for (var i = q_bbsCount-1; i >=rows_b_seq; i--) {
						for (var j = 0; j <fbbs.length; j++) {
		      				if(i!=rows_b_seq)
								$('#'+fbbs[j]+'_'+i).val($('#'+fbbs[j]+'_'+(i-1)).val());
							else
								$('#'+fbbs[j]+'_'+i).val('');
						}
					}
				}
				if(bbsbbt=='bbt'){
					q_gridAddRow(bbtHtm, 'tbbt', fbbt, 1, '', '', '', '__');
		            //目前行的資料往下移動
					for (var i = q_bbtCount-1; i >=rows_b_seq; i--) {
						for (var j = 0; j <fbbt.length; j++) {
		      				if(i!=rows_b_seq)
								$('#'+fbbt[j]+'__'+i).val($('#'+fbbt[j]+'__'+(i-1)).val());
							else
								$('#'+fbbt[j]+'__'+i).val('');
						}
					}
				}
				$('#div_row').hide();
				row_bbsbbt = '';
				row_b_seq = '';
	        }
		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 250px;
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
                width: 400px;
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
                
            }
            .tbbm .tr1 {
                background-color: #FFEC8B;
            }
            .tbbm .tr_carchg {
                background-color: #DAA520;
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
                width: 95%;
                float: left;
            }
            .txt.c2 {
                width: 40%;
                float: left;
            }
            .txt.c3 {
                width: 60%;
                float: left;
            }
            .txt.c4 {
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
            .dbbs {
                width: 1250px;
            }
            .tbbs a {
                font-size: medium;
            }
            .dbbs .tbbs {
				color: blue;
			}
            .num {
                text-align: right;
            }
            input[type="text"], input[type="button"], select {
                font-size: medium;
            }
            #div_row {
				display: none;
				width: 750px;
				background-color: #ffffff;
				position: absolute;
				left: 20px;
				z-index: 50;
			}
			.table_row tr td .lbl.btn {
				color: #000000;
				font-weight: bolder;
				font-size: medium;
				cursor: pointer;
			}
			.table_row tr td .lbl.btn:hover {
				color: #FF8F19;
			}
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<!--#include file="../inc/toolbar.inc"-->
		<div id="div_row" style="position:absolute; top:300px; left:500px; display:none; width:150px; background-color: #ffffff; ">
			<table id="table_row" class="table_row" style="width:100%;" border="1" cellpadding='1' cellspacing='0'>
				<tr>
					<td align="center" ><a id="lblTop_row" class="lbl btn">上方插入空白行</a></td>
				</tr>
				<tr>
					<td align="center" ><a id="lblDown_row" class="lbl btn">下方插入空白行</a></td>
				</tr>
			</table>
		</div>
		<div id='dmain' >
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:150px; color:black;"><a id='vewMon'> </a></td>
						<td align="center" style="width:130px; color:black;"><a id='vewSteel'> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" /></td>
						<td id="mon" style="text-align: center;">~mon</td>
						<td id="steel=nominalprice.steel" style="text-align: center;">~steel=nominalprice.steel</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr style="height:1px;">
						<td style="width: 130px"> </td>
						<td style="width: 170px"> </td>
						<td style="width: 80px"> </td>
						<td style="width: 10px"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMon' class="lbl"> </a></td>
						<td>
							<input id="txtMon"  type="text"  class="txt c1"/>
							<input id="txtNoa"  type="text"  class="txt c1" style="display: none;"/>
						</td>
						<td>
							<input id="checkCopy" type="checkbox" style="float:left;"/>
							<a id='lblCopy' class="lbl" style="float:left;"> </a>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblSteel' class="lbl"> </a></td>
						<td><select id="cmbSteel" class="txt c1"> </select></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblSeason' class="lbl"> </a></td>
						<td><select id="cmbSeason" class="txt c1"> </select></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan="2"><input id="txtMemo"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td><input id="txtWorker2"  type="text"  class="txt c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:30px;"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
					<td align="center" style="width:20px;"> </td>
					<td align="center" style="width:20px;"> </td>
					<td align="center" style="width:150px;"><a id='lblProduct_s'> </a></td>
					<td align="center" style="width:150px;" class="spec"><a id='lblSpec_s'> </a></td>
					<td align="center" style="width:100px;" class="hmoney"><a id='lblHmoney_s'> </a></td>
					<td align="center" style="width:100px;" class="lmoney"><a id='lblLmoney_s'> </a></td>
					<td align="center" style="width:100px;" class="amoney"><a id='lblAmoney_s'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td><a class="lblLanguage_s" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td >
						<input type="text" id="txtProduct.*" class="txt c1" /><BR>
						<input type="text" id="txtProduct2.*" class="txt c1 ChangeGB" />
					</td>
					<td class='spec' >
						<input type="text" id="txtSpec.*" class="txt c1 spec" /><BR>
						<input type="text" id="txtSpec2.*" class="txt c1 spec ChangeGB" />
					</td>
					<td class='hmoney'><input type="text" id="txtHmoney.*" class="txt num c1 hmoney" /></td>
					<td class='lmoney'><input type="text" id="txtLmoney.*" class="txt num c1 lmoney" /></td>
					<td class='amoney'><input type="text" id="txtAmoney.*" class="txt num c1 amoney" /></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
