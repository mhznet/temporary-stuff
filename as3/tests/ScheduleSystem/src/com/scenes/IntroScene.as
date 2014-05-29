package com.scenes
{
	import com.ScheduleSystem;
	import com.scenes.abstract.AbstractScene;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class IntroScene extends AbstractScene
	{
		public var enter:Sprite;
		public var logo:Sprite;
		public function IntroScene(p_main:ScheduleSystem)
		{
			super(p_main);
			createLogo();
			createEnter();
		}
		
		private function createLogo():void
		{
			logo = new Sprite();
			var photo:Sprite = new ConjLogoSmall();
			logo.addChild(photo);
			logo.x = main.getWidth()*0.5 - logo.width*0.5 - 20;
			logo.y = main.getHeight()*0.1;
			//logo.y = main.getHeight() - logo.height;
			this.addChild(logo);
		}
		private function createEnter():void
		{
			this.enter = new Sprite();
			var img:Sprite = new EntrarBT();
			this.enter.addChild(img);
			/*this.enter.graphics.beginFill(0x000000, 1);
			this.enter.graphics.drawCircle(30,30,50);
			this.enter.graphics.endFill();*/
			this.enter.mouseChildren = false;
			this.enter.x = main.getWidth()*0.5;
			this.enter.y = main.getHeight()*0.7;
			this.addChild(this.enter);
			this.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		protected function onClick(event:MouseEvent):void
		{
			this.main.goToInput();
		}
	}
}