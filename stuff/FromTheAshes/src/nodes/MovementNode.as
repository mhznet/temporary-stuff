package nodes
{
	import ash.core.Node;
	import comp.PosComp;
	import comp.SpeedComp;
	
	public class MovementNode extends Node
	{
		public var position 	:PosComp;
		public var speed		:SpeedComp;
		public function MovementNode(){}
	}
}