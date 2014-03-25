package com.data
{
	import com.display.cards.Thumb;
	
	import flash.display.Sprite;

	public final class Deck extends Sprite
	{
		public var id		:int;
		public var m_name	:String;
		public var description:String;
		public var inUse	:Vector.<Card>;
		
		/**STATS**/
		public var overall 	:int;
		public var offense 	:int;
		public var defense 	:int;
		public var hability	:int;
		public var speed	:int;
		public var thumb	:Thumb;
		
		public function traceDeckInfo():void
		{
			var teamInfo:String = "ATK: " + offense + " / DEF: " + defense + " / HAB: " + hability + " / SPD: " + speed + " / OVR: " + overall;
			var lineUp	:String = "";
			for (var i:int = 0; i < inUse.length; i++) 
			{
				lineUp += "["+inUse[i].jersey+"] - " + inUse[i].m_name + " "+ inUse[i].overall + "\n"; 
			}
			//trace (teamInfo + "\n" + lineUp);
			trace (lineUp);
		}
		public function setCard(card:Card):void
		{
			if (!getIfAlreadyAddedInVector(card.id,inUse) && inUse.length < 5)
			{
				card.setEquipped(true);
				inUse.push(card);
			}
			else if (getIfAlreadyAddedInVector(card.id,inUse) && inUse.length <= 5)
			{
				card.setEquipped(false);
				var index:int = Utility.getInstance().getIndex(card.id,inUse);
				inUse.splice(index,1);
			}
		}
		public function getIfAlreadyAddedInVector(cardid:int, vec:Vector.<Card>):Boolean
		{
			var alrdyAdded:Boolean = false;
			for (var i:int = 0; i < vec.length; i++) 
			{
				if (cardid == vec[i].id)
				{
					alrdyAdded = true;
					break;
				}
			}
			return alrdyAdded;
		}
		public function Deck()
		{
			inUse = new Vector.<Card>();
		}
	}
}