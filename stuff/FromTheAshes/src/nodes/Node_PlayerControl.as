package nodes
{
	import ash.core.Node;
	
	import comp.Comp_PlayerControl;
	import comp.Comp_Position;
	import comp.Comp_Speed;
	
	public class Node_PlayerControl extends Node
	{
		public var control	:Comp_PlayerControl;
		public var position	:Comp_Position;
		public var speed	:Comp_Speed;
		public function Node_PlayerControl(){}
	}
}