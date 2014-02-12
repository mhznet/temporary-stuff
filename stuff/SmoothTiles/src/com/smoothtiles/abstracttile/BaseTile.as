package com.smoothtiles.abstracttile
{
	import flash.display.Sprite;
	
	public class BaseTile extends Sprite
	{
		public function BaseTile()
		{
			super();
		}
		public function getBottomBorder():Number
		{
			return y + height * 0.5;
		}
		public function getUpperBorder():Number
		{
			return y - height * 0.5;
		}
		public function getLeftBorder():Number
		{
			return x - width * 0.5;
		}
		public function getRightBorder():Number
		{
			return x + width * 0.5;
		}
	}
}