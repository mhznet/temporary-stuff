package com.display.Screens
{
	import com.display.Display;
	
	import flash.display.Sprite;

	public class AbstractScreen extends Sprite
	{
		public var display:Display;
		public function AbstractScreen(disp:Display)
		{
			display = disp;
		}
	}
}