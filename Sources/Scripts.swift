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
        ".AldPpe *",                        //// result youtube video
        ".c7cjWc",                          //// images square
        ".Qjibbc",                          //// images circle
        ".fWhgmd",                          //// images group
        ".N3nEGc *",                        //// videos
                                            // Wikipedia
        ".ext-related-articles-card a",     //// related articles
                                            // Instagram
        "._9AhH0",                          //// image
        ".v1Nh3 *, .kIKUG *, ._bz0w *"      //// thumbnail
    ];
    var style = document.createElement('style');
    style.innerHTML = "*:not(" + exclude.join(", ") + ") { background-color: #252228 !important; border-color: #454248 !important ; outline-color: #454248 !important ; box-shadow: none !important; } *:not(a) { color: #cecccf !important; } a, a *, a:link *, a:visited *, a:hover *, a:active * { color: #7caadf !important; }";
    document.head.appendChild(style);
}

"""
    
    public static let scroll = """
    if (location.host.includes("google.com")) {
        var style = document.createElement('style');
        style.innerHTML = ":root { overflow-y: visible !important; }";
        document.head.appendChild(style);
    }

    if (location.host.includes("instagram.com")) {
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
