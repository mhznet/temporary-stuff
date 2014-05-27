package com.scenes.abstract
{
	import com.ScheduleSystem;
	
	import flash.display.Sprite;
	
	public class AbstractScene extends Sprite
	{
		public var main:ScheduleSystem;
		public function AbstractScene(p_main:ScheduleSystem)
		{
			this.main = p_main;
			super();
		}
	}
}