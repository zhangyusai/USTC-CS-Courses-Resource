
var len=$("#box li").length;

function init(){
    for(i=8;i<len;i++){
        $("#box li").eq(i).addClass("hid");   
    }
}

$("#tog-dir").click(function(){
    var t=$(this).attr("class");
    if(t=="show"){
        $("#box .hid").addClass("show");
    }else{
        $("#box .hid").removeClass("show");
    }  
});

init();//初始化隐藏多余标签

