var processor = (function(){
  
  var connection = $('#connection');
  
  // initializes the application, checks for user session
  // if user logged in => calls @loadApp
  // if user logged out => calls @loadIntro
  
  // usage: log('inside coolFunc',this,arguments);
  // http://paulirish.com/2009/log-a-lightweight-wrapper-for-consolelog/
  window.log = function(){
    log.history = log.history || [];   // store logs to an array for reference
    log.history.push(arguments);
    if(this.console){
      // console.log( Array.prototype.slice.call(arguments) );
    }
  };
  
  var init = function(){
    
    $.ajaxSetup({
      type: 'GET',
      timeout: 5000,
      dataType: 'json',
      error: function(){
        log('DEFAULT AJAX ERROR! (ajaxSetup)');
      }
    });
    
    $.ajax({
      url: 'admin/protect.php',
      success: function(data){
        if(data.error){
          console.log('error with protect');
        } else {
          console.log('success with protect');
          console.log(data)
        };
      }
    });
  };

  var loadIntro = function(){

    connection
      .load('admin/login.php form', function() {        
      });         
  };
  
  return {
    //log: log,
    loadIntro: loadIntro,
    //loadApp: loadApp
  };
})();


















