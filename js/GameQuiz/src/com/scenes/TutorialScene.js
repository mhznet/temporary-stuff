TutorialScene.prototype = Object.create(Scene.prototype);
TutorialScene.prototype.constructor = TutorialScene;
function TutorialScene()
{
    Scene.call(this);
}