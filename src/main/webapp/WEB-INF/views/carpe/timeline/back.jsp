<!-- HTML -->
<div id="chartdiv"></div>

<!-- Styles -->
<style>
#chartdiv {
  width: 100%;
  height: 600px;
}

.demo-theme-dark .demo-background {
  background: #000;
}

</style>

<!-- Resources -->
<script src="core.js"></script>
<script src="charts.js"></script>
<script src="timeline.js"></script>
<script src="bullets.js"></script>
<script src="animated.js"></script>

<!-- Chart code -->
<script>
am4core.ready(function() {

// Themes begin
am4core.useTheme(am4themes_animated);
// Themes end

var chart = am4core.create("chartdiv", am4plugins_timeline.SerpentineChart);
chart.curveContainer.padding(50, 20, 50, 20);
chart.levelCount = 3;
chart.yAxisRadius = am4core.percent(25);
chart.yAxisInnerRadius = am4core.percent(-25);
chart.maskBullets = false;

var colorSet = new am4core.ColorSet();
colorSet.saturation = 0.5;

chart.dateFormatter.dateFormat = "yyyy-MM-dd HH:mm";
chart.dateFormatter.inputDateFormat = "yyyy-MM-dd HH:mm";
chart.fontSize = 11;

var categoryAxis = chart.yAxes.push(new am4charts.CategoryAxis());
categoryAxis.dataFields.category = "category";
categoryAxis.renderer.grid.template.disabled = true;
categoryAxis.renderer.labels.template.paddingRight = 25;
categoryAxis.renderer.minGridDistance = 10;
categoryAxis.renderer.innerRadius = -60;
categoryAxis.renderer.radius = 60;

var dateAxis = chart.xAxes.push(new am4charts.DateAxis());
dateAxis.renderer.minGridDistance = 70;
dateAxis.baseInterval = { count: 1, timeUnit: "minute" };
dateAxis.renderer.tooltipLocation = 0;
dateAxis.startLocation = -0.5;
dateAxis.renderer.line.strokeDasharray = "5,4";
dateAxis.renderer.line.strokeOpacity = 0.6;
dateAxis.tooltip.background.fillOpacity = 0.2;
dateAxis.tooltip.background.cornerRadius = 5;
dateAxis.tooltip.label.fill = new am4core.InterfaceColorSet().getFor("alternativeBackground");
dateAxis.tooltip.label.paddingTop = 7;

var labelTemplate = dateAxis.renderer.labels.template;
labelTemplate.verticalCenter = "middle";
labelTemplate.fillOpacity = 0.7;
labelTemplate.background.fill = new am4core.InterfaceColorSet().getFor("background");
labelTemplate.background.fillOpacity = 1;
labelTemplate.padding(7, 7, 7, 7);

var series = chart.series.push(new am4plugins_timeline.CurveColumnSeries());
series.columns.template.height = am4core.percent(20);
series.columns.template.tooltipText = "{task}: [bold]{openDateX}[/] - [bold]{dateX}[/]";
series.dataFields.openDateX = "start";
series.dataFields.dateX = "end";
series.dataFields.categoryY = "category";
series.columns.template.propertyFields.fill = "color"; // get color from data
series.columns.template.propertyFields.stroke = "color";
series.columns.template.strokeOpacity = 0;

var bullet = series.bullets.push(new am4charts.CircleBullet());
bullet.circle.radius = 3;
bullet.circle.strokeOpacity = 0;
bullet.propertyFields.fill = "color";
bullet.locationX = 0;

var bullet2 = series.bullets.push(new am4charts.CircleBullet());
bullet2.circle.radius = 3;
bullet2.circle.strokeOpacity = 0;
bullet2.propertyFields.fill = "color";
bullet2.locationX = 1;

var imageBullet1 = series.bullets.push(new am4plugins_bullets.PinBullet());
imageBullet1.locationX = 0.5;
imageBullet1.disabled = true;
imageBullet1.propertyFields.disabled = "deactivate_call";
imageBullet1.propertyFields.stroke = "color";
imageBullet1.background.propertyFields.fill = "color";
imageBullet1.image = new am4core.Image();
imageBullet1.image.propertyFields.href = "icon_call";
imageBullet1.image.scale = 0.7;
imageBullet1.circle.radius = am4core.percent(100);
imageBullet1.dy = -5;
imageBullet1.tooltipText = "[bold]<{task}>[/]\n[bold]From[/] : {from}\n[bold]To[/] : {to}\n[bold]Start Time[/] : {openDateX}\n[bold]End Time[/] : {dateX}";
imageBullet1.propertyFields.fill = "color"; // get color from data

var imageBullet2 = series.bullets.push(new am4plugins_bullets.PinBullet());
imageBullet2.locationX = 0.5;
imageBullet2.disabled = true;
imageBullet2.propertyFields.disabled = "deactivate_web_download";
imageBullet2.propertyFields.stroke = "color";
imageBullet2.background.propertyFields.fill = "color";
imageBullet2.image = new am4core.Image();
imageBullet2.image.propertyFields.href = "icon_web_download";
imageBullet2.image.scale = 0.6;
imageBullet2.circle.radius = am4core.percent(100);
imageBullet2.dy = -5;
imageBullet2.tooltipText = "[bold]<{task}>[/]\n[bold]Download Time[/] : {dateX}\n[bold]URL[/] : {from}\n[bold]File[/] : {file}";
imageBullet2.propertyFields.fill = "color"; // get color from data

var imageBullet3 = series.bullets.push(new am4plugins_bullets.PinBullet());
imageBullet3.locationX = 0.5;
imageBullet3.disabled = true;
imageBullet3.propertyFields.disabled = "deactivate_usb";
imageBullet3.propertyFields.stroke = "color";
imageBullet3.background.propertyFields.fill = "color";
imageBullet3.image = new am4core.Image();
imageBullet3.image.propertyFields.href = "icon_usb";
imageBullet3.image.scale = 0.7;
imageBullet3.circle.radius = am4core.percent(100);
imageBullet3.dy = -5;
imageBullet3.tooltipText = "[bold]<{task}>[/]\n[bold]Connected Time[/] : {dateX}";
imageBullet3.propertyFields.fill = "color"; // get color from data

var imageBullet4 = series.bullets.push(new am4plugins_bullets.PinBullet());
imageBullet4.locationX = 0.5;
imageBullet4.disabled = true;
imageBullet4.propertyFields.disabled = "deactivate_message";
imageBullet4.propertyFields.stroke = "color";
imageBullet4.background.propertyFields.fill = "color";
imageBullet4.image = new am4core.Image();
imageBullet4.image.propertyFields.href = "icon_message";
imageBullet4.image.scale = 0.7;
imageBullet4.circle.radius = am4core.percent(100);
imageBullet4.dy = -5;
imageBullet4.tooltipText = "[bold]<{task}>[/]\n[bold]From[/] : {from}\n[bold]To[/] : {to}\n[bold]DateTime[/] : {openDateX}";
imageBullet4.propertyFields.fill = "color"; // get color from data


var eventSeries = chart.series.push(new am4plugins_timeline.CurveLineSeries());
eventSeries.dataFields.dateX = "eventDate";
eventSeries.dataFields.categoryY = "category";
eventSeries.data = [
<!--    { category: "", eventDate: "2019-01-05 11:33", letter: "Call", description: "Elice called Bob" }, -->
<!--    { category: "", eventDate: "2019-01-08 14:00", letter: "Message", description: "Bob send message to Elice" }, -->
<!--    { category: "", eventDate: "2019-01-10 12:34", letter: "Call", description: "Bob called Elice" }-->
];
eventSeries.strokeOpacity = 0;

var flagBullet = eventSeries.bullets.push(new am4plugins_bullets.FlagBullet())
flagBullet.label.propertyFields.text = "letter";
flagBullet.locationX = 0;
flagBullet.tooltipText = "{description}";

chart.scrollbarX = new am4core.Scrollbar();
chart.scrollbarX.align = "center"
chart.scrollbarX.width = am4core.percent(85);

var cursor = new am4plugins_timeline.CurveCursor();
chart.cursor = cursor;
cursor.xAxis = dateAxis;
cursor.yAxis = categoryAxis;
cursor.lineY.disabled = true;
cursor.lineX.strokeDasharray = "1,4";
cursor.lineX.strokeOpacity = 1;

dateAxis.renderer.tooltipLocation2 = 0;
categoryAxis.cursorTooltipEnabled = false;

chart.data = [
{
    "category": "Timeline",
    "start": "2019-01-05 10:30",
    "end": "2019-01-05 10:30",
	"from":"Elice",
	"to":"Bob",
	"Content": "안녕하세요, 나직원님. 일전에 같이 프로젝트를 진행했던 나이사입니다. 다름이 아니라 현 직장의 연봉에 만족하고 계시지 않다면, 이직 제안을 드리고 싶습니다. 이직에 응하신다면 현 직장보다 더 높은 연봉을 보장해드리겠습니다. 다만 세부 조건이 있으니 생각있으시면 문자로 연락 주시기 바랍니다. 나이사 드림",
    "color": "#888FFE",
    "task": "Email",
	"icon_message":"./images/email2.png",
	"deactivate_message":false	
},
{
    "category": "Timeline",
    "start": "2019-01-08 18:34",
    "end": "2019-01-08 18:45",
	"from":"Elice",
	"to":"Bob",
    "color": "#5FDF7F",
    "task": "Call",
	"icon_call":"./images/call4.png",
	"deactivate_call":false
},
{
    "category": "Timeline",
    "start": "2019-01-05 11:33",
    "end": "2019-01-05 11:41",
	"from":"Bob",
	"to":"Elice",
    "color": "#5FDF7F",
    "task": "Call",
	"icon_call":"./images/call4.png",
	"deactivate_call":false
},
{
    "category": "Timeline",
    "start": "2019-01-08 20:33",
    "end": "2019-01-08 20:41",
	"from":"Bob",
	"to":"Eve",
    "color": "#5FDF7F",
    "task": "Call",
	"icon_call":"./images/call4.png",
	"deactivate_call":false
},
{
    "category": "Timeline",
    "start": "2019-01-07 21:00",
    "end": "2019-01-07 21:00",
	"from":"Bob",
	"to":"Elice",
    "color": "#888FFE",
    "task": "Email",
	"icon_message":"./images/email2.png",
	"deactivate_message":false	
},
{
    "category": "Timeline",
    "start": "2019-01-08 16:00",
    "end": "2019-01-08 16:00",
	"from":"Elice",
	"to":"Bob",
    "color": "#888FFE",
    "task": "Email",
	"icon_message":"./images/email2.png",
	"deactivate_message":false	
},
{
    "category": "Timeline",
    "start": "2019-01-08 17:00",
    "end": "2019-01-08 17:00",
	"from":"Bob",
	"to":"Elice",
    "color": "#888FFE",
    "task": "Email",
	"icon_message":"./images/email2.png",
	"deactivate_message":false	
},
{
    "category": "Timeline",
    "start": "2019-01-05 12:44",
    "end": "2019-01-05 12:44",
	"from":"Bob",
	"to":"Elice",
    "color": "#67B0FF",
    "task": "Message",
	"icon_message":"./images/sms.svg",
	"deactivate_message":false
},
{
    "category": "Timeline",
    "start": "2019-01-05 13:45",
    "end": "2019-01-05 13:45",
	"from":"Elice",
	"to":"Bob",
    "color": "#67B0FF",
    "task": "Message",
	"icon_message":"./images/sms.svg",
	"deactivate_message":false
},
{
    "category": "Timeline",
    "start": "2019-01-05 18:00",
    "end": "2019-01-05 18:00",
	"from":"Bob",
	"to":"Eve",
    "color": "#67B0FF",
    "task": "Message",
	"icon_message":"./images/sms.svg",
	"deactivate_message":false
},
{
    "category": "Timeline",
    "start": "2019-01-07 09:44",
    "end": "2019-01-07 09:44",
	"from":"Bob",
	"to":"Elice",
    "color": "#67B0FF",
    "task": "Message",
	"icon_message":"./images/sms.svg",
	"deactivate_message":false
},
{
    "category": "Timeline",
    "start": "2019-01-07 17:44",
    "end": "2019-01-07 17:44",
	"from":"Elice",
	"to":"Bob",
    "color": "#67B0FF",
    "task": "Message",
	"icon_message":"./images/sms.svg",
	"deactivate_message":false
},
{
    "category": "Timeline",
    "start": "2019-01-08 08:00",
    "end": "2019-01-08 08:00",
	"from":"Bob",
	"to":"Elice",
    "color": "#67B0FF",
    "task": "Message",
	"icon_message":"./images/sms.svg",
	"deactivate_message":false
},
{
    "category": "Timeline",
    "start": "2019-01-08 14:00",
    "end": "2019-01-08 14:00",
	"from":"Elice",
	"to":"Bob",
    "color": "#67B0FF",
    "task": "Message",
	"icon_message":"./images/sms.svg",
	"deactivate_message":false	

},
{
    "category": "Timeline",
    "start": "2019-01-06 09:00",
    "end": "2019-01-06 09:00",
	"from":"https://cloud.naver.com",
	"file":"am4chart_module_manual.pdf",
    "color": "#DF865F",
    "task": "Web download",
	"icon_web_download":"./images/web_download.png",
	"deactivate_web_download":false	
},
{
    "category": "Timeline",
    "start": "2019-01-06 13:00",
    "end": "2019-01-06 13:00",
	"from":"https://cloud.naver.com",
	"file":"am4chart_spec.pdf",
    "color": "#DF865F",
    "task": "Web download",
	"icon_web_download":"./images/web_download.png",
	"deactivate_web_download":false	
},
{
    "category": "Timeline",
    "start": "2019-01-05 23:30",
    "end": "2019-01-05 23:30",
    "color": "#DF5F5F",
    "task": "USB Connection",
	"icon_usb":"./images/usb5.png",
	"deactivate_usb":false	
},
{
    "category": "Timeline",
    "start": "2019-01-07 02:30",
    "end": "2019-01-07 02:30",
    "color": "#DF5F5F",
    "task": "USB Connection",
	"icon_usb":"./images/usb5.png",
	"deactivate_usb":false	
},

];
}); // end am4core.ready()
</script>
