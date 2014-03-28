package com.data
{
	import com.display.cards.Thumb;
	
	import flash.display.Sprite;

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
		public var url			:String;
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
		public var thumb		:Thumb;
		
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
			url 		= data.@img;
			stamina 	= data.@stamina;
			overall = (offense+defense+speed+hability)/4
			offense > defense ? style = OFFENSIVE : style = DEFENSIVE;
		}
		
		public function setEquipped(param0:Boolean):void
		{
			equipped = param0;
			equipped ? thumb.addGlow() : thumb.removeGlow();
		}
		public function getEquipped():Boolean
		{
			return equipped;
		}
	}
}