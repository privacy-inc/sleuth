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
        const color = getComputedStyle(element).getPropertyValue("background-color");
        const gradient = getComputedStyle(element).getPropertyValue("background").includes("gradient");
        const parts = color.match(/[\\d.]+/g);
    
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
    *:not(a) {\
        color: #cecccf !important;\
    }\
    a, a *, a:link *, a:visited *, a:hover *, a:active * {\
        color: #7caadf !important ;\
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
