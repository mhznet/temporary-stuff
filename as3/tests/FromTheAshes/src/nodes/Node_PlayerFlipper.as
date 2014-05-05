package nodes
{
	import ash.core.Node;
	
	import comp.Comp_Display;
	import comp.entity.Comp_Player;
	import comp.Comp_Position;

	public class Node_PlayerFlipper extends Node
	{
		public var control	:Comp_Player;
		public var display	:Comp_Display;
		public var position:Comp_Position;
		public function Node_PlayerFlipper(){}
	}
}