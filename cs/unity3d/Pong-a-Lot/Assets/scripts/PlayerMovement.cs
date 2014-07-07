using UnityEngine;
using System.Collections;

public class PlayerMovement : MonoBehaviour 
{
	public KeyCode moveUp = KeyCode.UpArrow;
	public KeyCode moveDown = KeyCode.DownArrow;
	public float speed = 10.0f;
	// Use this for initialization
	void Start () 
	{
	
	}
	
	// Update is called once per frame
	void Update () 
	{
		if (Input.GetKey(moveUp))
		{
			var vel = rigidbody2D.velocity;
			vel.y = speed;
			rigidbody2D.velocity = vel;
		}
		else if (Input.GetKey (moveDown))
		{
			var vel = rigidbody2D.velocity;
			vel.y = speed * -1;
			rigidbody2D.velocity = vel;
		}
		else if (!Input.anyKey)
		{
			var vel = rigidbody2D.velocity;
			vel.y = 0.0f;
			rigidbody2D.velocity = vel;
		}
		var velX = rigidbody2D.velocity;
		velX.x = 0;
		rigidbody2D.velocity = velX;
	}
}
