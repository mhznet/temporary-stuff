package com.display.Screens
{
	import com.display.Display;
	import com.display.GenericBt;
	
	import flash.events.MouseEvent;

	public class ModeSelectionScreen extends AbstractScreen
	{
		private var singlePlayer:GenericBt;
		private var multiPlayer	:GenericBt;
		public function ModeSelectionScreen(disp:Display)
		{
			super(disp);
			singlePlayer= new GenericBt("single", onSingleClicked);
			singlePlayer.x = disp.background.width * 0.5 - singlePlayer.width * 0.5;
			singlePlayer.y = disp.background.height * 0.5 - singlePlayer.height * 0.5;
			this.addChild(singlePlayer);
			/*multiPlayer	= new GenericBt("multi", onMultiClicked);
			multiPlayer.y = disp.background.height * 0.5 - multiPlayer.height * 0.5 - multiPlayer.height;
			multiPlayer.x = disp.background.width * 0.5 - multiPlayer.width * 0.5;
			this.addChild(multiPlayer);*/
		}
		private function onMultiClicked(e:MouseEvent):void
		{
			trace ("ae");
		}
		private function onSingleClicked(e:MouseEvent):void
		{
			display.goGame(2);
		}
	}
}