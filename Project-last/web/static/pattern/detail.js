window.onload = function () {

    /*关于放大镜的相关Js*/
    var container = document.getElementById("container");
    var smallBox = document.getElementById("smallBox");
    var floatBox = document.getElementById("floatBox");
    var markBox = document.getElementById("markBox");
    var bigBox = document.getElementById("bigBox");
    var bigImage = bigBox.getElementsByTagName("img")[0];

    smallBox.onmouseover = function () {
        floatBox.style.display = "block";
        bigBox.style.display = "block";
    };
    smallBox.onmouseout = function () {
        floatBox.style.display = "none";
        bigBox.style.display = "none";
    };
    markBox.onmousemove = function (ev) {
        var event = ev || window.event;
        var left = event.pageX - container.offsetLeft - smallBox.offsetLeft - floatBox.offsetWidth / 2;
        var top = event.pageY - container.offsetTop - smallBox.offsetTop - floatBox.offsetHeight / 2;
        if (left < 0) left = 0;
        if (top < 0) top = 0;
        if (left > smallBox.offsetWidth - floatBox.offsetWidth)
            left = smallBox.offsetWidth - floatBox.offsetWidth;
        if (top > smallBox.offsetHeight - floatBox.offsetHeight - 4)
            top = smallBox.offsetHeight - floatBox.offsetHeight - 4;
        floatBox.style.top = top + "px";
        floatBox.style.left = left + "px";
        var percentX = left / (smallBox.offsetWidth - floatBox.offsetWidth);
        var percentY = top / (smallBox.offsetHeight - floatBox.offsetHeight);
        bigImage.style.left = -percentX * (bigImage.offsetWidth - bigBox.offsetWidth) + "px";
        bigImage.style.top = -percentY * (bigImage.offsetHeight - bigBox.offsetHeight) + "px";
    }
};

