package systems
{
	import ash.core.Engine;
	import ash.core.Node;
	import ash.core.NodeList;
	import ash.core.System;
	
	import comp.Comp_Display;
	import comp.Comp_Position;
	
	import nodes.Node_Damage;
	import nodes.Node_NPCMovement;
	import nodes.Node_PlayerControl;
	
	public class System_Damage extends System
	{
		private var ashEngine	:Engine;
		public function System_Damage(engine:Engine)
		{
			ashEngine = engine;
		}
		override public function addToEngine(engine:Engine):void
		{
		}
		override public function update(timer:Number):void
		{
			var list_Player		:NodeList = ashEngine.getNodeList(Node_PlayerControl);
			/*var list_NPC		:NodeList = ashEngine.getNodeList(Node_NPCMovement);
			var list_Damage		:NodeList = ashEngine.getNodeList(Node_Damage);*/
			/*for(var node_Damage:Node_Damage = list_Damage.head; node_Damage; node_Damage = node_Damage.next ) 
			{
				
			}*/
			/*var prevEntity	:Entity = node.previous;
			var nextEntity	:Entity = node.next;
			var actualEntity:Entity = node.entity;
			if (nextEntity || prevEntity)
				trace ("Ae ae ae ae ae ae");
			else
				trace ("=(");
			if (node.entity.name == GameConstants.LUIGI)
			{
				if (actualEntity)
				{
					var actualPos		:Comp_Position = actualEntity.get(Comp_Position);
					var actualDisplay	:Comp_Display = actualEntity.get(Comp_Display);
					var actualHealth	:Comp_Health;
					var nextPos			:Comp_Position;
					var nextDisplay		:Comp_Display;
					var prevPos			:Comp_Position;
					var prevDisplay		:Comp_Display;
					if (prevEntity != null) 
					{
						prevPos = prevEntity.get(Comp_Position);
						prevDisplay = prevEntity.get(Comp_Display);
						if (prevPos != null && prevDisplay != null)
						{
							if (checkPixelHit(actualPos,actualDisplay,prevPos,prevDisplay))
							{
								actualHealth = actualEntity.get(Comp_Health);
								var prevDamage	:Comp_DoesDamage = nextEntity.get(Comp_DoesDamage);
								actualHealth.health -= prevDamage.damage;
								if (actualHealth.health <= 0)
								{
									actualEntity.remove(Comp_Display);
								}
							}
						}
					}
					if (nextEntity != null) 
					{
						nextPos = nextEntity.get(Comp_Position);
						nextDisplay = nextEntity.get(Comp_Display);
						if (nextPos != null && nextDisplay != null)
						{
							if (checkPixelHit(actualPos,actualDisplay,prevPos,prevDisplay))
							{
								actualHealth = actualEntity.get(Comp_Health);
								var nextDamage	:Comp_DoesDamage = nextEntity.get(Comp_DoesDamage);
								actualHealth.health -= nextDamage.damage;
								if (actualHealth.health <= 0)
								{
									actualEntity.remove(Comp_Display);
								}
							}
						}
					}
				}
			}*/
		}
		private function checkPixelHit(posA:Comp_Position,disA:Comp_Display,posB:Comp_Position,disB:Comp_Display):Boolean
		{
			var isHitting:Boolean = false;
			var left_A		:Number = posA.X - 5;
			var rigth_A		:Number = posA.X + 5 + disA.display.width;
			var left_B		:Number = posB.X;
			var rigth_B		:Number = posB.X + disB.display.width;
			if (rigth_A > left_B || left_A < rigth_B) isHitting = true;
			return isHitting;
		}
	}
}