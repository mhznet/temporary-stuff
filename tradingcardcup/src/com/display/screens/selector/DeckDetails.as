package com.display.screens.selector
{
	import com.data.Card;
	import com.data.Utility;
	
	import flash.display.Sprite;
	import flash.text.TextField;
	
	public class DeckDetails extends Sprite
	{
		public var cards	:Vector.<Card>;
		public var txtVector:Vector.<TextField>;
		public var asset	:DeckAsset;
		public var assetAtk	:TextField;
		public var assetDef	:TextField;
		public var assetSP	:TextField;
		public var assetHb	:TextField;
		public var assetAtt	:TextField;
		public var assetDft	:TextField;
		public var assetOvr	:TextField;
		public function DeckDetails()
		{
			super();
			cards = new Vector.<Card>();
			txtVector = new Vector.<TextField>();
			asset = new DeckAsset();
			txtVector.push(asset.p1,asset.p2,asset.p3,asset.p4,asset.p5);
			this.addChild(asset);
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
		public function fillDeckDetails(cardVec:Vector.<Card>):void
		{
			this.cards = cardVec;
			
			var overall	:int = 0;
			var offense	:int = 0;
			var defense	:int = 0;
			var hability:int = 0;
			var speed	:int = 0;
			
			for each (var fig:Card in cards) 
			{
				overall += fig.overall; 
				offense += fig.offense;
				defense += fig.defense;
				hability+= fig.hability;
				speed 	+= fig.speed;
			}
			
			overall  = overall  / cards.length;
			offense  = offense  / cards.length;
			defense  = defense  / cards.length;
			hability = hability / cards.length;
			speed  	 = speed	/ cards.length;
			
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
		public function setCard(card:Card):void
		{
			if (!Utility.getInstance().getIfAlreadyAddedInVector(card.id,cards) && cards.length < 5)
			{
				card.setEquipped(true);
				cards.push(card);
				setTextToFieldAvailable(card.m_name);
			}
			else if (Utility.getInstance().getIfAlreadyAddedInVector(card.id,cards) && cards.length <= 5)
			{
				card.setEquipped(false);
				var index:int = Utility.getInstance().getIndex(card.id,cards);
				cleanText(index);
				cards.splice(index,1);
			}
			fillDeckDetails(cards);
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
		public function updateDeckAssetNames():void
		{
			for (var i:int = 0; i < txtVector.length; i++) 
			{
				if (i < cards.length)
				{
					txtVector[i].text = cards[i].m_name;
				}
			}
		}
	}
}