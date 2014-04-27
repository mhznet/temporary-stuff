package com.display.screens
{
	
	import flash.display.Bitmap;
	import com.display.Display;
	import com.display.utils.GenericBt;
	import com.display.utils.AbstractScreen;
	
	public class RuleScreen extends AbstractScreen
	{
		private var bmp:Bitmap;
		private var returns:GenericBt;
		
		public function RuleScreen(disp:Display)
		{
			super(disp);
			addBitmap();
			bts();
		}
		
		private function bts():void
		{
			returns = new GenericBt(display.goModeSelect,"", 140,70,display.main.data.getBMPById(1));
			returns.x = 680;
			returns.y = 500;
			this.addChild(returns);
		}
		private function addBitmap():void
		{
			bmp = new Bitmap();
			bmp.bitmapData = display.main.data.getBMPById(17);
			this.addChild(bmp);
		}
	}
}