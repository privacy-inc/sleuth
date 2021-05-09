import Foundation

extension Script {
    static let dark = """
function _privacy_incognit_make_dark(element) {
    const background_color = getComputedStyle(element).getPropertyValue("background-color");
    const parts = background_color.match(/[\\d.]+/g);
    const shadow = getComputedStyle(element).getPropertyValue("box-shadow");
    const text_color = element.style.color;
    const gradient = getComputedStyle(element).getPropertyValue("background").includes("gradient");

    if (element.tagName != "A" && text_color != "") {
        element.style.setProperty("color", "#cecccf", "important");
    }

    if (shadow != "none") {
        element.style.setProperty("box-shadow", "none", "important");
    }

    if (gradient) {
        element.style.setProperty("background", "none", "important");
        element.style.setProperty("background-color", "rgba(37, 34, 40)", "important");
        console.log("gradient");
    } else if (parts.length > 3) {
        if (parts[3] > 0) {
            element.style.setProperty("background-color", "rgba(37, 34, 40, ${ parts[3] })", "important");
        }
    } else {
        element.style.setProperty("background-color", "rgba(37, 34, 40)", "important");
    }
}

const _privacy_incognit_event = function(_privacy_incognit_event) {
    if (_privacy_incognit_event.animationName == '_privacy_incognit_node') {
        _privacy_incognit_make_dark(_privacy_incognit_event.target);
    }
}
        
document.addEventListener('webkitAnimationStart', _privacy_incognit_event, false);

const _privacy_incognit_style = document.createElement('style');
_privacy_incognit_style.innerHTML = "\
\
:root, html, body {\
    background-color: #252228 !important;\
}\
a, a *, a:link *, a:visited *, a:hover *, a:active * {\
    color: #7caadf !important;\
}\
:root :not(a, a *, a:link *, a:visited *, a:hover *, a:active *) {\
    color: #cecccf !important;\
}\
* {\
    -webkit-animation-duration: 0.01s;\
    -webkit-animation-name: _privacy_incognit_node;\
    border-color: #454248 !important;\
    outline-color: #454248 !important;\
    box-shadow: none !important;\
}\
::before, ::after {\
    display: none !important;\
}\
@-webkit-keyframes _privacy_incognit_node {\
    from {\
        outline-color: #fff;\
    }\
    to {\
        outline-color: #000;\
    }\
}";

setTimeout(function() { document.head.appendChild(_privacy_incognit_style); }, 5);
"""
}
