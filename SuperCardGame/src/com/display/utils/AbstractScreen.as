package com.display.utils
{
	import com.display.Display;
	
	import flash.display.Sprite;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;

	public class AbstractScreen extends Sprite
	{
		public var display:Display;
		public function AbstractScreen(disp:Display)
		{
			display = disp;
		}
		
		public function getTextFormat(param:int):TextFormat
		{
			var textFormat:TextFormat = new TextFormat();
			textFormat.font = "BebasNeue";
			textFormat.color = 0xFFFFFF;
			textFormat.size = 40;
			textFormat.bold = true;
			switch(param)
			{
				case 1:
					textFormat.align = TextFormatAlign.RIGHT;
					break;
				case 0:
					textFormat.align = TextFormatAlign.CENTER;
					textFormat.size = 50;
					break;
				case -1:
					textFormat.align = TextFormatAlign.LEFT;
					break;
			}
			return textFormat;
		}
	}
}