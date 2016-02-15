$(document).ready(function(){
	$("#session_group_id").val(window.location.search.substr(-1))
	$("#session_group_id").change(function(){
		window.location.href=window.location.pathname+"?group_id="+$("#session_group_id").val();
	})
})
