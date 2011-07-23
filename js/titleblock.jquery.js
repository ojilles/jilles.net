(function($) {
    $.titleBlock = {
        defaults: {
            removeTitle: false,
            thefontSize: "20px"
        }
    }
    
    $.fn.extend({
        titleBlock:function(config) {
            var config = $.extend({}, $.titleBlock.defaults, config);
            return this.each(function() {
                var theImage    = $(this),
                    removeTitle = config.removeTitle,
                    theFontSizeValue = config.thefontSize;

                theImage
                    .wrap("<div class='image'>")
                    .parent()
                    .append("<h5>&nbsp;</h5>")
                    .find("h5")
                    .html(theImage.attr('alt'))
                    .wrapInner("<span style='font-size:" + theFontSizeValue + "px;'></span>")
                    .find("br")
                    .before("<span class='spacer'>&nbsp;</span>")
                    .after("<span class='spacer'>&nbsp;</span>");
                    
                if (removeTitle) {
                    theImage
                        .removeAttr("title");
                }
            })
        }
    })
})(jQuery);
