SceneManager.prototype.m_stage = undefined;
SceneManager.prototype.m_cont = undefined;
SceneManager.prototype.actualscene = undefined;
SceneManager.prototype.scenes = [];
SceneManager.prototype.scenes_total = 0;
function SceneManager(stag)
{
    this.m_stage = stag;
    this.m_cont = new createjs.Container();
    this.m_stage.addChild(this.m_cont);
}
SceneManager.prototype.showSceneByIndex = function(index)
{
    if (this.validIndex(index))
    {
        if (!this.m_cont.contains(this.scenes[index].m_container))
        {
            console.log("ShowSceneByIndex:",index, "ADDED!");
            this.m_cont.addChild(this.scenes[index].m_container);
            this.scenes[index].doRun();
            this.m_stage.update();
        }
    }
};
SceneManager.prototype.hideSceneByIndex = function(index)
{
    if (this.validIndex(index))
    {
        if (this.m_cont.contains(this.scenes[index].m_container))
        {
            console.log("hideSceneByIndex:",index, "REMOVED!");
            this.m_cont.removeChild(this.scenes[index].m_container);
            this.scenes[index].doStop();
        }
    }
};
SceneManager.prototype.validIndex = function (index)
{
    //console.log("Index", index, "is valid:",(index >= 0 && index <= this.scenes_total));
    return (index >= 0 && index <= this.scenes_total);
};
SceneManager.prototype.addScenes = function (e)
{
    for (var i = 0; i < arguments.length; i++)
    {
        if (arguments[i] instanceof Scene)
        {
            var sceneToBe = arguments[i];
            sceneToBe.m_index = this.scenes.length-1+1;
            this.scenes.push(sceneToBe);
        }
        else
        {
            console.log("ERROR: Arg n é instanceof scene");
        }
    }
    if (this.actualscene === undefined)
    {
        this.actualscene = 0;
        this.showSceneByIndex(this.actualscene);
    }
    this.scenes_total = this.scenes.length-1;
    console.log("addScenes Indexes:", this.scenes_total);
};
SceneManager.prototype.getSceneByIndex = function (index)
{
    if (this.validIndex(index))
    {
        return this.scenes[index];
    }
    else
    {
        console.log("Index NOT VALID at SceneManager.getSceneByIndex", index);
    }
};
SceneManager.prototype.removeSceneByIndex = function (index)
{
    if (this.validIndex(index))
    {
        this.scenes.splice(index, 1);
    }
};
SceneManager.prototype.nextScene = function()
{
    console.log("Will try to show next scene", this.actualscene+1, "am showing", this.actualscene, "of", this.scenes_total);
    if (this.scenes_total > 0)
    {
        if (this.actualscene < this.scenes_total)
        {
            this.hideSceneByIndex(this.actualscene);
            this.actualscene++;
            this.showSceneByIndex(this.actualscene);
        }
        else
        {
            console.log("ERROR: There is no next scene available", this.actualscene,"of", this.scenes_total);
        }
    }
    else
    {
        console.log("ERROR: There is no scene available");
    }
    console.log("I'm showing:",this.actualscene, "of", this.scenes_total);
};
SceneManager.prototype.previousScene = function()
{
    console.log("Will try to show previous scene", this.actualscene-1, "am showing", this.actualscene, "of", this.scenes_total);
    if (this.scenes_total > 0)
    {
        if (this.actualscene > 0)
        {
            this.hideSceneByIndex(this.actualscene);
            this.actualscene--;
            this.showSceneByIndex(this.actualscene);
        }
        else
        {
            console.log("ERROR: There is no next scene available", this.actualscene,"of", this.scenes_total);
        }
    }
    else
    {
        console.log("ERROR: There is no scene available");
    }
    console.log("I'm showing:",this.actualscene, "of", this.scenes_total);
};
SceneManager.prototype.destroy = function ()
{
    for(var i = 0; i <= this.scenes_total; i++)
    {
        this.scenes[i].destroy();
        this.hideSceneByIndex(i);
        this.removeSceneByIndex(i);
    }
    this.scenes = [];
};