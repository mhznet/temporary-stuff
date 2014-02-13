package com.smoothtiles.grid
{
	import com.smoothtiles.abstracttile.GenericTile;
	
	import flash.display.Sprite;
	import flash.geom.Point;

	public class GridBuilder
	{
		public const UPPER		:String = "UPPER";
		public const UPPER_RIGHT:String = "U_RIGHT";
		public const UPPER_LEFT	:String = "U_LEFT";
		public const LOWER		:String = "LOWER";
		public const LOWER_LEFT	:String = "L_LEFT";
		public const LOWER_RIGHT:String = "L_RIGHT";
		public const LEFT		:String = "LEFT";
		public const RIGHT		:String = "RIGHT";
		public const PLAYER		:String = "PLAYER";
		
		public var tile_UPPER		:GenericTile;
		public var tile_UPPER_RIGHT	:GenericTile;
		public var tile_UPPER_LEFT	:GenericTile;
		public var tile_LOWER		:GenericTile;
		public var tile_LOWER_LEFT	:GenericTile;
		public var tile_LOWER_RIGHT	:GenericTile;
		public var tile_LEFT		:GenericTile;
		public var tile_RIGHT		:GenericTile;
		public var tile_PLAYER		:GenericTile;
		
		public var grid			:Sprite;
		public var activeTile	:Number;
		public var tileSize		:Number = 50;
		public var columns		:int = 14;
		public var rows			:int = 14;
		public var vectorGeral	:Vector.<GenericTile>;
		public var gridArray	:Array;
		public var gridVector	:Array = new Array
			("O","O","O","O","O","O","O","O","O","O","O","O","O","O",
			 "O","O","C","C","C","C","C","C","C","C","C","C","O","O",
			 "O","C","C","C","C","C","C","C","C","C","C","C","C","O",
			 "O","C","C","C","C","C","C","C","C","C","C","C","C","O",
			 "O","C","C","C","C","O","O","O","O","C","C","C","C","O",
			 "O","C","C","C","C","O","C","C","O","C","C","C","C","O",
			 "O","C","C","C","C","O","C","C","O","C","C","C","C","O",
			 "O","C","C","C","C","O","O","O","O","C","C","C","C","O",
			 "O","C","C","C","C","C","C","C","C","C","C","C","C","O",
			 "O","C","C","C","C","C","C","C","C","C","C","C","C","O",
			 "O","C","C","C","C","C","C","C","C","C","C","C","C","O",
			 "O","C","C","C","C","C","C","C","C","C","C","C","C","O",
			 "O","O","C","C","C","C","C","C","C","C","C","C","O","O",
			 "O","O","O","O","O","O","O","O","O","O","O","O","O","O");
		
		public function GridBuilder()
		{
			buildFromVector(gridVector);
			grid.x = 27;
			grid.y = 27;
		}
		public function updateRelativeTiles(row:int,column:int):void
		{
			if(tile_PLAYER) tile_PLAYER.updateSecondTF("");
			tile_PLAYER = gridArray[row][column];
			tile_PLAYER.updateSecondTF(PLAYER);
			
			if(tile_LEFT) tile_LEFT.updateSecondTF("");
			if (gridArray[tile_PLAYER.row][tile_PLAYER.column - 1])
			{
				tile_LEFT = gridArray[tile_PLAYER.row][tile_PLAYER.column - 1];
				tile_LEFT.updateSecondTF(LEFT);
			}
			if(tile_RIGHT) tile_RIGHT.updateSecondTF("");
			if (gridArray[tile_PLAYER.row][tile_PLAYER.column + 1])
			{
				tile_RIGHT = gridArray[tile_PLAYER.row][tile_PLAYER.column + 1];
				tile_RIGHT.updateSecondTF(RIGHT);
			}
			if(tile_UPPER) tile_UPPER.updateSecondTF("");
			if (gridArray[tile_PLAYER.row - 1][tile_PLAYER.column])
			{
				tile_UPPER = gridArray[tile_PLAYER.row - 1][tile_PLAYER.column];
				tile_UPPER.updateSecondTF(UPPER);
			}
			if(tile_UPPER_LEFT) tile_UPPER_LEFT.updateSecondTF("");
			if (gridArray[tile_PLAYER.row - 1][tile_PLAYER.column - 1])
			{
				tile_UPPER_LEFT = gridArray[tile_PLAYER.row - 1][tile_PLAYER.column - 1];
				tile_UPPER_LEFT.updateSecondTF(UPPER_LEFT);
			}
			if(tile_UPPER_RIGHT) tile_UPPER_RIGHT.updateSecondTF("");
			if (gridArray[tile_PLAYER.row - 1][tile_PLAYER.column + 1])
			{
				tile_UPPER_RIGHT = gridArray[tile_PLAYER.row - 1][tile_PLAYER.column + 1];
				tile_UPPER_RIGHT.updateSecondTF(UPPER_RIGHT);
			}
			if(tile_LOWER) tile_LOWER.updateSecondTF("");
			if(gridArray[tile_PLAYER.row + 1][tile_PLAYER.column])
			{
				tile_LOWER = gridArray[tile_PLAYER.row + 1][tile_PLAYER.column];
				tile_LOWER.updateSecondTF(LOWER);
			}
			if(tile_LOWER_LEFT) tile_LOWER_LEFT.updateSecondTF("");
			if (gridArray[tile_PLAYER.row + 1][tile_PLAYER.column - 1])
			{
				tile_LOWER_LEFT = gridArray[tile_PLAYER.row + 1][tile_PLAYER.column - 1];
				tile_LOWER_LEFT.updateSecondTF(LOWER_LEFT);
			}
			if(tile_LOWER_RIGHT) tile_LOWER_RIGHT.updateSecondTF("");
			if (gridArray[tile_PLAYER.row + 1][tile_PLAYER.column + 1])
			{
				tile_LOWER_RIGHT = gridArray[tile_PLAYER.row + 1][tile_PLAYER.column + 1];
				tile_LOWER_RIGHT.updateSecondTF(LOWER_RIGHT);
			}
		}
		
		public function getTilePoint(row:int,column:int):Point
		{
			return new Point(gridArray[row][column].x, gridArray[row][column].y)
		}
		
		public function buildFromVector(vec:Array):void
		{
			gridArray 	= new Array();
			grid 	 	= new Sprite();
			vectorGeral 	= new Vector.<GenericTile>();
			trace ("TileMapLenght:",vec.length)
			var i	:int = 0;
			for (var row:int = 0; row < rows; row++) 
			{
				gridArray[row] = new Array();
				for (var column:int = 0; column < columns; column++) 
				{
					var tile:GenericTile = new GenericTile(i, column, row, vec[i], tileSize);
					tile.y = tileSize * row;
					tile.x = tileSize * column;
					gridArray[row][column] = tile;
					grid.addChild(tile);
					vectorGeral.push(tile);
					if (i+1 >= vec.length)
					{
						return;
					}
					i++;
				}
			}
		}
	}
}