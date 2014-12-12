using UnityEngine;
using System.Collections;

public class BallBehaviour : MonoBehaviour {

	// Use this for initialization
    public float speed = 15f;
    void Start()
    {
        rigidbody2D.velocity = Vector2.one.normalized * speed;
        //TODO RANDOM SAIDA
    }

    void OnCollisionEnter2D(Collision2D col)
    {
        if (col.gameObject.name == "paddleLeft")
        {
            float y = hitFactor(transform.position, col.transform.position, ((BoxCollider2D)col.collider).size.y);
            Vector2 dir = new Vector2(1, y).normalized;
            rigidbody2D.velocity = dir * speed;
        }
        if (col.gameObject.name == "paddleRight") 
        {
            float y = hitFactor(transform.position,col.transform.position,((BoxCollider2D)col.collider).size.y);
            Vector2 dir = new Vector2(-1, y).normalized;
            rigidbody2D.velocity = dir * speed;
        }
        //if paredes GOAL!
    }
    float hitFactor(Vector2 ballPos, Vector2 paddlePos, float paddleHeight)
    {
        return (ballPos.y - paddlePos.y) / paddleHeight;
    }
	// Update is called once per frame
	void Update () {
	
	}
}
