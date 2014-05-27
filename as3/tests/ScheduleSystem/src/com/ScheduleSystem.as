package com
{
	import com.scenes.InputScene;
	import com.scenes.IntroScene;
	import com.scenes.ResultScene;
	import com.scenes.abstract.InputObject;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;

	[SWF(frameRate="30",width="480",height="800")]
	public class ScheduleSystem extends Sprite
	{
		private var intro:IntroScene;
		private var input:InputScene;
		private var result:ResultScene;
		
		public function ScheduleSystem():void
		{
			stage.align 	= StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			this.addEventListener(Event.ADDED_TO_STAGE, onAdded);			
		}
		private function onAdded(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			this.begin();
		}
		public function getWidth():Number
		{
			return 480;
		}
		
		public function getHeight():Number
		{
			return 800;
		}
		
		private function begin():void
		{
			trace ("Begin");
			if (this.intro == null) this.intro = new IntroScene(this);
			this.addChild(this.intro);
		}
		
		public function goToInput():void
		{
			if (this.intro != null)
			{
				if (this.contains(this.intro))
				{
					this.removeChild(this.intro);
				}
			}
			if (this.input == null) this.input = new InputScene(this);
			this.input.clear();
			this.addChild(this.input);
		}
		public function goToResult(inputobj:InputObject):void
		{
			if (this.input != null)
			{
				if (this.contains(this.input))
				{
					this.removeChild(this.input);
				}
			}
			if (this.result == null) this.result = new ResultScene(this);
			this.result.update(inputobj);
			this.addChild(this.result);
		}
		
		public function goToIntro():void
		{
			if (this.result != null)
			{
				if (this.contains(this.result))
				{
					this.removeChild(this.result);
				}
			}
			if (this.intro == null) this.intro = new IntroScene(this);
			this.addChild(this.intro);
		}
	}
}