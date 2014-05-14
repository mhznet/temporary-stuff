SceneManager.prototype.m_stage = undefined;
SceneManager.prototype.m_cont = undefined;
SceneManager.prototype.actualscene = undefined;
SceneManager.prototype.scenes = [];
function SceneManager(stag)
{
    this.m_stage = stag;
    this.m_cont = new createjs.Container();
    this.m_stage.addChild(this.m_cont);
}
SceneManager.prototype.showSceneById = function(index)
{
    if (this.validId(index))
    {
        if (!this.m_cont.contains(this.scenes[index].m_container))
        {
            console.log("ShowSceneById:",index, "ADDED!");
            this.m_cont.addChild(this.scenes[index].m_container);
            this.scenes[index].doRun();
        }
    }
};
SceneManager.prototype.hideSceneById = function(index)
{
    if (this.validId(index))
    {
        if (this.m_cont.contains(this.scenes[index].m_container))
        {
            console.log("hideSceneById:",index, "REMOVED!");
            this.m_cont.removeChild(this.scenes[index].m_container);
            this.scenes[index].doStop();
        }
    }
};
SceneManager.prototype.validId = function (index)
{
    console.log("Id", index, "is valid:",(index >= 0 && index < this.scenes.length));
    return (index >= 0 && index < this.scenes.length);
};
SceneManager.prototype.addScenes = function (e)
{
    for (var i = 0; i < arguments.length; i++)
    {
        if (arguments[i] instanceof Scene)
        {
            var num = 0;
            var sceneToBe = arguments[i];
            this.scenes.length === 0 ? num = 0 : num = 1;
            sceneToBe.id = this.scenes.length+num;
            this.scenes.push(sceneToBe);
        }
        else
        {
            console.log("ERROR: Arg n é instanceof scene");
        }
    }
    if (this.actualscene === undefined)
    {
        this.showSceneById(0);
    }
    console.log("addScenes:", this.scenes.length);
};
SceneManager.prototype.getSceneById = function (index)
{
    if (this.validId(index))
    {
        return this.scenes[index];
    }
    else
    {
        console.log("ID NOT VALID at SceneManager.getSceneById", index);
    }
};
SceneManager.prototype.removeSceneById = function (index)
{
    if (this.validId(index))
    {
        this.scenes.splice(index, 1);
    }
};
SceneManager.prototype.nextScene = function()
{
    if (this.scenes.length > 0)
    {
        if (this.actualscene < this.scenes.length)
        {
            this.hideSceneById(this.actualscene);
            this.showSceneById(++this.actualscene);
        }
        else
        {
            console.log("ERROR: There is no next scene available", this.actualscene,"of", this.scenes.length);
        }
    }
    else
    {
        console.log("ERROR: There is no scene available");
    }
};
SceneManager.prototype.previousScene = function()
{
    if (this.scenes.length > 0)
    {
        if (this.actualscene > 0)
        {
            this.hideSceneById(this.actualscene);
            this.showSceneById(--this.actualscene);
        }
        else
        {
            console.log("ERROR: There is no next scene available", this.actualscene,"of", this.scenes.length);
        }
    }
    else
    {
        console.log("ERROR: There is no scene available");
    }
};
SceneManager.prototype.destroy = function ()
{
    for(var i = 0; i < this.scenes.length; i++)
    {
        this.scenes[i].destroy();
        this.hideSceneById(i);
        this.removeSceneById(i);
    }
    this.scenes = [];
};