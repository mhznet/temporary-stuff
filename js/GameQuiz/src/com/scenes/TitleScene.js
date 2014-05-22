TitleScene.prototype = Object.create(Scene.prototype);
TitleScene.prototype.constructor = TitleScene;
TitleScene.prototype.goQA_btn = undefined;
TitleScene.prototype.goTutorial_btn = undefined;
function TitleScene(p_sce_manager)
{
    Scene.call(this, p_sce_manager);
    this.begin();
}
TitleScene.prototype.begin = function ()
{
    this.goQA_btn = new GenericButton(this,50, 50,"START",true,true,this.handleGOQAClick);
    this.goQA_btn.m_container.x = 0;
    this.goQA_btn.m_container.y = 0;
    this.m_container.addChild(this.goQA_btn.m_container);

    this.goTutorial_btn = new GenericButton(this,50, 50,"TUTORIAL",true,true, this.handleGOTutorialClick);
    this.goTutorial_btn.m_container.x = 0;
    this.goTutorial_btn.m_container.y = 100;
    this.m_container.addChild(this.goTutorial_btn.m_container);
};
TitleScene.prototype.handleGOTutorialClick = function ()
{
    if (this.m_manager !== undefined)
    {
        this.m_manager.showSceneByIndex(2);
    }
    else
    {
        console.log("m_manager of scenes is undefined");
    }
};
TitleScene.prototype.handleGOQAClick = function ()
{
    if (this.m_manager !== undefined)
    {
        this.m_manager.showSceneByIndex(1);
    }
    else
    {
        console.log("m_manager of scenes is undefined");
    }
};