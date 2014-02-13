package com.smoothtiles
{
	import com.smoothtiles.abstracttile.GenericTile;
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
		public var speed	:Number = 10;
		public var currentRow	:int = 1;
		public var currentColumn:int = 2;
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
			grid.updateCurrentRowAndColumn(currentRow,currentColumn);
			player.setX(point.x, false);
			player.setY(point.y, false);
			trace (grid.gridArray[0][0].width,grid.gridArray[0][0].height,grid.gridArray[0][0].x, grid.gridArray[0][0].y);
			grid.grid.addChild(player);
		}
		private function addEvents():void
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, input.handleKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, input.handleKeyUp);
			this.addEventListener(Event.ENTER_FRAME, updateTiles);
		}
		protected function updateTiles(event:Event):void
		{
			grid.updateCurrentRowAndColumn(currentRow,currentColumn);
			var p_tile:GenericTile = grid.getTile(currentRow,currentColumn);
			if (input.LEFT)
			{
				inputLeft(p_tile);
			}
			if (input.RIGHT)
			{
				inputRight(p_tile);
			}
			if (input.UP)
			{
				inputUp(p_tile);
			}
			if (input.DOWN)
			{
				inputDown(p_tile);
			}
		}
		
		private function inputLeft(p_tile:GenericTile):void
		{
			var lTile:GenericTile = grid.getTile(currentRow, currentColumn -1); 
			if (lTile && p_tile.isType(p_tile.TYPE_CLEAR))
			{
				if (lTile.isType(lTile.TYPE_CLEAR) || player.getLeftBorder() - speed >= lTile.getRightBorder())
				{
					player.setX(-speed); 
					if (player.getMiddlePoint().x - speed <= lTile.getRightBorder() )
					{
						currentColumn--;
					}
				}
			}
		}
		
		private function inputDown(p_tile:GenericTile):void
		{
			var downTile:GenericTile = grid.getTile(currentRow + 1, currentColumn);
			if (downTile)
			{
				if (downTile.isType(downTile.TYPE_CLEAR) || player.getBottomBorder() + speed <= downTile.getUpperBorder())
				{
					player.setY(+speed);
					if (player.getMiddlePoint().y + speed >= downTile.getUpperBorder())
					{
						currentRow++;
					}
				}
			}
		}
		
		private function inputUp(p_tile:GenericTile):void
		{
			var upTile:GenericTile = grid.getTile(currentRow - 1, currentColumn);
			if (upTile && p_tile.isType(p_tile.TYPE_CLEAR))
			{
				if (upTile.isType(upTile.TYPE_CLEAR) || player.getUpperBorder() - speed >= upTile.getBottomBorder())
				{
					player.setY(-speed);
					if (player.getMiddlePoint().y - speed <= upTile.getBottomBorder())
					{
						currentRow--;
					}
				}
			}
		}
		
		private function inputRight(p_tile:GenericTile):void
		{
			var rTile:GenericTile = grid.getTile(currentRow, currentColumn +1);
			if (rTile && p_tile.isType(p_tile.TYPE_CLEAR))
			{
				if (rTile.isType(rTile.TYPE_CLEAR) || player.getRightBorder() + speed <= rTile.getLeftBorder())
				{
					player.setX(+speed);
					if (player.getMiddlePoint().x + speed >= rTile.getLeftBorder())
					{
						currentColumn++;
					}
				}
				else if (rTile.isType(rTile.TYPE_1ST_SLOPE))
				{
					if ((player.getRightBorder() + speed <= rTile.getMiddlePoint().x) || player.getUpperBorder() + speed <= rTile.getBottomBorder())
					{
						player.setX(+speed);
						player.setY(+speed);
						if (player.getLeftBorder() + speed >= rTile.getLeftBorder())
						{
							currentColumn++;
						}
					}
				}
				else
				{
					if (p_tile.isType(p_tile.TYPE_1ST_SLOPE) && player.getUpperBorder() + speed <= p_tile.getMiddlePoint().y)
					{
						player.setX(+speed);
						player.setY(+speed);
					}
					else if (player.getLeftBorder() + speed >= rTile.getLeftBorder())
					{
						/*{
							currentColumn++;
							currentRow++;
						}*/
					}
				}
			}
		}
	}
}