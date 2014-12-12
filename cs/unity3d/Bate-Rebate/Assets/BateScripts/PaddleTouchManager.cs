using UnityEngine;
using System.Collections;

public class PaddleTouchManager : MonoBehaviour 
{
    public bool enableTouch = true;
    public bool limitToBg = false;
    public GameObject paddle;
    public GameObject background;
    private bool isDragging = false;
    
    void Start() { }
    void Update() { }
    void OnMouseUp()
    {
        isDragging = false;
    }
    void OnMouseDown()
    {
        isDragging = true;
    }
    void FixedUpdate()
    {
        if (enableTouch)
        {
            if (isDragging && !this.paddle.GetComponent<BatePaddleComp>()._ia)
            {
                var posVec = Camera.main.ScreenToWorldPoint(Input.mousePosition);
                if (limitToBg)
                {
                    if (posVec.y >= background.renderer.bounds.extents.y)
                    {
                        posVec.y = background.renderer.bounds.center.y - (paddle.renderer.bounds.extents.y * 0.5f);
                    }
                    if (posVec.y <= -background.renderer.bounds.extents.y)
                    {
                        posVec.y = background.renderer.bounds.extents.y + (paddle.renderer.bounds.extents.y * 0.5f);
                    }
                }
                posVec.z = this.paddle.transform.position.z;
                posVec.x = this.paddle.transform.position.x;
                this.paddle.transform.position = Vector3.MoveTowards(this.paddle.transform.position, posVec, this.paddle.GetComponent<BatePaddleComp>()._speed * Time.deltaTime);
            }
        }
    }
}
