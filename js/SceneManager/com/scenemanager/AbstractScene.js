Scene.prototype.id = undefined;
Scene.prototype.isRunning = false;
Scene.prototype.m_container = undefined;
function Scene()
{
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
    this.id = null;
    this.isRunning = false;
};