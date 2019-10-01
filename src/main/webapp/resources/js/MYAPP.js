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

function fileSizeSI(size) {
	if (typeof size !== 'number') {
		if (typeof size === 'string') {
			size = size.replace(/,/g, '');
		}
	
		size = parseInt(size);
		
		if (isNaN(size)) {
			return 'n/a';
		}
	}

    var e = (Math.log(size) / Math.log(1024)) | 0;

    return +(size / Math.pow(1024, e)).toFixed(2) + ' ' + ('KMGTPEZY'[e - 1] || '') + 'B';
}

function base64EncodingUTF8(str) {
	utf8Bytes = encodeURIComponent(str).replace(/%([0-9A-F]{2})/g, function(match, p1) {
        return String.fromCharCode('0x' + p1);
	});

	return btoa(utf8Bytes);
}