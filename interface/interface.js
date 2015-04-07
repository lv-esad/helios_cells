$(function () {

	// map jQuery wrapped
	var map = $('#map');

	//
	// Spacebrew client options
	// you need to change using your server IP address
	var spacebrewClient,
		SERVER = '172.20.10.3',
		CLIENT_NAME = 'interface',
		CLIENT_DESCRIPTION = 'send touch position',
		PORT = 9000,
		SESSION_ID = Date.now(); // default spacebrew port is 9000

	// setup new Spacebrew client
	function SetupSpacebrew(){
		$('body').removeClass('open');

		if(!_.isUndefined(spacebrewClient)){
			spacebrewClient.close();
		}

		spacebrewClient = new Spacebrew.Client(SERVER, CLIENT_NAME, CLIENT_DESCRIPTION, PORT);

		// publish and subscribe
		spacebrewClient.addPublish('position', 'string', 'unknow position');
		spacebrewClient.addPublish('message', 'string', 'unknow message');
		spacebrewClient.addSubscribe('command', 'string');
		// toggle open when signal is opened
		spacebrewClient.onOpen = function () {
			$('#SERVER').val(SERVER);
			$('body').addClass('open');
		};
		spacebrewClient.onClose = function () {
			$('body').removeClass('open');
		};
		spacebrewClient.onStringMessage(function(e,t){
			alert(t);
			spacebrewClient.send('message','string',t);
		});

		// connect Spacebrew
		spacebrewClient.connect();
	}

	SetupSpacebrew();

	// Send a position
	function SendPosition(x, y, uid, color) {
		var position = {
			x: x,
			y: y,
			color: color,
			uid: uid,
			timestamp: Date.now()
		};
		spacebrewClient.send('position', 'string', JSON.stringify(position));
	}

	// mouse event
	map.on('mousemove', function (e) {
		return false;
	});

	// touch event
	$(document).on('touchmove', function (e) {
		return false;
	});

	// Snap SVG

	var paper = Snap('#map'),
		GRID_SIZE = 5,
		GRID_X = 160,
		GRID_Y = 140,
		PAPER_WIDTH = GRID_X* GRID_SIZE, // 800
		PAPER_HEIGHT = GRID_Y* GRID_SIZE, // 700
		scale = 1,
		offset = {x:0,y:0},
		portrait = false
	;

	// Bind Resize events
	function Resize() {
		portrait = paper.node.clientHeight / paper.node.clientWidth > GRID_Y / GRID_X;
		scale = portrait ? paper.node.clientWidth / PAPER_WIDTH : paper.node.clientHeight / PAPER_HEIGHT;
		offset.x = offset.y = 0;
		if (portrait) {
			offset.y = (paper.node.clientHeight - PAPER_HEIGHT * scale) / 2;
		} else {
			offset.x = (paper.node.clientWidth - PAPER_WIDTH * scale) / 2;
		}
		console.log(scale, portrait, offset);
	}
	$(window).resize(Resize);
	Resize();
	setTimeout(Resize,100);



	// Draw Grid
	var gridOptions = {
		stroke: '#000',
		strokeOpacity: .1,
		strokeWidth: 1
	};
	/*for(var x=0; x<=GRID_X; x++){
		paper.line(x*GRID_SIZE,0,x*GRID_SIZE, PAPER_HEIGHT)
			.attr(gridOptions);
	}
	for(var y=0; y<=GRID_Y; y++){
		paper.line(0,y*GRID_SIZE,PAPER_WIDTH,y*GRID_SIZE)
			.attr(gridOptions);
	}*/

	// blocks
	var blocksWrapper = paper.group(), // define a group wrapper
		handler = paper.rect(0,0,PAPER_WIDTH,PAPER_HEIGHT).attr({fill:'rgba(0,0,0,0)'});

	//
	function GlobalToLocal(position){
		// convert viewport position to grid position
		return {
			x:Math.round((position.x/scale-offset.x)/GRID_SIZE),
			y:Math.round((position.y/scale-offset.y)/GRID_SIZE)
		}
	}
	//
	function RandomColor(){
		var randomColor = Math.floor(Math.random() * 16777215).toString(16);
		while (randomColor.length < 6) {randomColor = '0' + randomColor}
		return  '#' + randomColor;
	}
	//
	var touchesID, touchUID = 0;
	function GenerateTouchIdentification(){
		touchesID = [];
		for(var i=0; i<12; i++){ // 12 fingers !
			touchesID[i] = {color:RandomColor(),uid:touchUID};
			touchUID ++;
		}
	}
	//
	function AddPosition(point,touch){
		// add position
		var position = {
			x:point.x,
			y:point.y,
			rect:paper.rect(point.x*GRID_SIZE,point.y*GRID_SIZE,GRID_SIZE,GRID_SIZE).attr({fill: touchesID[touch].color,opacity:.1})
		};
		SendPosition(position.x, position.y, touchesID[touch].uid, touchesID[touch].color);
	}
	//
	//
	paper.touchstart(function(e){
		GenerateTouchIdentification();
	});
	//
	paper.touchmove(function(e){
		_(e.changedTouches).each(function(touch,key){
			console.log(e);
			var point = GlobalToLocal({x:touch.pageX,y:touch.pageY});
			if(!(point.x<0 || point.y<0 || point.x>=GRID_X || point.y>=GRID_Y)){
				AddPosition(point,key);
			}
		})
	});

	var emergency = paper.rect(-100,0,100,100).attr({fill:'transparent'}), emergencyTouch = 0,
		emergencyTimeout;
	emergency.touchstart(function(){
		emergencyTouch++;
		clearTimeout(emergencyTimeout);
		if(emergencyTouch==10){
			$('.modal').fadeIn();
		}
		emergencyTimeout = setTimeout(function () {
			emergencyTouch = 0
		}, 1000);
	});

	function CloseModal(){
		$('.modal').fadeOut();
	}
	$('.modal .close').click(CloseModal);
	$('form.server').submit(function(){
		CloseModal();
		SERVER = $('#SERVER').val();
		SetupSpacebrew();
		return false;
	})

});