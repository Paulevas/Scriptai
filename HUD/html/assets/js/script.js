$(document).ready(function() {
    StartClock()
})

window.addEventListener('message', function(event) {
    const item = event.data
    
    if (item.action == "SetPlayerData") {
        SetPlayerData(item.data);
    } else if (item.action == "SetPostal") {
        SetPostal(item.postal);
    } else if (item.action == "SetOnline") {
        SetOnline(item.online)
    } else if (item.action == "SetAmmo") {
        SetAmmo(item.state, item.data)
    } else if (item.action == "SetFood") {
        SetFood(item.status);
    } else if (item.action == "SetWater") {
        SetWater(item.status);
    } else if (item.action == "SetRange") {
        SetRange(item.range)
    } else if (item.action == "SetMicState") {
        SetMicState(item.muted)
    } else if (item.action == "SetMicTalking") {
        SetMicTalking(item.talking)
    } else if (item.action == "Notify") {
        Notify(item.title, item.message, item.type, item.timeout)
    } else if (item.action == "Announce") {
        Announce(item.message, item.timeout)
    } else if (item.action == "HelpNotify") {
        HelpNotify(item.state, item.button, item.message)
    } else if (item.action == "SetHudState") {
        if (item.state) {
            $("body").fadeIn();
        } else {
            $("body").fadeOut();
        }
    }
})

function SetRange(range) {
    let ranges = document.getElementsByClassName("pon_mcr");

    if (range == 1) {
        ranges[0].classList.add('dotgreen');
        ranges[1].classList.remove('dotgreen');
        ranges[2].classList.remove('dotgreen');
        ranges[3].classList.remove('dotgreen');
    } else if (range == 2) {
        ranges[0].classList.add('dotgreen');
        ranges[1].classList.add('dotgreen');
        ranges[2].classList.remove('dotgreen');
        ranges[3].classList.remove('dotgreen');
    } else if (range == 3) {
        ranges[0].classList.add('dotgreen');
        ranges[1].classList.add('dotgreen');
        ranges[2].classList.add('dotgreen');
        ranges[3].classList.remove('dotgreen');
    } else if (range == 4) {
        ranges[0].classList.add('dotgreen');
        ranges[1].classList.add('dotgreen');
        ranges[2].classList.add('dotgreen');
        ranges[3].classList.add('dotgreen');
    }
}

function SetFood(status) {
    let cubes = document.querySelectorAll("#fooddot");

    if (status >= 0 && status <= 25) {
        cubes[1].classList.remove("activfood")
        cubes[2].classList.remove("activfood")
        cubes[3].classList.remove("activfood")
    } else if (status >= 25 && status <= 50) {
        cubes[2].classList.remove("activfood")
        cubes[3].classList.remove("activfood")
    } else if (status >= 50 && status <= 75) {
        cubes[3].classList.remove("activfood")
    }
}

function SetWater(status) {
    let cubes = document.querySelectorAll("#waterdot");

    if (status >= 0 && status <= 25) {
        cubes[1].classList.remove("activwater")
        cubes[2].classList.remove("activwater")
        cubes[3].classList.remove("activwater")
    } else if (status >= 25 && status <= 50) {
        cubes[2].classList.remove("activwater")
        cubes[3].classList.remove("activwater")
    } else if (status >= 50 && status <= 75) {
        cubes[3].classList.remove("activwater")
    }
}

function SetMicState(muted) {
    if (muted) {
        $("#micion").attr("src", "assets/images/red.png")
    } else {
        $("#micion").attr("src", "assets/images/micro.png")
    }
}

function SetMicTalking(talking) {
    if (talking) {
        $("#micion").attr("src", "assets/images/green.png")
    } else {
        $("#micion").attr("src", "assets/images/micro.png")
    }
}

function SetPlayerData(data) {
    $("#player_money").text(data.money.toLocaleString("en-EN") + "€")
    $("#player_bank").text(data.bank.toLocaleString("en-EN") + "€")
    $("#player-job-rank").text(data.job.rank)
    $("#player-job-label").text(data.job.label)
    $("#player-source").text(data.source)
}

function SetPostal(code) {
    $("#postal").text(code)
}

function SetOnline(online) {
    $("#player-online").text(online)
}


function SetAmmo(state, data) {
    if (state) {
        $(".ammo_wr").fadeIn();

        $(".wh_tx").text(data.clip);
        $(".gr_tx").text("/" + data.ammo);

    } else {
        $(".ammo_wr").fadeOut();
    }
}



function HelpNotify(state, button, message) {
    if (state) {
        $(".e_w").empty();
        $(".e_w").append(`
            <div class="ebx jlcn">${button}</div>
            <span>${message}</span>
        `)
        $(".e_w").fadeIn();
    } else {
        $(".e_w").fadeOut();
    }
}

function Announce(message, timeout) {
    $(".announce_w").empty();
    $(".announce_w").append(`
        <audio src="https://tobias.isfucking.pro/6AR2Ys.mp3" autoplay></audio>
        <div class="hd_an alcn">
            <img src="assets/images/callspeaker.png" alt="">
            <div class="rw_an clmn">
                <span>INFINITY-RP</span>
                <span>Announce</span>
            </div>
        </div>
        <span class="tx_an">${message}</span>
    `)
    $(".shadow_an").fadeIn();
    $(".announce_w").fadeIn();
    setTimeout(() => {
        $(".shadow_an").fadeOut();
        $(".announce_w").fadeOut();
    }, timeout);
}

var count = 1;

function Notify(title, message, variant, timeout) {
    const types = { success: "success", error: "error", warning: "warrning" };
    const imgtypes = { success: "hlgr", error: "hlre", warning: "hlye" };
    const type = types[variant] || "success";
    const imgtype = imgtypes[variant] || "hlgr";

    $(".notify_w").prepend(`
        <div class="notify_${type} clmn" id="notify-${count}">
            <div class="fl_nf alcn">
                <div class="rw_nf clmn">
                    <span>${title}</span>
                    <span>${message}</span>
                </div>
            </div>
            <div class="progress flex">
                <div class="value_progress"></div>
            </div>
        </div>
    `);

    var notifyel = $(`#notify-${count}`);
    var progressbar = notifyel.find(`.value_progress`);
    var timestart = Date.now();

    var interval = setInterval(function () {
        var timedone = Date.now() - timestart;
        var progress = (timedone / timeout) * 100;

        if (progress > 101) {
            clearInterval(interval);
            setTimeout(() => {
                if (variant == "team") {
                    notifyel.addClass("hidenotifyother");
                } else {
                    notifyel.addClass("hidenotify");
                }
            }, 150);
            setTimeout(() => {
                notifyel.remove();
            }, 600);
        } else {
            progressbar.css("width", `${progress}%`);
        }
    }, 10);

    count++;
}

function StartClock() {
    const today = new Date();
    let ds = today.getDate() + "." + (today.getMonth() + 1) + "." + today.getFullYear()
    let h = today.getHours();
    let m = today.getMinutes();
    m = checkTime(m);
    $("#date").text(ds)
    $("#time").text(h + ":" + m)
    setTimeout(StartClock, 1000);
}

function checkTime(i) {
    if (i < 10) { i = "0" + i };
    return i;
}