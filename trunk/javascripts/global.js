function popUp(url) {
	window.open(url,"redRef","height=600,width=550,channelmode=0,dependent=0,directories=0,fullscreen=0,location=0,menubar=0," + "resizable=0,scrollbars=1,status=1,toolbar=0");
}

function toggleHelp(show,hide,block) {
	if (document.getElementById(block).style.display == "none") {
		document.getElementById(show).style.display  = "none";
		document.getElementById(hide).style.display = "inline";
	    new Effect.BlindDown(block, {duration: 0.4,
	      afterFinish: function() {
	        Element.undoClipping(block);
	        $(block).style.width = "auto";
	        $(block).style.height = "auto";
	      }})
	} else {
		document.getElementById(show).style.display  = "inline";
		document.getElementById(hide).style.display = "none";
	    new Effect.BlindUp(block, {duration: 0.4,
	      afterFinish: function() {
	        Element.undoClipping(block);
	        Element.hide(block);
	      }})
	}
}

function newPage() {
	if (val = prompt("Enter the name of the page you would like to create:", "")) {
		document.location = "../new/" + encodeURIComponent(val);
		return false;
	}
	
	return false;
}

function newList(web_address, page_id) {
	if (val = prompt("Enter the name of the task list you would like to create:", "")) {
		new Ajax.Request('/' + web_address + '/tasks/create/' + page_id + '?title=' + encodeURIComponent(val), {asynchronous:true, evalScripts:true});
		return false;
	}

	return false;
}

function toggleTags() {
	var elements = document.getElementsByClassName('display_tag');

	for(var i = 0; i < elements.length; i++) {
 		if (elements[i].style.display == "none") {
			elements[i].style.display = "block";
//			new Effect.Highlight(elements[i].id);
		} else {
			elements[i].style.display = "none";
		}
	}	
}

function hideByClass(cla) {
	var elements = document.getElementsByClassName(cla);
	
	for(var i = 0; i < elements.length; i++) {
		elements[i].style.display = "none";
	}	
}

function showByClass(cla) {
	var elements = document.getElementsByClassName(cla);
	
	for(var i = 0; i < elements.length; i++) {
		elements[i].style.display = "block";
	}	
}

function toggleByClass(cla) {
	var elements = document.getElementsByClassName(cla);
	
	for(var i = 0; i < elements.length; i++) {
 		if (elements[i].style.display == "none") {
//			elements[i].style.display = "block";
			new Effect.Appear(elements[i]);
		} else {
			new Effect.Fade(elements[i]);
//			elements[i].style.display = "none";
		}
	}	
}

// Make sure they are all set to the same.  Called after creating a new item, among other places.
function checkToggleSync(cla, check_id) {
	var elements = document.getElementsByClassName(cla);

	// grab the first element.
	if (elements[0].style.display == "none") {
		new Effect.Fade(check_id);
	} else {
		new Effect.Appear(check_id);
	}

}

function reorder(id, request_addr) {

	if ($('task_list_' + id + '_reorder').style.display == 'none') {
		Element.show('task_list_' + id + '_reorder');
		Element.hide('task_list_' + id + '_master_completed');
		Element.hide('master_add_item_' + id);
		for (var i = 0; $('task_list_' + id + '_items').childNodes[i]; i++) {
			Element.addClassName($('task_list_' + id + '_items').childNodes[i].id, 'ReorderList');
		}

		Sortable.create('task_list_' + id + '_items', {onUpdate:function(){new Ajax.Request(request_addr, {asynchronous:true, evalScripts:true, onComplete:function(request){new Effect.Highlight('task_list_' + id + '_items',{});}, parameters:Sortable.serialize('task_list_' + id + '_items')})}})
	} else {
		Element.hide('task_list_' + id + '_reorder');

		Element.show('task_list_' + id + '_master_completed');
		Element.show('master_add_item_' + id);
		for (var i = 0; $('task_list_' + id + '_items').childNodes[i]; i++) {
			Element.removeClassName($('task_list_' + id + '_items').childNodes[i].id, 'ReorderList');
		}

		Sortable.destroy('task_list_' + id + '_items');
	}
}

function toggleListDetail() {
	var compl = document.getElementsByClassName('CompletedByline');
	var act = document.getElementsByClassName('AddedByline');
	var yay = new Date();

	yay.setTime(Date.parse('March, 15 2008 07:04:11'));

	if (compl.length != 0) {
		if (compl[0].style.display == 'none') {
			setCookie('show_list_detail', 'false', yay);
		} else {
			setCookie('show_list_detail', 'true', yay);
		}
	} else if (act.length != 0) {
		if (act[0].style.display == 'none') {
			setCookie('show_list_detail', 'false', yay);
		} else {
			setCookie('show_list_detail', 'true', yay);
		}
	}
}

function jumpto(x){
	document.location.href = x;
}

function toggleWikis() {
	if (document.getElementById("wikiList").style.display == "none") {
		document.getElementById("wikiList").style.display  = "block";
		document.getElementById("show_wiki_list").style.display  = "none";
		document.getElementById("hide_wiki_list").style.display = "inline";
	} else {
		document.getElementById("wikiList").style.display  = "none";
		document.getElementById("show_wiki_list").style.display  = "inline";
		document.getElementById("hide_wiki_list").style.display = "none";
	}
	
}

function showTrashIcon(asset_id) {
	if (!Draggables.activeDraggable) {
		Element.show(asset_id);
	}
}

function hideTrashIcon(asset_id) {
	Element.hide(asset_id);
}

function showRestoreIcon(asset_id) {
	Element.show('list_restore_icon_' + asset_id);
}

function hideRestoreIcon(asset_id) {
	Element.hide('list_restore_icon_' + asset_id);
}

var trashHighlights = new Array();
var listHighlights = new Array();
var iconHighlights = new Array();

function waitToHighlight(what, asset_id) {
	what[what.length] = asset_id;
}

function runHighlights(what) {
	if (what.length == 0) {
		return;
	}
	
	for (var i = 0; i < what.length; i++) {
		new Effect.Highlight(what[i], {duration: 5});
	}

	$A(what).clear();
}

function countrySelect(value) {
	if (value == 'US') {
		
	} else if (value == 'CA') {
		Element.hide('account_state');
		Element.show('account_province');
	} else {
		Effect.Appear('IntlMessage');
		$('city_input_text').innerHTML = 'City / Municipality';
	}
//	account_country
//	city_input_text
//	state_input_text
//	account_state
//	account_state_freeform
//	account_province
//	zip_input_text
	
}