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
    /* switch (device) {
        case 'amplification': {
            var amplification = document.querySelectorAll('.amplification');
            for (var i = 0; i < amplification.length; i++) {
                amplification[i].classList.toggle('highlightable');
            };
        };
        break;
        case 'emph': {
            var emph = document.querySelectorAll('.emph');
            for (var i = 0; i < emph.length; i++) {
                emph[i].classList.toggle('highlightable');
            };
        };
        break;
        case 'irony': {
            var irony = document.querySelectorAll('.irony');
            for (var i = 0; i < irony.length; i++) {
                irony[i].classList.toggle('highlightable');
            };
        };
        break;
        case 'imagery': {
            var imagery = document.querySelectorAll('.imagery');
            for (var i = 0; i < imagery.length; i++) {
                imagery[i].classList.toggle('highlightable');
            };
        };
        break;
        case 'allusion': {
            var allusion = document.querySelectorAll('.allusion');
            for (var i = 0; i < allusion.length; i++) {
                allusion[i].classList.toggle('highlightable');
            };
        };
        break;
        case 'contrast': {
            var contrast = document.querySelectorAll('.contrast');
            for (var i = 0; i < contrast.length; i++) {
                contrast[i].classList.toggle('highlightable');
            };
        };
        break;
        case 'name': {
            var name = document.querySelectorAll('.name');
            for (var i = 0; i < name.length; i++) {
                name[i].classList.toggle('highlightable');
            };
        };
        break;
        case 'place': {
            var place = document.querySelectorAll('.place');
            for (var i = 0; i < place.length; i++) {
                place[i].classList.toggle('highlightable');
            };
        };
        break;
        case 'rhetoricalQuestion': {
            var rhetoricalQuestion = document.querySelectorAll('.rhetoricalQuestion');
            for (var i = 0; i < rhetoricalQuestion.length; i++) {
                rhetoricalQuestion[i].classList.toggle('highlightable');
            };
        };
        break;
        case 'motif': {
            var motif = document.querySelectorAll('.motif');
            for (var i = 0; i < motif.length; i++) {
                motif[i].classList.toggle('highlightable');
            };
        };
        break;
        case 'anaphora': {
            var anaphora = document.querySelectorAll('.anaphora');
            for (var i = 0; i < anaphora.length; i++) {
                anaphora[i].classList.toggle('highlightable');
            };
        };
        break;
        case 'parallelism': {
            var parallelism = document.querySelectorAll('.parallelism');
            for (var i = 0; i < parallelism.length; i++) {
                parallelism[i].classList.toggle('highlightable');
            };
        };
        break;
        case 'metaphor': {
            var metaphor = document.querySelectorAll('.metaphor');
            for (var i = 0; i < metaphor.length; i++) {
                metaphor[i].classList.toggle('highlightable');
            };
        };
        break;
        case 'simile': {
            var simile = document.querySelectorAll('.simile');
            for (var i = 0; i < simile.length; i++) {
                simile[i].classList.toggle('highlightable');
            };
        };
        break;
    }*/
}
window.addEventListener('DOMContentLoaded',init);