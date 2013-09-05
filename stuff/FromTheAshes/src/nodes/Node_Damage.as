package nodes
{
	import ash.core.Node;
	
	import comp.Comp_DoesDamage;
	import comp.Comp_Health;
	import comp.Comp_Position;

	public class Node_Damage extends Node
	{
		public var doesDamage:Comp_DoesDamage;
		public var health:Comp_Health;
		public var position:Comp_Position;
		public function Node_Damage(){}
	}
}