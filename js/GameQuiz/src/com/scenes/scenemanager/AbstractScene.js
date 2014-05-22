Scene.prototype.m_index = undefined;
Scene.prototype.isRunning = false;
Scene.prototype.m_container = undefined;
Scene.prototype.m_manager = undefined;
function Scene(p_scene_manager)
{
    this.m_manager = p_scene_manager;
    this.m_container = new createjs.Container();
}
Scene.prototype.doRun = function ()
{
    if (this.isRunning === false)
    {
        this.isRunning = true;
    }
};
Scene.prototype.doStop = function ()
{
    if (this.isRunning === true)
    {
        this.isRunning = false;
    }
};
Scene.prototype.destroy = function ()
{
    this.m_index = null;
    this.isRunning = false;
};