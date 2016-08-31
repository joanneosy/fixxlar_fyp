function intercom(user_name, user_email, staffID, phone_number, workshop_name, categories, brands_carried) {

    window.intercomSettings = {
           app_id: "zaimqowd",
           name: user_name, // Full name
           email: user_email, // Email address
           staff_id: staffID, // Staff ID
           phone_number: phone_number, // Staff Number
           workshop: workshop_name, // Workshop Name
           categories: categories, // Categories
           brand_carried: brands_carried, // Brands carried
           // created_at: 1312182000 // Signup date as a Unix timestamp
        //   hide_default_launcher: false
     };
    (function () {
        var w = window;
        var ic = w.Intercom;
        if (typeof ic === "function") {
            ic('reattach_activator');
            ic('update', intercomSettings);
        } else {
            var d = document;
            var i = function () {
                i.c(arguments)
            };
            i.q = [];
            i.c = function (args) {
                i.q.push(args)
            };
            w.Intercom = i;
            function l() {
                var s = d.createElement('script');
                s.type = 'text/javascript';
                s.async = true;
                s.src = 'https://widget.intercom.io/widget/zaimqowd';
                var x = d.getElementsByTagName('script')[0];
                x.parentNode.insertBefore(s, x);
            }
            if (w.attachEvent) {
                w.attachEvent('onload', l);
            } else {
                w.addEventListener('load', l, false);
            }
        }
    })()
}


