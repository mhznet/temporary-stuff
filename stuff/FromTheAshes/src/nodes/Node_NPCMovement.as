package nodes
{
	import ash.core.Node;
	import comp.Comp_Position;
	import comp.Comp_Speed;
	import comp.Comp_NPC;
	
	public class Node_NPCMovement extends Node
	{
		public var npc			:Comp_NPC;
		public var position 	:Comp_Position;
		public var speed		:Comp_Speed;
		public function Node_NPCMovement(){}
	}
}