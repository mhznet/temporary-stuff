package com.smoothtiles.abstracttile
{
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class BaseTile extends Sprite
	{
		public function BaseTile()
		{
			super();
		}
		public function getBottomRightPoint():Point
		{
			return new Point(x + width, y + height);
		}
		public function getUpperRightPoint():Point
		{
			return new Point(x + width, y);
		}
		public function getBottomLeftPoint():Point
		{
			return new Point(x, y + height);
		}
		public function getUpperLeftPoint():Point
		{
			return new Point(x, y);
		}
		public function getMiddlePoint():Point
		{
			return new Point(x + width * 0.5, y + height * 0.5);
		}
	}
}