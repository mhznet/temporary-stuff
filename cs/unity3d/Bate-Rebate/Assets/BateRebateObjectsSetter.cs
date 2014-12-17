﻿using UnityEngine;
using UnityEngine.UI;
using System.Collections;

public class BateRebateObjectsSetter : MonoBehaviour {

	// Use this for initialization
    private GameObject ball;
    private GameObject bg;
    private GameObject touchRight;
    private GameObject touchLeft;
    private GameObject paddleRight;
    private GameObject paddleLeft;
    private GameObject pauseBtn;
    private GameObject scoreLeftShadow;
    private GameObject scoreRightShadow;
    private GameObject scoreLeftOver;
    private GameObject scoreRightOver;
    
    private GameObject pauseScene;

    private string pauseScenePreFabUrl = "preFabs/batePauseScenePreFab";
    private string pauseBtnAssetUrl = "Scenes/Game/pausebt";
    private string paddleRightAssetUrl = "Scenes/Game/gamePaddle2";
    private string paddleLeftAssetUrl = "Scenes/Game/gamePaddle";
    private string bgAsset = "Scenes/Game/gameBg";
    private string ballAsset = "Scenes/Game/gameBall";
    private string hitBoxAsset = "Scenes/Game/gameHitOk";
    
    private GameObject wallNorth;
    private GameObject wallSouth;
    private GameObject wallRight;
    private GameObject wallLeft;
    void Start()
    {
        VerifyScreenRes();
        CreateBackGround();
        CreateWalls();
        CreateUI();
        CreateBall();
        CreatePaddles();
        CreateTouches();

        //wallNorth = GameObject.Find("wallNorth");
        //wallSouth = GameObject.Find("wallSouth");
        //wallLeft = GameObject.Find("wallLeft");
        //wallRight = GameObject.Find("wallRight");

        Resources.UnloadUnusedAssets();
    }
    private void VerifyScreenRes()
    {
        string quality = "High";
        string platform = "IOS";
        bgAsset = addPlatformAndQualityToUrl(platform, quality, bgAsset);
        pauseBtnAssetUrl = addPlatformAndQualityToUrl(platform, quality, pauseBtnAssetUrl);
        ballAsset = addPlatformAndQualityToUrl(platform, quality, ballAsset);
        hitBoxAsset = addPlatformAndQualityToUrl(platform, quality, hitBoxAsset, true);
        paddleRightAssetUrl = addPlatformAndQualityToUrl(platform, quality, paddleRightAssetUrl);
        paddleLeftAssetUrl = addPlatformAndQualityToUrl(platform, quality, paddleLeftAssetUrl);
    }
    private string addPlatformAndQualityToUrl(string platform, string quality, string url, bool debug = false)
    {
        char delim = '/';
        url = platform + delim + quality + delim + url;
        if (debug)Debug.Log(url);
        return url;
    }
    private void CreateWalls()
    {
        wallNorth = new GameObject();
        wallNorth.name = "wallU";
        wallNorth.AddComponent<BoxCollider2D>();
        wallNorth.transform.localScale = new Vector3(22f, 1f, 1f);
        wallNorth.transform.position = new Vector3(2.4f,8.2f,0);

        wallSouth = new GameObject();
        wallSouth.name = "wallD";
        wallSouth.AddComponent<BoxCollider2D>();
        wallSouth.transform.localScale = new Vector3(22f, 1f, 1f);
        wallSouth.transform.position = new Vector3(2.4f, -8.2f, 0);

        wallLeft = new GameObject();
        wallLeft.name = "wallL";
        wallLeft.AddComponent<BoxCollider2D>();
        wallLeft.transform.localScale = new Vector3(1f, 18f, 1f);
        wallLeft.transform.position = new Vector3(-8.2f, 0f, 0f);

        wallRight = new GameObject();
        wallRight.name = "wallR";
        wallRight.AddComponent<BoxCollider2D>();
        wallRight.transform.localScale = new Vector3(1f, 18f, 1f);
        wallRight.transform.position = new Vector3(13.2f, 0f, 0f);
    }
    private void CreateBackGround()
    {
        bg = new GameObject();
        bg.name = "background";
        bg.AddComponent<SpriteRenderer>().sprite = Resources.Load<Sprite>(bgAsset);
        bg.transform.position = new Vector3(2.5f, 0f, 10);
    }
    private void CreateUI()
    {
        scoreLeftOver = GameObject.Find("scoreLeftOver");
        scoreRightOver = GameObject.Find("scoreRightOver");
        scoreRightShadow = GameObject.Find("scoreRightShadow");
        scoreLeftShadow = GameObject.Find("scoreLeftShadow");
        pauseBtn = GameObject.Find("pausebtn");
        pauseBtn.GetComponent<Image>().sprite = Resources.Load<Sprite>(pauseBtnAssetUrl);
        pauseBtn.GetComponent<Button>().onClick.AddListener(OnClickPause);
    }
    private void CreateBall()
    {
        ball = new GameObject();
        ball.name = "ball";
        ball.AddComponent<SpriteRenderer>().sprite = Resources.Load<Sprite>(ballAsset);
        ball.AddComponent<CircleCollider2D>();
        ball.AddComponent<Rigidbody2D>().mass = 0.00001f;
        ball.GetComponent<Rigidbody2D>().gravityScale = 0f;
        ball.collider2D.sharedMaterial = Resources.Load<PhysicsMaterial2D>("Materials/ballMaterial");
        ball.transform.position = new Vector3(2.5f, 0f, 0);
        ball.AddComponent<BallBehaviour>();
        ball.GetComponent<BallBehaviour>().scoreLeftShadow = scoreLeftShadow;
        ball.GetComponent<BallBehaviour>().scoreRightShadow = scoreRightShadow;
        ball.GetComponent<BallBehaviour>().scoreLeftOver = scoreLeftOver;
        ball.GetComponent<BallBehaviour>().scoreRightOver = scoreRightOver;
    }
    private void CreateTouches()
    {
        touchLeft = new GameObject();
        touchRight = new GameObject();
        touchLeft.name = "touchBoxLeft";
        touchRight.name = "touchBoxRight";
        touchLeft.AddComponent<BoxCollider2D>().isTrigger = true;
        touchRight.AddComponent<BoxCollider2D>().isTrigger = true;

        touchRight.transform.localScale = new Vector3(7f, 15f, 1f);
        touchLeft.transform.localScale = new Vector3(7f, 15f, 1f);
        touchRight.transform.position   = new Vector3(9.18f, 0f, -9f);
        touchLeft.transform.position    = new Vector3(-4.25f, 0f, -9f);

        touchRight.AddComponent<PaddleBehaviour>();
        touchRight.GetComponent<PaddleBehaviour>().enableTouch = true;
        touchRight.GetComponent<PaddleBehaviour>().paddleAsset = paddleRight;
        touchRight.GetComponent<PaddleBehaviour>().ball = ball;
        touchLeft.AddComponent<PaddleBehaviour>();
        touchLeft.GetComponent<PaddleBehaviour>().enableTouch = false;
        touchLeft.GetComponent<PaddleBehaviour>().paddleAsset = paddleLeft;
        touchLeft.GetComponent<PaddleBehaviour>().ball = ball;
    }
    private void CreatePaddles()
    {
        paddleRight = new GameObject();
        paddleLeft = new GameObject();
        paddleRight.name = "paddleRightAsset";
        paddleLeft.name = "paddleLeftAsset";
        paddleRight.AddComponent<SpriteRenderer>().sprite = Resources.Load<Sprite>(paddleRightAssetUrl);
        paddleLeft.AddComponent<SpriteRenderer>().sprite = Resources.Load<Sprite>(paddleLeftAssetUrl);
        paddleRight.AddComponent<BoxCollider2D>();
        paddleLeft.AddComponent<BoxCollider2D>();
        paddleRight.AddComponent<Rigidbody2D>().mass = 100000f;
        paddleRight.GetComponent<Rigidbody2D>().fixedAngle = true;
        paddleRight.GetComponent<Rigidbody2D>().gravityScale = 0f;
        paddleLeft.AddComponent<Rigidbody2D>().mass = 100000f;
        paddleLeft.GetComponent<Rigidbody2D>().fixedAngle = true;
        paddleLeft.GetComponent<Rigidbody2D>().gravityScale = 0f;
        paddleRight.transform.position = new Vector3(11.18f, 0f, 9f);
        paddleLeft.transform.position = new Vector3(-6.25f, 0f, 9f);
    }
    public void OnClickPause()
    {
        Debug.Log("OnClickPause");
        /*Application.LoadLevel("sceneName");*/
        if (pauseScene == null)
        {
            pauseScene = Resources.Load<GameObject>(pauseScenePreFabUrl);
            Instantiate(pauseScene);
        }
        pauseScene.transform.position = new Vector3(0f, 0f, 1f);
        Debug.Log(pauseScene);
    }
}
