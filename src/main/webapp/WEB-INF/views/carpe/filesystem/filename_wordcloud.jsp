<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.carpe.common.Consts"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>File Name - Word Cloud</title>
<link href="/carpe/resources/css/common.css" rel="stylesheet" type="text/css">
<link href="/carpe/resources/jqwidgets/styles/jqx.base.css" rel="stylesheet" type="text/css">
<link href="/carpe/resources/jqwidgets/styles/jqx.metrodark.css" rel="stylesheet" type="text/css">
<link href="/carpe/resources/jqwidgets/styles/jqx.energyblue.css" rel="stylesheet" type="text/css">

<script type="text/javascript" src="/carpe/resources/js/jquery-3.3.1.js"></script>

<script src="/carpe/resources/amcharts_4.5.3/amcharts4/core.js"></script>
<script src="/carpe/resources/amcharts_4.5.3/amcharts4/charts.js"></script>
<script src="/carpe/resources/amcharts_4.5.3/amcharts4/plugins/wordCloud.js"></script>
<script src="/carpe/resources/amcharts_4.5.3/amcharts4/themes/animated.js"></script>
<script src="index.js"></script>

<style>
	body {
	  font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol";
	  background-color: #ffffff;
	  overflow: hidden;
	  margin: 0;
	}
	
	#chartdiv {
	  width: 100%;
	  max-height: 600px;
	  height: 100vh;
	  font-family: Courier New;
	}
</style>

</head>

<body>
    <div id="chartdiv"></div>

<script>
(function($) {
	$(document).ready(function() {
		am4core.useTheme(am4themes_animated);
		var chart = am4core.create("chartdiv", am4plugins_wordCloud.WordCloud);
		var series = chart.series.push(new am4plugins_wordCloud.WordCloudSeries());

		series.accuracy = 4;
		series.step = 15;
		series.rotationThreshold = 0.7;
		series.maxCount = 300;
		series.minWordLength = 2;
		series.labels.template.margin(4,4,4,4);
		series.maxFontSize = am4core.percent(30);

		series.colors = new am4core.ColorSet();
		series.colors.passOptions = {};

		series.angles = [0,-90];
		series.fontWeight = "700"

		series.labels.template.tooltipText = "{word}: {value}";

		series.dataFields = {
		  "word": "tag",
		  "value": "weight"
		};

		series.data = 
		[{"tag": "slack", "weight": 89659},
		{"tag": "31bf3856ad364e35", "weight": 72118},
		{"tag": "amd64", "weight": 60478},
		{"tag": "dll", "weight": 51790},
		{"tag": "microsoft", "weight": 42794},
		{"tag": "windows", "weight": 41189},
		{"tag": "manifest", "weight": 40548},
		{"tag": "none", "weight": 34014},
		{"tag": "png", "weight": 25533},
		{"tag": "resources", "weight": 23590},
		{"tag": "mui", "weight": 21169},
		{"tag": "cat", "weight": 14851},
		{"tag": "scale", "weight": 13284},
		{"tag": "package", "weight": 13014},
		{"tag": "for", "weight": 12756},
		{"tag": "kb4487017", "weight": 12346},
		{"tag": "wow64", "weight": 11977},
		{"tag": "Microsoft", "weight": 11083},
		{"tag": "inf", "weight": 10131},
		{"tag": "Windows", "weight": 9753},
		{"tag": "exe", "weight": 9594},
		{"tag": "mum", "weight": 9351},
		{"tag": "Package", "weight": 7811},
		{"tag": "xml", "weight": 6044},
		{"tag": "contrast", "weight": 5979},
		{"tag": "targetsize", "weight": 5140},
		{"tag": "x86", "weight": 4074},
		{"tag": "b03f5f7f11d50a3a", "weight": 3463},
		{"tag": "sys", "weight": 3436},
		{"tag": "white", "weight": 3161},
		{"tag": "System", "weight": 3090},
		{"tag": "black", "weight": 2785},
		{"tag": "cdf", "weight": 2751},
		{"tag": "DLL", "weight": 2722},
		{"tag": "system", "weight": 2667},
		{"tag": "altform", "weight": 2524},
		{"tag": "unplated", "weight": 2370},
		{"tag": "netfx4", "weight": 2353},
		{"tag": "msil", "weight": 2290},
		{"tag": "MSFT", "weight": 2180},
		{"tag": "mof", "weight": 1985},
		{"tag": "dual", "weight": 1955},
		{"tag": "core", "weight": 1930},
		{"tag": "cdxml", "weight": 1714},
		{"tag": "6595b64144ccf1df", "weight": 1658},
		{"tag": "ps1", "weight": 1575},
		{"tag": "HyperV", "weight": 1565},
		{"tag": "controls", "weight": 1514},
		{"tag": "WOW64", "weight": 1489},
		{"tag": "onecore", "weight": 1472},
		{"tag": "loc", "weight": 1402},
		{"tag": "pri", "weight": 1400},
		{"tag": "xaml", "weight": 1351},
		{"tag": "ps1xml", "weight": 1334},
		{"tag": "dat", "weight": 1269},
		{"tag": "api", "weight": 1249},
		{"tag": "man", "weight": 1246},
		{"tag": "Client", "weight": 1210},
		{"tag": "languagepack", "weight": 1120},
		{"tag": "comctl32", "weight": 1092},
		{"tag": "ttf", "weight": 1076},
		{"tag": "8wekyb3d8bbwe", "weight": 1015},
		{"tag": "fon", "weight": 1010},
		{"tag": "bin", "weight": 1008},
		{"tag": "win", "weight": 1004},
		{"tag": "mfl", "weight": 951},
		{"tag": "mccs", "weight": 950},
		{"tag": "DesktopTargetCompDB", "weight": 944},
		{"tag": "provxml", "weight": 940},
		{"tag": "psd1", "weight": 936},
		{"tag": "efi", "weight": 922},
		{"tag": "keyboard", "weight": 915},
		{"tag": "base", "weight": 896},
		{"tag": "SyncRes", "weight": 888},
		{"tag": "syncres", "weight": 888},
		{"tag": "winmd", "weight": 854},
		{"tag": "jpg", "weight": 849},
		{"tag": "deployment", "weight": 840},
		{"tag": "ini", "weight": 822},
		{"tag": "admx", "weight": 822},
		{"tag": "adml", "weight": 812},
		{"tag": "PowerShell", "weight": 808},
		{"tag": "AppxSignature", "weight": 788},
		{"tag": "AppListIcon", "weight": 784},
		{"tag": "security", "weight": 777},
		{"tag": "cur", "weight": 766},
		{"tag": "cab", "weight": 759},
		{"tag": "xbf", "weight": 742},
		{"tag": "b77a5c561934e089", "weight": 733},
		{"tag": "xsd", "weight": 707},
		{"tag": "web", "weight": 690},
		{"tag": "NLS", "weight": 684},
		{"tag": "adm", "weight": 683},
		{"tag": "client", "weight": 653},
		{"tag": "service", "weight": 645},
		{"tag": "system32", "weight": 642},
		{"tag": "AppxBlockMap", "weight": 631},
		{"tag": "mlang", "weight": 629},
		{"tag": "EXE", "weight": 622},
		{"tag": "Core", "weight": 617},
		{"tag": "config", "weight": 609},
		{"tag": "css", "weight": 602},
		{"tag": "LargeTile", "weight": 600},
		{"tag": "neutral", "weight": 597},
		{"tag": "cfg", "weight": 597},
		{"tag": "WideTile", "weight": 576},
		{"tag": "Management", "weight": 571},
		{"tag": "Language", "weight": 566},
		{"tag": "SplashScreen", "weight": 564},
		{"tag": "html", "weight": 560},
		{"tag": "lnk", "weight": 554},
		{"tag": "Connections", "weight": 547},
		{"tag": "format", "weight": 544},
		{"tag": "HxA", "weight": 536},
		{"tag": "json", "weight": 533},
		{"tag": "font", "weight": 528},
		{"tag": "Media", "weight": 528},
		{"tag": "cw5n1h2txyewy", "weight": 522},
		{"tag": "aspx", "weight": 520},
		{"tag": "systemapps", "weight": 516},
		{"tag": "AppxManifest", "weight": 513},
		{"tag": "300px", "weight": 506},
		{"tag": "syswow64", "weight": 506},
		{"tag": "Resources", "weight": 504},
		{"tag": "AppList", "weight": 500},
		{"tag": "powershell", "weight": 490},
		{"tag": "common", "weight": 488},
		{"tag": "comdlg32", "weight": 482},
		{"tag": "SmallTile", "weight": 481},
		{"tag": "oyment", "weight": 480},
		{"tag": "files", "weight": 479},
		{"tag": "psm1", "weight": 478},
		{"tag": "fms", "weight": 474},
		{"tag": "Drivers", "weight": 473},
		{"tag": "quickassist", "weight": 471},
		{"tag": "60x42", "weight": 465},
		{"tag": "msimsg", "weight": 464},
		{"tag": "Security", "weight": 463},
		{"tag": "Desktop", "weight": 463},
		{"tag": "engine", "weight": 459},
		{"tag": "fessional", "weight": 456},
		{"tag": "modules", "weight": 453},
		{"tag": "windowspowershell", "weight": 453},
		{"tag": "settings", "weight": 451},
		{"tag": "Devices", "weight": 451},
		{"tag": "CompDB", "weight": 444},
		{"tag": "essionaln", "weight": 444},
		{"tag": "DesktopBaselessCompDB", "weight": 444},
		{"tag": "bootmgr", "weight": 444},
		{"tag": "txt", "weight": 443},
		{"tag": "Format", "weight": 440},
		{"tag": "Data", "weight": 425},
		{"tag": "Common", "weight": 425},
		{"tag": "x64", "weight": 423},
		{"tag": "Animate", "weight": 422},
		{"tag": "Guest", "weight": 419},
		{"tag": "Damaged", "weight": 418},
		{"tag": "Scale", "weight": 414},
		{"tag": "events", "weight": 414},
		{"tag": "Features", "weight": 414},
		{"tag": "OneCore", "weight": 412},
		{"tag": "ActivationStore", "weight": 409},
		{"tag": "Runtime", "weight": 401},
		{"tag": "GroupPolicy", "weight": 400},
		{"tag": "Square44x44Logo", "weight": 392},
		{"tag": "rsrc", "weight": 392},
		{"tag": "Shared", "weight": 390},
		{"tag": "Storage", "weight": 389},
		{"tag": "Diagnostics", "weight": 383},
		{"tag": "winrt", "weight": 381},
		{"tag": "Commands", "weight": 381},
		{"tag": "Xaml", "weight": 381},
		{"tag": "data", "weight": 374},
		{"tag": "PNF", "weight": 374},
		{"tag": "Sticker", "weight": 373},
		{"tag": "htm", "weight": 368},
		{"tag": "msc", "weight": 366},
		{"tag": "oem", "weight": 365},
		{"tag": "appxmain", "weight": 362},
		{"tag": "gif", "weight": 362},
		{"tag": "legacy", "weight": 361},
		{"tag": "iagnostic", "weight": 361},
		{"tag": "kb4485449", "weight": 358},
		{"tag": "Web", "weight": 357},
		{"tag": "Networking", "weight": 356},
		{"tag": "wav", "weight": 356},
		{"tag": "Dark", "weight": 355},
		{"tag": "MedTile", "weight": 354},
		{"tag": "Icon", "weight": 354},
		{"tag": "GPD", "weight": 346},
		{"tag": "net", "weight": 345},
		{"tag": "tlb", "weight": 344},
		{"tag": "cpl", "weight": 342},
		{"tag": "hyperv", "weight": 341},
		{"tag": "resx", "weight": 336},
		{"tag": "aspnet", "weight": 336},
		{"tag": "VirtualDevice", "weight": 329},
		{"tag": "timezones", "weight": 329},
		{"tag": "pcat", "weight": 327},
		{"tag": "Multimedia", "weight": 325},
		{"tag": "ICCID", "weight": 321},
		{"tag": "PerSimSettings", "weight": 321},
		{"tag": "schema", "weight": 321},
		{"tag": "types", "weight": 318},
		{"tag": "Cellular", "weight": 317},
		{"tag": "sql", "weight": 317},
		{"tag": "Light", "weight": 313},
		{"tag": "grxml", "weight": 312},
		{"tag": "mdac", "weight": 308},
		{"tag": "com", "weight": 308},
		{"tag": "program", "weight": 307},
		{"tag": "media", "weight": 306},
		{"tag": "Group", "weight": 304},
		{"tag": "0da4e682", "weight": 304},
		{"tag": "log", "weight": 303},
		{"tag": "cdosys", "weight": 302},
		{"tag": "wmi", "weight": 301},
		{"tag": "edia", "weight": 298},
		{"tag": "coren", "weight": 296},
		{"tag": "provider", "weight": 295},
		{"tag": "gpd", "weight": 294},
		{"tag": "iis", "weight": 291},
		{"tag": "memtest", "weight": 288},
		{"tag": "DiagPackage", "weight": 288},
		{"tag": "VES", "weight": 288},
		{"tag": "setup", "weight": 287},
		{"tag": "mscorlib", "weight": 287},
		{"tag": "runtime", "weight": 287},
		{"tag": "default", "weight": 283},
		{"tag": "FileSync", "weight": 282},
		{"tag": "universal", "weight": 276},
		{"tag": "evtx", "weight": 276},
		{"tag": "LocalizedResources", "weight": 274},
		{"tag": "pckgdep", "weight": 274},
		{"tag": "nager", "weight": 274},
		{"tag": "bitmap", "weight": 271},
		{"tag": "msprivs", "weight": 271},
		{"tag": "metadata", "weight": 271},
		{"tag": "LOG1", "weight": 270},
		{"tag": "Defender", "weight": 269},
		{"tag": "ager", "weight": 269},
		{"tag": "CodeIntegrity", "weight": 268},
		{"tag": "Assets", "weight": 268},
		{"tag": "cortana", "weight": 265},
		{"tag": "tokens", "weight": 264},
		{"tag": "speech", "weight": 264},
		{"tag": "Speech", "weight": 263},
		{"tag": "hyper", "weight": 262},
		{"tag": "3DViewerProductDescription", "weight": 260},
		{"tag": "cmdletDefinition", "weight": 260},
		{"tag": "IIS", "weight": 259},
		{"tag": "etl", "weight": 259},
		{"tag": "16x11", "weight": 256},
		{"tag": "ClientTools", "weight": 255},
		{"tag": "aux", "weight": 254},
		{"tag": "crt", "weight": 254},
		{"tag": "shell", "weight": 253},
		{"tag": "INTRO", "weight": 250},
		{"tag": "app", "weight": 250},
		{"tag": "desktop", "weight": 250},
		{"tag": "product", "weight": 249},
		{"tag": "Basic", "weight": 249},
		{"tag": "powershel", "weight": 248},
		{"tag": "Replacement", "weight": 240},
		{"tag": "VisualBasic", "weight": 239},
		{"tag": "CalculatorAppList", "weight": 238},
		{"tag": "management", "weight": 236},
		{"tag": "help", "weight": 235},
		{"tag": "networking", "weight": 233},
		{"tag": "Hyper", "weight": 233},
		{"tag": "icc", "weight": 232},
		{"tag": "lsa", "weight": 232},
		{"tag": "library", "weight": 231},
		{"tag": "winpe", "weight": 230},
		{"tag": "aero", "weight": 230},
		{"tag": "MediumTile", "weight": 228},
		{"tag": "Tests", "weight": 220},
		{"tag": "eeprom", "weight": 220},
		{"tag": "host", "weight": 219},
		{"tag": "Printing", "weight": 219},
		{"tag": "ServiceModel", "weight": 218},
		{"tag": "onecoreuap", "weight": 217},
		{"tag": "bootmgfw", "weight": 216},
		{"tag": "uninstall", "weight": 214},
		{"tag": "component", "weight": 214},
		{"tag": "AppPackageAppList", "weight": 211},
		{"tag": "AppxMetadata", "weight": 210},
		{"tag": "HxMailAppList", "weight": 210},
		{"tag": "ico", "weight": 210},
		{"tag": "Activities", "weight": 208},
		{"tag": "directui", "weight": 207},
		{"tag": "http", "weight": 207},
		{"tag": "netfx", "weight": 207},
		{"tag": "SettingsHandlers", "weight": 205},
		{"tag": "main", "weight": 205},
		{"tag": "GetStartedAppList", "weight": 204},
		{"tag": "logo", "weight": 200},
		{"tag": "loop", "weight": 200},
		{"tag": "Native", "weight": 199}
		];
	});
})(jQuery);

</script>

</body>
</html>