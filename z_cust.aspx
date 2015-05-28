<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title></title>
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
            var t_area = '';
            $(document).ready(function() {
                _q_boxClose();
                q_getId();

                q_gt('area', '', 0, 0, 0, "area");
            });

            function q_gfPost() {
                $('#q_report').q_report({
                    fileName : 'z_cust',
                    options : [{//[1]
                        type : '0',
                        name : 'accy',
                        value : q_getId()[4]
                    }, {//[2]
                        type : '0',
                        name : 'namea',
                        value : r_name
                    }, {//[3]
                        type : '5',
                        name : 'datetype',
                        value : 'bdate@主帳號起始日,edate@主帳號終止日,kdate@註冊日期'.split(',')
                    }, {//[4][5]
                        type : '1',
                        name : 'xdate'
                    }, {//[6],[7]
                        type : '2',
                        name : 'custno',
                        dbf : 'cust',
                        index : 'noa,comp',
                        src : 'cust_b.aspx'
                    }, {//[8]
                        type : '5',
                        name : 'xtypea',
                        value : (' @全部,' + q_getPara('custs.typea')).split(',')
                    }, {//[9]
                        type : '5',
                        name : 'xstatus',
                        value : (' @全部,' + q_getPara('cust.status')).split(',')
                    }, {//[10]
                        type : '5',
                        name : 'xareano',
                        value : t_area.split(',')
                    },{//[11]
                    	type : '0',
                        name : 'custstypea',
                        value : q_getPara('custs.typea')
                    }]
                });
                q_popAssign();
                q_getFormat();
                q_langShow();

                $('#txtXdate1').mask('9999/99/99');
                $('#txtXdate2').mask('9999/99/99');
                $('#txtXdate1').datepicker({
                    dateFormat : 'yy/mm/dd'
                });
                $('#txtXdate2').datepicker({
                    dateFormat : 'yy/mm/dd'
                });

                var t_date, t_year, t_month, t_day;
                t_date = new Date();
                t_date.setDate(1);
                t_year = t_date.getUTCFullYear();
                t_year = t_year > 99 ? t_year + '' : '0' + t_year;
                t_month = t_date.getUTCMonth() + 1;
                t_month = t_month > 9 ? t_month + '' : '0' + t_month;
                t_day = t_date.getUTCDate();
                t_day = t_day > 9 ? t_day + '' : '0' + t_day;
                $('#txtXdate1').val(t_year + '/' + t_month + '/' + t_day);

                t_date = new Date();
                t_date.setDate(35);
                t_date.setDate(0);
                t_year = t_date.getUTCFullYear();
                t_year = t_year > 99 ? t_year + '' : '0' + t_year;
                t_month = t_date.getUTCMonth() + 1;
                t_month = t_month > 9 ? t_month + '' : '0' + t_month;
                t_day = t_date.getUTCDate();
                t_day = t_day > 9 ? t_day + '' : '0' + t_day;
                $('#txtXdate2').val(t_year + '/' + t_month + '/' + t_day);

            }

            function q_boxClose(s2) {

            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'area':
                        as = _q_appendData("area", "", true);
                        t_area = " @全部";
                        for ( i = 0; i < as.length; i++) {
                            t_area = t_area + (t_area.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].area;
                        }
                        q_gf('', 'z_cust');
                }
            }
		</script>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<div id="q_menu"> </div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container">
				<div id="q_report"> </div>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>
