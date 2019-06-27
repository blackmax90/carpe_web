function encodeQueryData(data) {
	var i,
		hasOwn = Object.prototype.hasOwnProperty,
		ret = [];

	for (i in data) {
		if (hasOwn.call(data, i)) {
			ret.push(encodeURIComponent(i) + '=' + encodeURIComponent(data[i]));
		}
	}

	return ret.join('&');
}

function numberWithCommas(x) {
	return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

function isNumber(val) {
	return /^\d+$/.test(val);
}

function checkInput(name, ele) {
	var data = $.trim($(ele).val());
	if (!data) {
		alert('필수값[' + name + '] 입력이 필요합니다.');
		$('ele').focus();
		return false;
	} else {
		return data;
	}
}