import Foundation

public struct Scripts {
    public static let dark = """
function supports_dark() {
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
    var google_related_searches = ".JAC8bd *, ";
    var google_related_top = ".keP9hb, .XAOBve *, ";
    var google_result_images = "#media_result_group *, ";
    var google_result_video_big = ".twQ0Be *, ";
    var google_result_video_small = ".JWCxk *, .pP3ABc *, ";
    var google_images_square = ".c7cjWc, ";
    var google_images_circle = ".Qjibbc, ";
    var google_videos = ".N3nEGc *, ";
    var youtube_desktop = "#player *, ";
    var youtube_mobile = "#player-container-id *";
    
    var exclude = google_related_searches + google_related_top + google_result_images + google_result_video_big + google_result_video_small + google_images_square + google_images_circle + google_videos + youtube_desktop + youtube_mobile;
    var style = document.createElement('style');
    style.innerHTML = "*:not(" + exclude + ") { background-color: #252228 !important; color: #cecccf !important; border-color: #454248 !important ; }";
    document.head.appendChild(style);
}

"""
    
    public static let scroll = """
    if (location.host.includes("google.com") || location.host.includes("yahoo.com")) {
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
