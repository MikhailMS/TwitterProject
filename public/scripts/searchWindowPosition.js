function init() {
    updatePosition();
    window.addEventListener("resize", resized);
}

function resized(event) {
    updatePosition();
}

function updatePosition() {
    var area = document.getElementsByTagName("div")[0];
    if(area.clientHeight > window.innerHeight) {
        area.style.marginTop = "10px";
        area.style.marginBottom = "10px";
        area.style.top = "0%";
        area.style.transform = "none";
        document.body.style.overflow = "scroll";
        document.body.style.overflow.y = "scroll";
    }else {
        area.style.marginTop = "0px";
        area.style.marginBottom = "0px";
        area.style.top = "50%";
        area.style.transform = "translateY(-50%)";
        document.body.style.overflow = "hidden";
        document.body.style.overflow.y = "hidden";
    }
}

if(document.getElementById) window.onload = init;