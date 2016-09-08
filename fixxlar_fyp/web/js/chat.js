
var ortcClient;
var subscribeList = [];

subscribeChat = function (requestID, wsID, userName, chatToken, log) {
    if (subscribeList.indexOf(requestID) < 0) {
        loadOrtcFactory(IbtRealTimeSJType, function (factory, error) {
            if (error !== null) {
                alert("Factory error: " + error.message);
            } else {
                if (factory !== null) {
                    ortcClient = factory.createClient();

                    ortcClient.setId('clientId');
                    ortcClient.setConnectionMetadata('clientConnMeta');
                    ortcClient.setClusterUrl('http://ortc-developers.realtime.co/server/2.1');

                    ortcClient.onConnected = function (ortc) {
                        //$("#log").text("Connected to " + ortcClient.getUrl() + " using " + ortcClient.getProtocol());
                        subscribeList.push(requestID);
                        ortcClient.subscribe('Chat:Request:' + requestID + ":" + wsID, true, function (ortc, channel, message) {
                            var channelArr = channel.split(":");
                            var reqID = channelArr[2];
                            //Handle notification w.r.t. reqID(ServiceID)
//                    $("#log").html(message + "<br><br>" + $("#log").html());
                            var sender = message.substring(0, message.indexOf(":"));
                            var amessage = message.substring(message.indexOf(":") + 1);
                            message = amessage.substring(amessage.indexOf(":") + 1);
//                            console.log(sender);
//                            console.log(message);
                            var monthNames = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"];
                            var date = new Date();
                            var day = date.getDate();
                            var monthIndex = date.getMonth();
                            var year = date.getFullYear();
                            var hour = date.getHours();
                            var minutes = date.getMinutes();

                            var time = year + "-" + monthNames[monthIndex] + "-" + day + " " + hour + ":" + minutes;

//                        console.log(day, monthNames[monthIndex], year);

                            if (sender == "0") {
                                $("#" + log).html($("#" + log).html() + '<li class="message sent"><div class="media"><div class="pull-left user-avatar"><img class="media-object img-circle" src="images/profile-photo.jpg"></div><div class="media-body"><p class="media-heading"><a href="#">You</a> <span class="time">' + time + '</span></p>' + message + '</div></div></li>');
                            } else {
                                $("#" + log).html($("#" + log).html() + '<li class="message receive"><div class="media"><div class="pull-left user-avatar"><img class="media-object img-circle" src="images/profile-photo.jpg"></div><div class="media-body"><p class="media-heading"><a href="#">' + userName + '</a> <span class="time">' + time + '</span></p>' + message + '</div></div></li>');
                                displayNotification(requestID, message);
                                
                            }
//                    $("#log").html(message + '<li class="message sent"><div class="media"><div class="pull-left user-avatar"><img class="media-object img-circle" src="assets/images/profile-photo.jpg"></div><div class="media-body"><p class="media-heading"><a href="#">John Douey</a> <span class="time">26.3.2014 18:38</span></p>' + $("#log").html() + '</div></div></li>');
                            flashDiv("#log");

                        });
                    };

                    ortcClient.onException = function (client, event) {
                        $("#log").html("Error: " + event + "<br>" + $("#log").html());
                    }

                    // Get your own application key at https://accounts.realtime.co/signup/
                    applicationKey = 'D3omir';

                    ortcClient.connect(applicationKey, chatToken);
                }
            }
        });
    }
};

sendMsg = function (requestID, wsName, shopID, staffID, token, topicID, firstMsg, msgInput) {
    var inputMsg = "0:" + shopID + ":" + $("#" + msgInput).val();
//    var channel = 'Chat:Workshop:' + shopID + ':' + userID;
//    ortcClient.send(channel, inputMsg);
    $('#' + msgInput).val("");

    var channel = 'Chat:Request:' + requestID;
    if (firstMsg == false) {
        channel = channel + ":" + shopID;
    }
    $.ajax({
        type: 'POST',
        url: 'http://119.81.43.85/chat/send_chat_message',
        crossDomain: true,
        data: {
            "channel_name": channel,
            "topic_id": topicID,
            "staff_id": staffID,
            "token": token,
            "message": inputMsg
        },
        dataType: 'json',
        success: function (data) {
//            console.log(data);
            if (data.is_success == true) {
                var topicID = data.payload.topic_id;
                var ele = $(".md-show").find(".sent");
//                $(".md-show").find(".chatTopic").id = topicID;
                ele.addClass(topicID);
                $(".md-show").find(".ct").html('<div class="hidden chatTopic" id="' + topicID + '"></div>');

            }
        },
        error: function (data) {
            console.log("Error:" + data);
        }
    });

}

clearElement = function (e) {
    $(e).text("");
}

flashDiv = function (e) {
    $(e).fadeOut(100).fadeIn(100);
}

function displayNotification(requestID, message) {
   $.jGrowl(message, {header: "ID: " + requestID, life: 10000});
}