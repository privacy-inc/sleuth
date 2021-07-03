import Foundation

extension Script {
    static let location = """
var _privacy_location_success = null;

function _privacy_incognit_location_received(latitude, longitude, accuracy) {
    var position = {
        coords: {
            latitude: latitude,
            longitude: longitude,
            accuracy: accuracy
        }
    };

    if (_privacy_location_success != null) {
        _privacy_location_success(position);
    }

    _privacy_location_success = null;
}

navigator.geolocation.getCurrentPosition = function(success, error, options) {
    _privacy_location_success = success;
    webkit.messageHandlers.handler.postMessage('_privacy_incognit_location_request');
};

"""
}
