var WebService = function() {};

WebService.prototype = {
    run: function(arguments) {
        arguments.completionFunction({
            "title": document.title,
            "url": document.URL,
//            "hostname": document.location.hostname
        });
    }
};

var ExtensionPreprocessingJS = new WebService;
