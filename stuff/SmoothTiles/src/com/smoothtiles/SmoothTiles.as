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
		private var container:Sprite;
		private var player	:Player;
		private var player2	:Player;
		public var speed	:Number = 10;
		public function SmoothTiles()
		{
			container = new Sprite();
			createStuff();
			addEvents();
			this.addChild(container);
		}
		private function createStuff():void
		{
			input = Keyboard.getInstance();
			grid = new GridBuilder();
			container.addChild(grid.grid);
			player = new Player();
			player.x = 500;
			player.y = 300;
			container.addChild(player);
			trace("Index:",grid.getTileIndexByPos(player.x, player.y));
		}
		private function addEvents():void
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, input.handleKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, input.handleKeyUp);
			this.addEventListener(Event.ENTER_FRAME, updateTiles);
		}
		protected function updateTiles(event:Event):void
		{
			if (input.LEFT)
			{
				if (player.getLeftBorder() <= grid.tile_LEFT.getRightBorder() - speed && grid.tile_LEFT.getWalkable())
				{
					player.x-=speed;
				}
			}
			if (input.RIGHT)
			{
				if (player.getRightBorder() >= grid.tile_RIGHT.getLeftBorder() + speed && grid.tile_RIGHT.getWalkable())
				{
					player.x+=speed;
				}
			}
			if (input.UP)
			{
				if (player.getUpperBorder() >= grid.tile_UPPER.getBottomBorder() - speed && grid.tile_UPPER.getWalkable())
				{
					player.y-=speed;
				}
			}
			if (input.DOWN)
			{
				if (player.getBottomBorder() >= grid.tile_LOWER.getUpperBorder() + speed && grid.tile_LOWER.getWalkable())
				{
					player.y+=speed;
				}
			}
		}
	}
}