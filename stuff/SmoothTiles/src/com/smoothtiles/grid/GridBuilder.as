package com.smoothtiles.grid
{
	import com.smoothtiles.abstracttile.GenericTile;
	
	import flash.display.Sprite;

	public class GridBuilder
	{
		public var grid		:Sprite;
		public var tileSize	:Number = 50;
		public var columns	:int = 14;
		public var rows		:int = 14;
		public var gridArray:Array;
		public var gridVector:Array = new Array
			("O","O","O","O","O","O","O","O","O","O","O","O","O","O",
			 "O","O","C","C","C","C","C","C","C","C","C","C","O","O",
			 "O","C","C","C","C","C","C","C","C","C","C","C","C","O",
			 "O","C","C","C","C","C","C","C","C","C","C","C","C","O",
			 "O","C","C","C","C","C","C","C","C","C","C","C","C","O",
			 "O","C","C","C","C","C","C","C","C","C","C","C","C","O",
			 "O","C","C","C","C","C","C","C","C","C","C","C","C","O",
			 "O","C","C","C","C","C","C","C","C","C","C","C","C","O",
			 "O","C","C","C","C","C","C","C","C","C","C","C","C","O",
			 "O","C","C","C","C","C","C","C","C","C","C","C","C","O",
			 "O","C","C","C","C","C","C","C","C","C","C","C","C","O",
			 "O","C","C","C","C","C","C","C","C","C","C","C","C","O",
			 "O","O","C","C","C","C","C","C","C","C","C","C","O","O",
			 "O","O","O","O","O","O","O","O","O","O","O","O","O","O");
		
		public function GridBuilder()
		{
			buildFromVector(gridVector);
		}
		public function buildFromVector(vec:Array):void
		{
			gridArray 	= new Array();
			grid 	 	= new Sprite();
			
			var i	:int = 0;
			for (var row:int = 0; row < rows; row++) 
			{
				gridArray[row] = new Array();
				for (var column:int = 0; column < columns; column++) 
				{
					var tile:GenericTile = new GenericTile(vec[i], tileSize);
					tile.y = tileSize * row;
					tile.x = tileSize * column;
					gridArray[row][column] = tile;
					grid.addChild(tile);
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