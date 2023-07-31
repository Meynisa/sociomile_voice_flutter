function connect(endPoint, secretKey){
  const element = document.createElement("div");
element.id = "testqq";
const el = document.getElementById("testqq"); // el will be null!

    var self = this
    var sociomile = new SocioVoice.Init({
        base_url:`${self.endPoint}`,secret_key:`${self.secretKey}`
    })
    
    // this.sociomile.on('sociomileEvent',function (event) {
    //   // ALL EVENT WILL FIRE HERE
    //   console.log('sociomileEvent', event)
    //   var el = document.getElementById('statusText')
    //   el.prepend(`(${event.event_group})`+event.type + ' => ' + event.message+ ' ('+ moment().format('DD/MM/YYYY, H:mm:ss')+')\n');

    //   if(event.event_group === 'ended' || event.event_group === 'failed'){
    //     self.isDial = false
    //     self.callConnected = false
    //   }
    //   if(event.event_name === 'on_registered'){
    //     self.isRegistered = true
    //   }
    //   if(event.event_name === 'on_disconnected'){
    //     self.isRegistered = false
    //   }
    //   if(event.event_name === 'accepted'){
    //     self.callConnected = true
    //   }
    //   if(event.event_group === 'authentication'){
    //     self.isAuth = event.data.authenticated
    //   }
    // })
    sociomile.start()
    return endPoint + secretKey;
  }

connect("endpoint","secret");

// function add(firstNumber, secondNumber){
//   return firstNumber + secondNumber;
// }
// add(1,1);