import Foundation

extension Script {
    static let location = """
var locationSuccess = null;

function _privacy_incognit_location_received(latitude, longitude, accuracy) {
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
    webkit.messageHandlers.handler.postMessage('_privacy_incognit_location_request');
};

"""
}
