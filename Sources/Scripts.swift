import Foundation

public struct Scripts {
    public static let dark = """
function supports_dark() {
    if (document.documentElement.getAttribute("dark") == "true") { // youtube
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

if (!supports_dark()) {
    var exclude = [
                                            // Google
        ".JAC8bd *",                        //// related searches
        ".keP9hb, .XAOBve *",               //// related top
        "#media_result_group *",            //// result images
        ".twQ0Be *",                        //// result video big
        ".JWCxk *, .pP3ABc *",              //// result video small
        ".c7cjWc",                          //// images square
        ".Qjibbc",                          //// images circle
        ".N3nEGc *"                         //// videos
    ];
    var style = document.createElement('style');
    style.innerHTML = "*:not(" + exclude.join(", ") + ") { background-color: #252228 !important; color: #cecccf !important; border-color: #454248 !important ; }";
    document.head.appendChild(style);
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
