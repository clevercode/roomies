// usage: log('inside coolFunc', this, arguments);
// paulirish.com/2009/log-a-lightweight-wrapper-for-consolelog/
window.log = function(){
  log.history = log.history || [];   // store logs to an array for reference
  log.history.push(arguments);
  if(this.console) console.log( Array.prototype.slice.call(arguments) );
};



// place any jQuery/helper plugins in here, instead of separate, slower script files.

// equalHeights Plugin
// https://gist.github.com/915094

(function($){
	$.fn.equalHeights = function() {
		var tallest = 0,
			current = 0;
		this.each(function(){
			current = $(this).height();
			if(current > tallest) {
				tallest = current;
			}
		});
		return this.height(tallest);
	};
})(jQuery);

