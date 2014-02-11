package com.smoothtiles
{
	import com.smoothtiles.grid.GridBuilder;
	import com.smoothtiles.input.Keyboard;
	import com.smoothtiles.player.Player;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	[SWF(width="704",height="704",frameRate="24",backgroundColor="#BBBBBB")]
	public class SmoothTiles extends Sprite
	{
		private var input	:Keyboard;
		private var grid	:GridBuilder;
		private var player	:Player
		public function SmoothTiles()
		{
			createStuff();
			addEvents();
		}
		private function createStuff():void
		{
			input = Keyboard.getInstance();
			grid = new GridBuilder();
			this.addChild(grid.grid);
			player = new Player(10);
			player.x = 300;
			player.y = 450;
			this.addChild(player);
		}
		private function addEvents():void
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, input.handleKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, input.handleKeyUp);
			this.addEventListener(Event.ENTER_FRAME, updateTiles);
		}
		protected function updateTiles(event:Event):void
		{
			player.update();
		}
	}
}