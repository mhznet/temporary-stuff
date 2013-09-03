package net.richardlord.asteroids.graphics
{
	import away3d.containers.ObjectContainer3D;
	import away3d.entities.Mesh;
	import away3d.materials.ColorMaterial;
	import away3d.primitives.CylinderGeometry;
	import away3d.primitives.WireframeCylinder;
	
	/**
	 * Dummy cylinder
	 * @author Abiyasa
	 */
	public class DummyCylinder extends ObjectContainer3D
	{
		
		public function DummyCylinder(size:int = 0, color:uint = 0xFFFFFF, wireframe:Boolean = true)
		{
			super();
			
			// default size
			if (size <= 0)
			{
				size = 10;
			}
			
			if (wireframe)
			{
				var wireframeObject:WireframeCylinder = new WireframeCylinder(0, size * 0.25, size, 16, 2, color);
				wireframeObject.rotationZ = -90;
				this.addChild(wireframeObject);
			}
			else
			{
				var material:ColorMaterial = new ColorMaterial(color);
				var cylinder:Mesh = new Mesh(new CylinderGeometry(0, size * 0.25, size, 16, 1), material);
				cylinder.rotationZ = -90;
				this.addChild(cylinder);
			}
		}
		
	}

}
