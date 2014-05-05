package com.display.screens
{
	import com.display.MainDisplay;
	
	import flash.display.Sprite;

	public class AbstractScreen extends Sprite
	{
		public var display:MainDisplay;
		public function AbstractScreen(disp:MainDisplay)
		{
			display = disp;
		}
	}
}