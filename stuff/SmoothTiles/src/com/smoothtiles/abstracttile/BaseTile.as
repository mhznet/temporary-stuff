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
		public function getBottomBorder():Number
		{
			return y + height;
		}
		public function getUpperBorder():Number
		{
			return y;
		}
		public function getLeftBorder():Number
		{
			return x;
		}
		public function getRightBorder():Number
		{
			return x + width;
		}
		public function getMiddlePoint():Point
		{
			return new Point(x + width * 0.5, y + height * 0.5);
		}
	}
}