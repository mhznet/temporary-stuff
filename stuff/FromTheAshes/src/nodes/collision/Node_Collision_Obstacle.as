package nodes.collision
{
	import ash.core.Node;
	
	import comp.entity.Comp_Obstacle;
	import comp.Comp_Position;
	import comp.Comp_Speed;
	
	public class Node_Collision_Obstacle extends Node
	{
		public var obstacle	:Comp_Obstacle;
		public var position	:Comp_Position;
		public var speed	:Comp_Speed;
		public function Node_Collision_Obstacle()
		{
			super();
		}
	}
}