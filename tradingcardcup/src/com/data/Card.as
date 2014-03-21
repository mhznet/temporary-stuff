package com.data
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.filters.GlowFilter;

	public final class Card extends Sprite
	{
		/**CONST**/
		public const OFFENSIVE	:int = 1;
		public const DEFENSIVE	:int = 2;
		/**DATA**/
		public var id			:int;
		public var star			:Boolean;
		private var equipped	:Boolean = false;
		public var doHave		:Boolean = false;
		public var m_name		:String;
		public var description	:String;
		public var nation		:String;
		public var jersey		:int;
		/**STATS**/
		public var offense 		:int;
		public var defense 		:int;
		public var hability		:int;
		public var speed 		:int;
		public var stamina 		:int;
		public var overall 		:int;
		public var style		:int;
		
		/**DISPLAY**/
		public var thumb		:CardHolder;
		
		public function Card(data:XML)
		{
			id 			= data.@id;
			star		= data.@star;
			m_name 		= data.@name;
			description = data.@desc;
			nation 		= data.@nation;
			jersey 		= data.@jersey;
			offense 	= data.@offense;
			defense 	= data.@defense;
			hability	= data.@hability;
			speed		= data.@speed;
			stamina 	= data.@stamina;
			offense > defense ? style = OFFENSIVE : style = DEFENSIVE;
		}
		
		public function addGlow(spr:MovieClip):void
		{
			var glow:GlowFilter = new GlowFilter(); 
			glow.color = 0x009922; 
			glow.alpha = 1; 
			glow.blurX = 25; 
			glow.blurY = 25; 
			spr.filters = [glow];
		}
		public function removeGlow(spr:MovieClip):void
		{
			var glow:GlowFilter = new GlowFilter();
			spr.filters = [glow];
		}
		
		public function setEquipped(param0:Boolean):void
		{
			equipped = param0;
			equipped ? addGlow(thumb) : removeGlow(thumb);
		}
		public function getEquipped():Boolean
		{
			return equipped;
		}
	}
}