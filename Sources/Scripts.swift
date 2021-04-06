import Foundation

public struct Scripts {
    public static let dark = """
function privacy_supports_dark() {
    if (location.host.includes("youtube.com") || document.documentElement.getAttribute("dark") == "true") {
        return true;
    }
    if (document.styleSheets && document.styleSheets.length > 0) {
        for (var i = 0; i < document.styleSheets.length; i++) {
            if (document.styleSheets[i].cssRules) {
                for (var j = 0; j < document.styleSheets[i].cssRules.length; j++) {
                    if (document.styleSheets[i].cssRules[j] instanceof CSSMediaRule &&
                        document.styleSheets[i].cssRules[j].media.mediaText.indexOf('dark') > 0) {
                            return true;
                    }
                }
            }
        }
        return false;
    }
    return true;
}
    
function privacy_make_dark() {
    [...document.body.getElementsByTagName("*")].forEach(element => {
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
            element.style.background = "none";
            element.style.backgroundColor = "rgba(37, 34, 40)";
        } else if (parts.length > 3) {
            if (parts[3] > 0) {
                element.style.backgroundColor = `rgba(37, 34, 40, ${ parts[3] })`;
            }
        } else {
            element.style.backgroundColor = "rgba(37, 34, 40)";
        }
    });
    
    const style = document.createElement('style');
    style.innerHTML = "\
    :root, html, body {\
        background-color: #252228 !important ;\
    }\
    a, a *, a:link *, a:visited *, a:hover *, a:active * {\
        color: #7caadf !important ;\
    }\
    body :not(a, a *, a:link *, a:visited *, a:hover *, a:active *) {\
        color: #cecccf !important ;\
    }\
    * {\
        border-color: #454248 !important ;\
        outline-color: #454248 !important ;\
        box-shadow: none !important ;\
    }";
    document.head.appendChild(style);
}
    
if (!privacy_supports_dark()) {
    privacy_make_dark();
}

"""
    
    public static let scroll = """
    if (location.host.includes("google.com")) {
        var style = document.createElement('style');
        style.innerHTML = ":root { overflow-y: visible !important; }";
        document.head.appendChild(style);
    } else if (location.host.includes("youtube.com")) {
        var style = document.createElement('style');
        style.innerHTML = "body { position: unset !important; }";
        document.head.appendChild(style);
    } else if (location.host.includes("instagram.com")) {
        var style = document.createElement('style');
        style.innerHTML = "body, .E3X2T { overflow: unset !important; }";
        document.head.appendChild(style);
    } else if (location.host.includes("reuters.com")) {
        var style = document.createElement('style');
        style.innerHTML = ":root, html, body { overflow: unset !important; }";
        document.head.appendChild(style);
    } else if (location.host.includes("thelocal.de")) {
        var style = document.createElement('style');
        style.innerHTML = ".tp-modal-open { overflow: unset !important; }";
        document.head.appendChild(style);
    } else if (location.host.includes("pinterest.com")) {
        var style = document.createElement('style');
        style.innerHTML = "body { overflow: unset !important; }";
        document.head.appendChild(style);
    }
"""
    
    public static let location = """
var locationSuccess = null;

function locationReceived(latitude, longitude, accuracy) {
    var position = {
        coords: {
            latitude: latitude,
            longitude: longitude,
            accuracy: accuracy
        }
    };

    if (locationSuccess != null) {
        locationSuccess(position);
    }

    locationSuccess = null;
}

navigator.geolocation.getCurrentPosition = function(success, error, options) {
    locationSuccess = success;
    window.webkit.messageHandlers.handler.postMessage('getCurrentPosition');
};

"""
}
