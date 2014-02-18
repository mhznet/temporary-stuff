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
	
	[SWF(width="960",height="750",frameRate="24",backgroundColor="#BBBBBB")]
	public class SmoothTiles extends Sprite
	{
		private var input	:Keyboard;
		private var grid	:GridBuilder;
		private var container:Sprite;
		private var player	:Player;
		public var speed	:Number = 10;
		public var dist		:Number = 0;
		public var currentRow	:int = 1;
		public var currentColumn:int = 2;
		public var update	:Function;
		private var moveByTile	:Boolean = false;
		
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
		private function inputDown(p_tile:GenericTile):void
		{
			var downTile:GenericTile = grid.getTile(currentRow + 1, currentColumn);
			if (downTile)
			{
				if (!moveByTile)
				{
					if (downTile.isType(downTile.TYPE_CLEAR) || player.getBottomLeftPoint().y + speed <= downTile.getUpperLeftPoint().y)
					{
						player.setY(+speed);
						if (player.getMiddlePoint().y + speed >= downTile.getUpperLeftPoint().y)
						{
							currentRow++;
						}
					}
				}
				else
				{
					if (downTile.isType(downTile.TYPE_CLEAR))
					{
						player.y += grid.tileSize;
						currentRow++;
					}
					else if (downTile.isType(downTile.TYPE_U2R_SLOPE))
					{
						player.x -= grid.tileSize;
						player.y += grid.tileSize;
						currentColumn--;
						currentRow++;
					}
				}
			}
		}
		
		private function inputUp(p_tile:GenericTile):void
		{
			var upTile:GenericTile = grid.getTile(currentRow - 1, currentColumn);
			if (upTile)
			{
				if (!moveByTile)
				{
					if (upTile.isType(upTile.TYPE_CLEAR) || player.getUpperLeftPoint().y - speed >= upTile.getBottomLeftPoint().y)
					{
						player.setY(-speed);
						if (player.getMiddlePoint().y - speed <= upTile.getBottomLeftPoint().y)
						{
							currentRow--;
						}
					}
				}
				else
				{
					if (upTile.isType(upTile.TYPE_CLEAR))
					{
						player.y -= grid.tileSize;
						currentRow--;
					}
					else if (upTile.isType(upTile.TYPE_U2R_SLOPE))
					{
						player.x -= grid.tileSize;
						player.y -= grid.tileSize;
						currentColumn--;
						currentRow--;
					}
				}
			}
		}
		
		private function inputRight(p_tile:GenericTile):void
		{
			var rTile:GenericTile = grid.getTile(currentRow, currentColumn +1);
			if (rTile)
			{
				if (!moveByTile)
				{
					if (rTile.isType(rTile.TYPE_CLEAR) || player.getUpperRightPoint().x + speed <= rTile.getUpperLeftPoint().x)
					{
						player.setX(+speed);
						if (player.getMiddlePoint().x + speed >= rTile.getUpperLeftPoint().x)
						{
							currentColumn++;
						}
					}
					else if (rTile.isType(rTile.TYPE_U2R_SLOPE))
					{
						/*if ((player.getRightBorder() + speed <= rTile.getMiddlePoint().x) || player.getUpperBorder() + speed <= rTile.getBottomBorder())
						{
							player.setX(+speed);
							player.setY(+speed);
							if (player.getLeftBorder() + speed >= rTile.getLeftBorder())
							{
								currentColumn++;
							}
						}*/
					}
				}
				else
				{
					if (rTile.isType(rTile.TYPE_CLEAR))
					{
						player.x += grid.tileSize;
						currentColumn++;
					}
					else if (rTile.isType(rTile.TYPE_U2R_SLOPE))
					{
						player.x += grid.tileSize;
						player.y += grid.tileSize;
						currentColumn++;
						currentRow++;
					}
				}
			}
		}
		
		private function inputLeft(p_tile:GenericTile):void
		{
			var lTile:GenericTile = grid.getTile(currentRow, currentColumn -1); 
			if (lTile)
			{
				if (!moveByTile)
				{
					if (lTile.isType(lTile.TYPE_CLEAR) || player.getUpperLeftPoint().x - speed >= lTile.getUpperRightPoint().x)
					{
						player.setX(-speed); 
						if (player.getMiddlePoint().x - speed <= lTile.getUpperRightPoint().x)
						{
							currentColumn--;
						}
					}
				}
				else
				{
					if (lTile.isType(lTile.TYPE_CLEAR))
					{
						player.x -= grid.tileSize;
						currentColumn--;
					}
					else if (lTile.isType(lTile.TYPE_U2R_SLOPE))
					{
						player.x -= grid.tileSize;
						player.y += grid.tileSize;
						currentColumn--;
						currentRow++;
					}
				}
			}
		}
	}
}