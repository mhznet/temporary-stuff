package com.display.screens.selector
{
	import com.data.Card;
	
	import flash.display.Sprite;
	import flash.text.TextField;

	public final class Deck extends Sprite
	{
		public var inUse	:Vector.<Card>;
		public var txtVector:Vector.<TextField>;
		public var deckSize	:int = 5;
		/**ASSETS**/
		public var asset	:DeckAsset;
		public var assetAtk	:TextField;
		public var assetDef	:TextField;
		public var assetSP	:TextField;
		public var assetHb	:TextField;
		public var assetAtt	:TextField;
		public var assetDft	:TextField;
		public var assetOvr	:TextField;
		/**PLAY STYLE**/
		/**STATS**/
		public var overall 	:int;
		public var offense 	:int;
		public var defense 	:int;
		public var hability	:int;
		public var speed	:int;
		
		public function fillDeckOverall(cards:Vector.<Card>):void
		{
			inUse = cards;
			for each (var fig:Card in inUse) 
			{
				overall += fig.overall; 
				offense += fig.offense;
				defense += fig.defense;
				hability+= fig.hability;
				speed 	+= fig.speed;
			}
			overall  = overall  / inUse.length;
			offense  = offense  / inUse.length;
			defense  = defense  / inUse.length;
			hability = hability / inUse.length;
			speed  	 = speed	/ inUse.length;
			
			assetAtk = asset.txt_Atk;
			assetAtk.text = offense.toString();
			assetDef = asset.txt_Def;
			assetDef.text = defense.toString();
			assetSP = asset.txt_Speed;
			assetSP.text = speed.toString();
			assetHb = asset.txt_Hab;
			assetHb.text = hability.toString();
			assetAtt = asset.txt_Atype;
			assetDft = asset.txt_Dtype;
			assetOvr = asset.txt_Overall;
			assetOvr.text = overall.toString();
		}
		public function alreadyAdded(cardid:int):Boolean
		{
			var alrdyAdded:Boolean = false;
			for (var i:int = 0; i < inUse.length; i++) 
			{
				if (cardid == inUse[i].id)
				{
					alrdyAdded = true;
					break;
				}
			}
			return alrdyAdded;
		}
		public function getIndex(cardid:int):int
		{
			var index:int;
			for (var i:int = 0; i < inUse.length; i++) 
			{
				if (cardid == inUse[i].id)
				{
					index = i;
					break;
				}
			}
			return index;
		}
		public function setTextToFieldAvailable(str:String):void
		{
			for (var i:int = 0; i < txtVector.length; i++) 
			{
				if (txtVector[i].text == "" || txtVector[i].text == "NAME")
				{
					txtVector[i].text = str;
					break;
				}
			}
		}
		public function setCard(card:Card):void
		{
			traceDeckInfo();
			if (!alreadyAdded(card.id) && inUse.length < 5)
			{
				card.setEquipped(true);
				inUse.push(card);
				setTextToFieldAvailable(card.m_name);
			}
			else if (alreadyAdded(card.id) && inUse.length <= 5)
			{
				card.setEquipped(false);
				var index:int = getIndex(card.id);
				cleanText(index);
				inUse.splice(index,1);
			}
			fillDeckOverall(inUse);
		}
		
		private function cleanText(index:int):void
		{
			txtVector[index].text = "";
			for (var i:int = 0; i < txtVector.length; i++)
			{
				if (i+1 < txtVector.length)
				{
					if (txtVector[i].text == "")
					{
						if (txtVector[i+1] != null)
						{
							txtVector[i].text = txtVector[i+1].text;
							txtVector[i+1].text = "";
						}
					}
				}
			}
		}
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
		public function Deck()
		{
			inUse = new Vector.<Card>();
			txtVector = new Vector.<TextField>();
			asset = new DeckAsset();
			txtVector.push(asset.p1,asset.p2,asset.p3,asset.p4,asset.p5);
			this.addChild(asset);
		}
	}
}