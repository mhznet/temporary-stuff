var canvas;
var stag;
var manager;
function Main ()
{
    canvas = document.getElementById("myCanv");
    stag = new createjs.Stage(canvas);
    stag.mouseEventsEnabled = true;
    manager = new SceneManager(stag);
    createScenes();
    createBtns();
}
function createBtns()
{
    for (var i = 0; i < 2; i++)
    {
        var shape = new createjs.Shape();
        shape.graphics.beginFill("green").drawRect(100*i,500,30,30);
        shape.name = i;
        shape.addEventListener("click",handleClick);
        stag.addChild(shape);
        stag.update();
    }
}
function handleClick(e)
{
    if (e.currentTarget.name === 1)
    {
        manager.nextScene();
    }
    else if (e.currentTarget.name === 0)
    {
        manager.previousScene();
    }
    //console.log(e.currentTarget.name);
}
function createScenes()
{
    for (var i = 0; i < 5; i++)
    {
        var m_scene = new ExtendedScene();
        manager.addScenes(m_scene);
        m_scene.showDisplay();
    }
    stag.update();
}