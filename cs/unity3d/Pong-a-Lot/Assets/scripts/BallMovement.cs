using UnityEngine;
using System.Collections;

public class BallMovement : MonoBehaviour {

	// Use this for initialization
	void Start () 
	{
		Randomize ();
	}
	void StartRolling()
	{
		//WaitForSeconds (2.0f);
		//Randomize ();
	}
	void Randomize()
	{
		float random = Random.Range (0.0f, 100.0f);
		Debug.Log (random + " Yea!");
		if (random < 50.0f) 
		{
			rigidbody2D.AddForce(new Vector2(20.0f,15.0f));
		}
		else 
		{
			rigidbody2D.AddForce(new Vector2(-20.0f,-15.0f));
		}
	}

	void Reset()
	{
		var vel = rigidbody2D.velocity;
		vel.y = 0;
		vel.x = 0;
		rigidbody2D.velocity = vel;
		gameObject.transform.position = new Vector2 (0, 0);
	}

	void OnCollisionEnter2D(Collision2D coll)
	{
		if (coll.collider.CompareTag ("Player")) 
		{
			var velY = rigidbody2D.velocity;
			velY.y = (velY.y/2.0f)+coll.collider.rigidbody2D.velocity.y/3.0f;
			//velY.y *= -1;
			rigidbody2D.velocity = velY;
		}
	}

	// Update is called once per frame
	void Update () {
	
	}
}
