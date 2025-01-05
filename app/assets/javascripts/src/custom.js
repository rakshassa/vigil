import 'jquery'
import 'jquery_ujs'
import 'jquery-hotkeys'

var store_bindings = function(bound) {
    sessionStorage.setItem('keybind_handlers', JSON.stringify(bound));
};

var ready = function() {
    // alert("url change");

    // Unbind every event with the namespace: .hotkeys
    $(document).unbind('.hotkeys');

    var bound = [];

    $('[data-hotkey]').each(function() {
        var element = $(this);
        var hotkey = element.data('hotkey').toString();
        var unique_id = element.attr('id');
        console.log("Hotkey: " + hotkey + " for " + element.attr("href") + " on id: " + unique_id);
        if (hotkey != null) {
            // bind under a namespace so we can easily unbind all of them later.
            $(document).bind('keydown.hotkeys', hotkey, function() {
                console.log("hotkey pressed for " + element.attr("href"));
                element.get(0).click();
            });
        }
    });
};

$(document).on('turbo:load', ready);

// Below is the full set of events I tried when attempting to trigger on url change with turbolinks
// If we have any trouble with hotkeys not triggering, this is likely the place to start.

// $(document).on('page:load', ready);
// $(document).on('page:change', ready);
// $(document).on('turbolinks:load', ready);

// $(window).on('load', function() {
//     alert("window loading 2");
// });

// $(window).unload(function() {
//     alert("window unloading");
// });

// $(window).on('hashchange', function(e){
//     alert("url change");

//     $(document).unbind('keydown'); // unbinds *all* keydown handers on the document

//     $('[data-hotkey]').each(function() {
//         var element = $(this);
//         var hotkey = element.data('hotkey')

//         $(document).bind('keydown', hotkey, function() {
//             element.get(0).click();
//         });
//     });
// });

// $(window).on('popstate', function(e) {
//     alert("pop state");
// });

// $(history).on('pushstate', function(e) {
//     alert("push state");
// });

// $(document).ready(function() {
//     alert("loading page");
// });
