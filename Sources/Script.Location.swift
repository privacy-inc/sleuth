import Foundation

extension Script {
    static let location = """
var _privacy_incognit_location_success = null;

function _privacy_incognit_location_received(latitude, longitude, accuracy) {
    var position = {
        coords: {
            latitude: latitude,
            longitude: longitude,
            accuracy: accuracy
        }
    };

    if (_privacy_incognit_location_success != null) {
        _privacy_incognit_location_success(position);
    }

    _privacy_incognit_location_success = null;
}

navigator.geolocation.getCurrentPosition = function(success, error, options) {
    _privacy_incognit_location_success = success;
    webkit.messageHandlers.\(Message.location.rawValue).postMessage('_privacy_incognit_location_request');
};

"""
}
