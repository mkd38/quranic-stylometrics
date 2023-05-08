"use strict";
function init() {
    var boxes = document.getElementsByTagName('input');
    for (var i = 0, l = boxes.length; i < l; i++) {
        boxes[i].addEventListener('click', toggleHighlight, false);
    }
}
function toggleHighlight() {
    var device = this.id;
    var thingstotoggle = document.querySelectorAll('.' + device);
    console.log('.' + device);
    console.log(thingstotoggle);
    for (var i = 0, len = thingstotoggle.length; i < len; i++) { 
        thingstotoggle[i].classList.toggle("highlighted");
    }
}
window.addEventListener('DOMContentLoaded',init);