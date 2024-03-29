(function(a) {
	a.event.special.textchange = {
		setup : function() {
			a(this).bind("keyup", a.event.special.textchange.handler);
			a(this).bind("cut paste input",
					a.event.special.textchange.delayedHandler)
		},
		teardown : function() {
			a(this).unbind("keyup", a.event.special.textchange.keyuphandler);
			a(this).unbind("cut", a.event.special.textchange.cuthandler)
		},
		handler : function() {
			a.event.special.textchange.triggerIfChanged(a(this))
		},
		delayedHandler : function() {
			var b = a(this);
			setTimeout(function() {
				a.event.special.textchange.triggerIfChanged(b)
			}, 25)
		},
		triggerIfChanged : function(b) {
			if (b.val() !== b.data("lastValue")) {
				b.trigger("textchange", b.data("lastValue"));
				b.data("lastValue", b.val())
			}
		}
	};
	a.event.special.hastext = {
		setup : function() {
			a(this).bind("textchange", a.event.special.hastext.handler)
		},
		teardown : function() {
			a(this).unbind("textchange", a.event.special.hastext.handler)
		},
		handler : function(b, c) {
			a.event.special.hastext.check(a(this), c)
		},
		check : function(b, c) {
			if ((c === "" || c === undefined) && c !== b.val())
				b.trigger("hastext")
		}
	};
	a.event.special.notext = {
		setup : function() {
			a(this).bind("textchange", a.event.special.notext.handler)
		},
		teardown : function() {
			a(this).unbind("textchange", a.event.special.notext.handler)
		},
		handler : function(b, c) {
			a(this).val() === "" && a(this).val() !== c
					&& a(this).trigger("notext")
		}
	}
})(jQuery);