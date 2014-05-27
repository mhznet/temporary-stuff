package com.scenes
{
	import com.ScheduleSystem;
	import com.scenes.abstract.AbstractScene;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class IntroScene extends AbstractScene
	{
		public var enter:Sprite;
		public function IntroScene(p_main:ScheduleSystem)
		{
			super(p_main);
			createEnter();
		}
		private function createEnter():void
		{
			this.enter = new Sprite();
			this.enter.graphics.beginFill(0x99FF00, 1);
			this.enter.graphics.drawCircle(30,30,50);
			this.enter.graphics.endFill();
			this.enter.mouseChildren = false;
			this.enter.x = main.getWidth()*0.5 - this.enter.width*0.5;
			this.enter.y = main.getHeight()*0.5 - this.enter.height*0.5;
			this.addChild(this.enter);
			this.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		protected function onClick(event:MouseEvent):void
		{
			this.main.goToInput();
		}
	}
}