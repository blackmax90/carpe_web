
var openLayer = function(selector, callback) {
	// selector : dom object or css selector (#id)
	var lay = $(selector);
	lay.show().css({opacity:0});
	var l = $(window).width()/2 - lay.width()/2;
	var t = $(window).height()/2 - lay.height()/2;
	var w = $('body').width();
	$('html').addClass('layer-opened')
	$('body').css( 'width', w )
	lay.css({
		left:'50%',
		top:'50%',
		margin: (lay.height()*-0.5)+'px 0px 0px '+(lay.width()*-0.5)+'px'
	}).animate({opacity:1}, 500, callback);
};
var closeLayer = function(selector, next, callback) {
	var lay = $(selector);

	if (next) {
		lay.fadeOut(100);
		openLayer(next, callback);
		return;
	}

	lay.fadeOut(300, function() {
		$('html').removeClass('layer-opened');
		$('body').css( 'width', '100%' )
	});
};

// 2017-09-25 lnb 액션 추가
function hasJqueryObject( $elem ){ return $elem.length > 0;}
	var app = app || {};

	app.lnbEvent = function(){
		var $lnbWrap = app.$body.find(".lnb");
		var $btnLnbControl = $lnbWrap.find(".btnLnbControl");

		if(!$lnbWrap.hasClass("active")){
			$lnbWrap.addClass("active");
			$lnbWrap.animate({ "right" :0 });
		}else{
			$lnbWrap.removeClass("active");
			$lnbWrap.animate({ "right" :-320});
		}
	}


	$(function(){
		app.$body = $("body");

		app.$body.on("click", ".btnLnbControl" , app.lnbEvent); // lnb 컨트롤
	});