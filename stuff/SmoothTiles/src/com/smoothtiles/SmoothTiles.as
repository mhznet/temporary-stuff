package com.smoothtiles
{
	import com.smoothtiles.grid.GridBuilder;
	import com.smoothtiles.input.Keyboard;
	import com.smoothtiles.player.Player;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	
	[SWF(width="704",height="704",frameRate="24",backgroundColor="#BBBBBB")]
	public class SmoothTiles extends Sprite
	{
		private var input	:Keyboard;
		private var grid	:GridBuilder;
		private var container:Sprite;
		private var player	:Player;
		private var player2	:Player;
		public var speed	:Number = 10;
		public var currentRow	:int = 5;
		public var currentColumn:int = 3;
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
			var point:Point = grid.getTilePoint(currentRow,currentColumn);
			grid.updateRelativeTiles(currentRow,currentColumn);
			player.setX(point.x, false);
			player.setY(point.y, false);
			container.addChild(player);
		}
		private function addEvents():void
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, input.handleKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, input.handleKeyUp);
			this.addEventListener(Event.ENTER_FRAME, updateTiles);
		}
		protected function updateTiles(event:Event):void
		{
			//Atualizar as currentRow e currentColumn, comparando o ponto esquerdo/direito/cima/baixo do player com o hit dos tiles ao seu redor.
			if (input.LEFT)
			{
				player.setX(-speed);
			}
			if (input.RIGHT)
			{
				player.setX(+speed);
			}
			if (input.UP)
			{
				player.setY(-speed);
			}
			if (input.DOWN)
			{
				player.setY(+speed);
			}
		}
	}
}