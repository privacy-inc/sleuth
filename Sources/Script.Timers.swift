import Foundation

extension Script {
    static let timers = """
var _privacy_incognit_timeout = setTimeout;

setTimeout = function(x, y) {
    return -1;
}

var id = _privacy_incognit_timeout(function() { }, 0);
_privacy_incognit_timeout = null;

while (id--) {
    clearTimeout(id);
}

"""
}
