var canvas;
var stag;
var manager;
function Main ()
{
    canvas = document.getElementById("myCanv");
    stag = new createjs.Stage(canvas);
    manager = new SceneManager(stag);
    createScenes();
    createBtns();
}
function createBtns()
{
    for (var i = 0; i < 2; i++)
    {
        var shape = new createjs.Shape();//200x100
        var init_x;
        i == 0 ? init_x = 10 : init_x = 100;
        shape.graphics.beginFill("green").drawRect(init_x,80,30,20);
        shape.myInitX = init_x;
        shape.name = i;
        shape.buttonmode = true;
        shape.addEventListener("click",handleClick);
        shape.addEventListener("mouseover",handleOver);
        shape.addEventListener("mouseout",handleOut);
        stag.addChild(shape);
        stag.enableMouseOver();
        stag.update();
    }
}
function handleOut(e)
{
    document.body.style.cursor= "default";
    var m_initial_x = e.currentTarget.myInitX;
    //console.log("initX", m_initial_x, e.currentTarget.name);
    e.currentTarget.graphics.clear().beginFill("green").drawRect(m_initial_x,80,30,20);
    stag.update();
}
function handleOver(e)
{
    document.body.style.cursor = "pointer";
    var m_initial_x = e.currentTarget.myInitX;
    //console.log("initX", m_initial_x, e.currentTarget.name);
    e.currentTarget.graphics.clear().beginFill("black").drawRect(m_initial_x,80,30,20);
    stag.update();
}
function handleClick(e)
{
    if (e.nativeEvent.button === 0)
    {
        if (e.currentTarget.name === 1)
        {
            manager.nextScene();
        }
        else if (e.currentTarget.name === 0)
        {
            manager.previousScene();
        }
    }
    //console.log(e.currentTarget.name, e.nativeEvent.button);
}
function createScenes()
{
    for (var i = 0; i < 5; i++)
    {
        var m_scene = new ExtendedScene(manager);
        manager.addScenes(m_scene);
        m_scene.showDisplay();
    }
    stag.update();
}